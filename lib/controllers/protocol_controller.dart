// controllers/protocol_controller.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/picturedata_model.dart';

class ProtocolController extends GetxController {
  // Form Controllers
  final TextEditingController pickupKmController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController deliveryKmController = TextEditingController();

  // Observable variables
  var pickupDateTime = ''.obs;
  var deliveryDateTime = ''.obs;

  // Tank and AdBlue selections
  var selectedTankPickup = ''.obs;
  var selectedAdBluePickup = ''.obs;
  var selectedTankDelivery = ''.obs;
  var selectedAdBlueDelivery = ''.obs;

  // Single select options (changed from multi-select)
  var selectedDefaultTakeover = ''.obs;
  var selectedPickupDirt = ''.obs;

  // Multi-select equipment (this remains multi-select)
  var selectedEquipment = <String>[].obs;

  // Image lists
  var pickupSpeedometerImages = <File>[].obs;
  var deliverySpeedometerImages = <File>[].obs;

  // Picture lists with metadata
  var pickupPictures = <PictureData>[].obs;
  var deliveryPictures = <PictureData>[].obs;

  // Signature data
  var driverPickupSignature = Rx<Uint8List?>(null);
  var handoverSignature = Rx<Uint8List?>(null);
  var deliveryVehicleSignature = Rx<Uint8List?>(null);

  // Dropdown options
  final List<String> tankOptions = ['1/4', '1/2', '3/4', 'Full', 'Empty'];
  final List<String> adBlueOptions = ['1/4', '1/2', '3/4', 'Full', 'Empty'];

  final List<String> defaultTakeoverOptions = [
    'Complete Vehicle Check',
    'Basic Check Only',
    'Documents Only',
    'No Check Required',
  ];

  final List<String> pickupDirtOptions = [
    'Interior',
    'Exterior',
    'Engine Bay',
    'Trunk',
    'No Dirt Found',
  ];

  final List<String> equipmentOptions = [
    'Spare Tire',
    'Jack',
    'First Aid Kit',
    'Warning Triangle',
    'Fire Extinguisher',
    'Tool Kit',
    'Manual',
    'GPS Device',
    'Phone Charger',
    'Floor Mats',
  ];

  @override
  void onClose() {
    pickupKmController.dispose();
    remarkController.dispose();
    deliveryKmController.dispose();
    super.onClose();
  }

  // Clear all form data
  void clearForm() {
    pickupKmController.clear();
    remarkController.clear();
    deliveryKmController.clear();

    pickupDateTime.value = '';
    deliveryDateTime.value = '';

    selectedTankPickup.value = '';
    selectedAdBluePickup.value = '';
    selectedTankDelivery.value = '';
    selectedAdBlueDelivery.value = '';

    selectedDefaultTakeover.value = '';
    selectedPickupDirt.value = '';

    selectedEquipment.clear();

    pickupSpeedometerImages.clear();
    deliverySpeedometerImages.clear();

    pickupPictures.clear();
    deliveryPictures.clear();

    driverPickupSignature.value = null;
    handoverSignature.value = null;
    deliveryVehicleSignature.value = null;
  }

  // Validate form data
  bool validateForm() {
    if (pickupDateTime.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select pickup date and time');
      return false;
    }

    if (pickupKmController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please enter pickup KM');
      return false;
    }

    if (pickupSpeedometerImages.isEmpty) {
      Get.snackbar('Validation Error', 'Please capture pickup speedometer image');
      return false;
    }

    if (selectedTankPickup.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select tank pickup level');
      return false;
    }

    if (selectedAdBluePickup.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select AdBlue pickup level');
      return false;
    }

    if (driverPickupSignature.value == null) {
      Get.snackbar('Validation Error', 'Please provide driver pickup signature');
      return false;
    }

    if (handoverSignature.value == null) {
      Get.snackbar('Validation Error', 'Please provide handover signature');
      return false;
    }

    if (deliveryDateTime.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select delivery date and time');
      return false;
    }

    if (deliveryKmController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please enter delivery KM');
      return false;
    }

    if (deliverySpeedometerImages.isEmpty) {
      Get.snackbar('Validation Error', 'Please capture delivery speedometer image');
      return false;
    }

    if (selectedTankDelivery.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select tank delivery level');
      return false;
    }

    if (selectedAdBlueDelivery.value.isEmpty) {
      Get.snackbar('Validation Error', 'Please select AdBlue delivery level');
      return false;
    }

    if (deliveryVehicleSignature.value == null) {
      Get.snackbar('Validation Error', 'Please provide delivery vehicle signature');
      return false;
    }

    return true;
  }

