import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:transportapp/utils/api_routes.dart';

import '../models/tripModel.dart';

class HomeController extends GetxController {
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

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final responseData = json.decode(response.body);

          if (responseData["status"] == "success") {
            final data = responseData["data"];
            if (data is List) {
              tripList.value = data.map((e) => TripModel.fromJson(e)).toList();
            } else {
              Fluttertoast.showToast(msg: "Unexpected data format");
              print("Expected a list, got: $data");
            }
          } else {
            Fluttertoast.showToast(msg: responseData["message"] ?? "Unknown error");
          }
        } catch (jsonError) {
          Fluttertoast.showToast(msg: "Failed to parse response");
          print("JSON parsing error: $jsonError");
        }
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch trips");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Network error: $e");
      print("Network exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
