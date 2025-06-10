import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_navigation.dart';
import '../utils/api_routes.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs; // Observable to manage loading state
  var validationErrors = {}.obs; // Observable for validation errors

// Focus nodes for each form field
  final Map<String, FocusNode> fieldFocusNodes = {
    'password': FocusNode(),
    'email': FocusNode(),
  }.obs;

  // Dispose the controllers when the controller is destroyed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    // Dispose all focus nodes
    fieldFocusNodes.values.forEach((focusNode) => focusNode.dispose());

    super.onClose();
  }


  Future<void> registerUser(BuildContext contxt) async {
    isLoading(true);

    try {
      final userData = {
        "email": emailController.text,
        "debitor_number": passwordController.text,
      };

      final response = await http.post(
        Uri.parse(ApiRoutes.login),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(userData),
      );

      var responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: responseData['message'],
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Extract user data
        var data = responseData['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', data['id']);
        await prefs.setString('name', data['name']);
        await prefs.setString('email', data['email']);
        await prefs.setString('phone', data['phone']);
        await prefs.setString('address', data['address']);
        await prefs.setBool('isLoggedIn', true);

        // Navigate to OTP screen or home
        Navigator.push(
        contxt,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        print('SocketException: ${e.message}');
      }
      Fluttertoast.showToast(msg: 'Network error: ${e.toString()}');
    }
    finally {
      isLoading(false);
    }
  }

  // Method to focus on the field with the first error
  void focusOnErrorField() {
    if (validationErrors.isNotEmpty) {
      final firstErrorField = validationErrors.keys.first;
      FocusNode? focusNode = fieldFocusNodes[firstErrorField];

      if (focusNode != null) {
        // Request focus for the field with the first error
        FocusScope.of(Get.context!).requestFocus(focusNode);
      }
    }
  }
}