  // Submit protocol with multipart form data
  Future<void> submitProtocol() async {
    if (!validateForm()) {
      throw Exception('Form validation failed');
    }

    try {
      var uri = Uri.parse('YOUR_API_ENDPOINT_HERE'); // Replace with your actual API endpoint
      var request = http.MultipartRequest('POST', uri);

      // Add text fields
      request.fields['pickup_date_time'] = pickupDateTime.value;
      request.fields['pickup_km'] = pickupKmController.text;
      request.fields['tank_pickup'] = selectedTankPickup.value;
      request.fields['adblue_pickup'] = selectedAdBluePickup.value;
      request.fields['default_takeover'] = selectedDefaultTakeover.value;
      request.fields['pickup_dirt'] = selectedPickupDirt.value;
      request.fields['equipment'] = selectedEquipment.join(',');
      request.fields['remarks'] = remarkController.text;
      request.fields['delivery_date_time'] = deliveryDateTime.value;
      request.fields['delivery_km'] = deliveryKmController.text;
      request.fields['tank_delivery'] = selectedTankDelivery.value;
      request.fields['adblue_delivery'] = selectedAdBlueDelivery.value;

      // Add pickup speedometer images
      for (int i = 0; i < pickupSpeedometerImages.length; i++) {
        var file = pickupSpeedometerImages[i];
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'pickup_speedometer_images[]',
          stream,
          length,
          filename: 'pickup_speedometer_$i.${path.extension(file.path)}',
        );
        request.files.add(multipartFile);
      }

      // Add delivery speedometer images
      for (int i = 0; i < deliverySpeedometerImages.length; i++) {
        var file = deliverySpeedometerImages[i];
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'delivery_speedometer_images[]',
          stream,
          length,
          filename: 'delivery_speedometer_$i.${path.extension(file.path)}',
        );
        request.files.add(multipartFile);
      }

      // Add pickup pictures with metadata
      for (int i = 0; i < pickupPictures.length; i++) {
        var pictureData = pickupPictures[i];
        var stream = http.ByteStream(pictureData.image.openRead());
        var length = await pictureData.image.length();
        var multipartFile = http.MultipartFile(
          'pickup_pictures[]',
          stream,
          length,
          filename: 'pickup_picture_$i.${path.extension(pictureData.image.path)}',
        );
        request.files.add(multipartFile);

        // Add metadata
        request.fields['pickup_picture_${i}_datetime'] = pictureData.dateTime;
        request.fields['pickup_picture_${i}_location'] = pictureData.location;
      }

      // Add delivery pictures with metadata
      for (int i = 0; i < deliveryPictures.length; i++) {
        var pictureData = deliveryPictures[i];
        var stream = http.ByteStream(pictureData.image.openRead());
        var length = await pictureData.image.length();
        var multipartFile = http.MultipartFile(
          'delivery_pictures[]',
          stream,
          length,
          filename: 'delivery_picture_$i.${path.extension(pictureData.image.path)}',
        );
        request.files.add(multipartFile);

        // Add metadata
        request.fields['delivery_picture_${i}_datetime'] = pictureData.dateTime;
        request.fields['delivery_picture_${i}_location'] = pictureData.location;
      }

      // Add signatures as byte data
      if (driverPickupSignature.value != null) {
        var multipartFile = http.MultipartFile.fromBytes(
          'driver_pickup_signature',
          driverPickupSignature.value!,
          filename: 'driver_pickup_signature.png',
        );
        request.files.add(multipartFile);
      }

      if (handoverSignature.value != null) {
        var multipartFile = http.MultipartFile.fromBytes(
          'handover_signature',
          handoverSignature.value!,
          filename: 'handover_signature.png',
        );
        request.files.add(multipartFile);
      }

      if (deliveryVehicleSignature.value != null) {
        var multipartFile = http.MultipartFile.fromBytes(
          'delivery_vehicle_signature',
          deliveryVehicleSignature.value!,
          filename: 'delivery_vehicle_signature.png',
        );
        request.files.add(multipartFile);
      }

      // Add authorization header if needed
      // request.headers['Authorization'] = 'Bearer YOUR_TOKEN_HERE';

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Protocol submitted successfully: $responseData');

        // Clear form after successful submission
        clearForm();

        Get.snackbar(
          'Success',
          'Protocol submitted successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Server responded with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting protocol: $e');
      Get.snackbar(
        'Error',
        'Failed to submit protocol: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw e;
    }
  }

  // Helper method to get form data as Map for debugging
  Map<String, dynamic> getFormData() {
    return {
      'pickup_date_time': pickupDateTime.value,
      'pickup_km': pickupKmController.text,
      'tank_pickup': selectedTankPickup.value,
      'adblue_pickup': selectedAdBluePickup.value,
      'default_takeover': selectedDefaultTakeover.value,
      'pickup_dirt': selectedPickupDirt.value,
      'equipment': selectedEquipment,
      'remarks': remarkController.text,
      'delivery_date_time': deliveryDateTime.value,
      'delivery_km': deliveryKmController.text,
      'tank_delivery': selectedTankDelivery.value,
      'adblue_delivery': selectedAdBlueDelivery.value,
      'pickup_speedometer_images_count': pickupSpeedometerImages.length,
      'delivery_speedometer_images_count': deliverySpeedometerImages.length,
      'pickup_pictures_count': pickupPictures.length,
      'delivery_pictures_count': deliveryPictures.length,
      'has_driver_pickup_signature': driverPickupSignature.value != null,
      'has_handover_signature': handoverSignature.value != null,
      'has_delivery_vehicle_signature': deliveryVehicleSignature.value != null,
    };
  }
}