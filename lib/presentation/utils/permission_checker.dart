import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/presentation/screens/home_screen.dart';
import 'package:sih_1/providers/permission_provider.dart';
import 'package:sih_1/presentation/utils/permission_screen.dart';

class PermissionChecker extends StatelessWidget {
  const PermissionChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final PermissionProvider permissionProvider =
        Provider.of<PermissionProvider>(context);
    return permissionProvider.isLocationPermissionGranted == true &&
            permissionProvider.isNotificationPermissionGranted == true
        ? HomeScreen()
        : const PermissionScreen();
  }
}
