import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, String message,
    {required bool isSuccess}) {
  final Color backgroundColor = isSuccess ? Colors.green : Colors.red;
  final Color textColor = Colors.white;

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void showTopSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      right: 10,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            message,
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () => overlayEntry.remove());
}

