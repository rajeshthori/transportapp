import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:transportapp/utils/api_routes.dart';

import '../models/tripModel.dart';

class Endedcontroller extends GetxController {
  var isLoading = false.obs;
  var tripList = <TripModel>[].obs;

  Future<void> fetchTripsWithPost(Map<String, dynamic> params) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.tripApi),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(params),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["status"] == "success") {
          final data = responseData["data"] as List;
          tripList.clear(); // clear previous data
          tripList.addAll(data.map((e) => TripModel.fromJson(e)).toList());
        } else {
          Fluttertoast.showToast(msg: responseData["message"]);
        }
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch trips");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
