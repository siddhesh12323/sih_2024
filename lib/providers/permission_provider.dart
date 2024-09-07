import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionProvider with ChangeNotifier {
  bool _isLocationPermissionGranted = false;
  bool _isNotificationPermissionGranted = false;
  bool _isBackgroundLocationPermissionGranted = false;

  PermissionProvider() {
    _loadPermissions();
  }

  bool get isLocationPermissionGranted => _isLocationPermissionGranted;
  bool get isNotificationPermissionGranted => _isNotificationPermissionGranted;
  bool get isBackgroundLocationPermissionGranted =>
      _isBackgroundLocationPermissionGranted;

  Future<void> _loadPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    _isLocationPermissionGranted =
        prefs.getBool('isLocationPermissionGranted') ?? false;
    _isNotificationPermissionGranted =
        prefs.getBool('isNotificationPermissionGranted') ?? false;
    _isBackgroundLocationPermissionGranted =
        prefs.getBool('isBackgroundLocationPermissionGranted') ?? false;
    notifyListeners();
  }

  Future<void> setNotificationPermission(bool value) async {
    _isNotificationPermissionGranted = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationPermissionGranted', value);
    notifyListeners();
  }

  Future<void> setLocationPermission(bool value) async {
    _isLocationPermissionGranted = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLocationPermissionGranted', value);
    notifyListeners();
  }

  Future<void> setBackgroundLocationPermission(bool value) async {
    _isBackgroundLocationPermissionGranted = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBackgroundLocationPermissionGranted', value);
    notifyListeners();
  }
}
