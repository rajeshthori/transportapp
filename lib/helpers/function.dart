import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

bool internet = true;

class ValueNotifying {
  ValueNotifier value = ValueNotifier(0);

  void incrementNotifier() {
    value.value++;
  }
}
String formatDuration(String? secondsStr) {
  if (secondsStr == null || secondsStr.isEmpty) return "00h:00M:00s";
  final totalSeconds = int.tryParse(secondsStr) ?? 0;

  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  return "${hours.toString().padLeft(2, '0')}h:"
      "${minutes.toString().padLeft(2, '0')}M:"
      "${seconds.toString().padLeft(2, '0')}s";
}



String convertIfNotPureNumber(String input) {
  // Agar pura input number hai (with . or ,), to jaisa hai waisa hi return karo
  if (double.tryParse(input.replaceAll(',', '.')) != null) {
    return input;
  }

  // Mixed string me number ko preserve karo, sirf text part ko handle karo
  return input.replaceAllMapped(
      RegExp(r'(\d+[\.,]?\d*)'),
          (match) => match.group(0)! // number part unchanged
  );
}




void showTopSnackbar(String message) {
  Get.snackbar(
    "Error", // Title
    message,
    snackPosition: SnackPosition.TOP,
    // Snackbar top par show hoga
    backgroundColor: Colors.red,
    // Background color red
    colorText: Colors.white,
    // Text color white
    margin: EdgeInsets.all(10),
    // Thoda margin add karna
    borderRadius: 8,
    // Border radius
    duration: Duration(seconds: 3), // Snackbar 3 seconds tak dikhega
  );
}

ValueNotifying valueNotifier = ValueNotifying();

ValueNotifying valueNotifierHome = ValueNotifying();

checkInternetConnection() async {
  Connectivity().onConnectivityChanged.listen((connectionState) {
    if (connectionState == ConnectivityResult.none) {
      internet = false;
      valueNotifierHome.incrementNotifier();
      valueNotifierHome.incrementNotifier();
    } else {
      internet = true;

      valueNotifierHome.incrementNotifier();
      valueNotifierHome.incrementNotifier();
    }

    print('internet is = ${internet}');
  });
}

Future<String?> getFromLocalStorage(String variable) async {
  // Initialize SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Generate the dynamic key
  String key = 'key_$variable'.toString();

  // Retrieve the value
  String? value = prefs.getString(key);

  print('Retrieved $value with key $key');
  return value;
}

Future<void> saveToLocalStorage(String variable, String value) async {
  // Initialize SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Generate the dynamic key
  String key = 'key_$variable';

  // Save the value
  await prefs.setString(key, value);

  print('Saved $value with key $key');
}
