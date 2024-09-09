import 'package:flutter/material.dart';

ListTile beachInfoListTile(String leadingText, String trailingText) {
  return ListTile(
    leading: Text(
      leadingText,
      style: const TextStyle(fontSize: 18),
    ),
    trailing: Text(trailingText, style: const TextStyle(fontSize: 18)),
  );
}
