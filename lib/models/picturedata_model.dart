// models/picturedata_model.dart
import 'dart:io';

class PictureData {
  final File image;
  final String dateTime;
  final String location;

  PictureData({
    required this.image,
    required this.dateTime,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'location': location,
      'imagePath': image.path,
    };
  }

  // Create from Map
  factory PictureData.fromMap(Map<String, dynamic> map) {
    return PictureData(
      image: File(map['imagePath']),
      dateTime: map['dateTime'],
      location: map['location'],
    );
  }
}