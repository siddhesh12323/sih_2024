import 'package:flutter/material.dart';

Widget bottomButtonLarge(VoidCallback onPressed, double height, double width,
    String text, Icon? icon) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            icon ?? const SizedBox(height: 0, width: 0),
          ],
        ),
      ),
    ),
  );
}
