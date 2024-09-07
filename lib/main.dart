import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/presentation/utils/permission_checker.dart';
import 'package:sih_1/providers/permission_provider.dart';
import 'package:sih_1/providers/search_filter_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PermissionProvider()),
          ChangeNotifierProvider(create: (context) => SearchFilterProvider()),
        ],
        builder: (context, child) {
          return const MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: PermissionChecker(),
          );
        });
  }
}
