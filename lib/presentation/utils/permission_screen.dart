import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:sih_1/bottom_buttom_large.dart';
import 'package:sih_1/providers/permission_provider.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PermissionProvider>(
        builder: (context, permissionProvider, child) {
          return Column(
            children: [
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Please Allow Notification and Location Permissions for app to work",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      onTap: () async {
                        await _handleLocationPermission(permissionProvider);
                      },
                      title: const Text('Location Permission'),
                      subtitle: const Text('Click Only While Using the App'),
                      trailing: Checkbox(
                        value: permissionProvider.isLocationPermissionGranted,
                        onChanged: null,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await _handleBackgroundLocationPermission(
                            context, permissionProvider);
                      },
                      title: const Text('Background Location Permission'),
                      subtitle:
                          const Text('Select Always Allow in the settings'),
                      trailing: Checkbox(
                        value: permissionProvider
                            .isBackgroundLocationPermissionGranted,
                        onChanged: null,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await _handleNotificationPermission(permissionProvider);
                      },
                      title: const Text('Notification Permission'),
                      subtitle: const Text('Click Allow in the dialog'),
                      trailing: Checkbox(
                        value:
                            permissionProvider.isNotificationPermissionGranted,
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleLocationPermission(
      PermissionProvider permissionProvider) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      await permissionProvider.setLocationPermission(true);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      await permissionProvider.setLocationPermission(false);
    }
  }

  Future<void> _handleBackgroundLocationPermission(
      BuildContext context, PermissionProvider permissionProvider) async {
    final locationStatus = await Permission.location.status;
    if (locationStatus.isGranted) {
      final backgroundStatus = await Permission.locationAlways.request();
      if (backgroundStatus.isGranted) {
        await permissionProvider.setBackgroundLocationPermission(true);
      } else if (backgroundStatus.isPermanentlyDenied) {
        openAppSettings();
      } else {
        await permissionProvider.setBackgroundLocationPermission(false);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission not granted'),
          content: const Text('Please allow location permission to continue'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _handleNotificationPermission(
      PermissionProvider permissionProvider) async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      await permissionProvider.setNotificationPermission(true);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      await permissionProvider.setNotificationPermission(false);
    }
  }
}
