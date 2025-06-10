import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'; // Import Material for BuildContext
import 'package:fluttertoast/fluttertoast.dart'; // Import Fluttertoast for toast messages
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class ApiService {

  // Method to retrieve the headers
  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      Fluttertoast.showToast(msg: 'Login expired');
      return {}; // Return empty headers if token is not found
    }

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Method for GET requests
  Future<dynamic> get(String endPoint, BuildContext context) async {
    try {
      final headers = await _getHeaders(); // Get the headers

      if (headers.isEmpty) {
        return null; // Return if headers are empty (login expired)
      }

      final response = await http.get(
        Uri.parse('$endPoint'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Parse the JSON response
      } else {
        _showErrorToast(context, response.statusCode as String);
        return null; // Return null on error
      }
    } catch (e) {
      _showErrorToast(context, e.toString());
      return null; // Return null on exception
    }
  }

  // Method for POST requests
  Future<dynamic> post(
      String endpoint, BuildContext context, Map<String, dynamic> body) async {
    try {
      final headers = await _getHeaders(); // Get the headers

      if (headers.isEmpty) {
        return null; // Return if headers are empty (login expired)
      }

      final response = await http.post(
        Uri.parse('$endpoint'),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Parse the JSON response
      } else {
        _showErrorToast(context, response.statusCode as String);
        return null; // Return null on error
      }
    } catch (e) {
      _showErrorToast(context, e.toString());
      return null; // Return null on exception
    }
  }

  // Method to show error toast
  void _showErrorToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<void> storeUserData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert Map to JSON string
    String userData = jsonEncode(data);

    // Store the JSON string in SharedPreferences
    await prefs.setString('user_data', userData);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the stored JSON string
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // Convert the JSON string back to a Map
      return jsonDecode(userData);
    }

    return null;
  }
}
