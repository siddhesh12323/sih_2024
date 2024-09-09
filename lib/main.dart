import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/presentation/animations/page_transition.dart';
import 'package:sih_1/presentation/routes/routes.dart';
import 'package:sih_1/presentation/utils/permission_checker.dart';
import 'package:sih_1/providers/beach_data_provider.dart';
import 'package:sih_1/providers/permission_provider.dart';
import 'package:sih_1/providers/search_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PermissionProvider()),
          ChangeNotifierProvider(create: (context) => SearchFilterProvider()),
          ChangeNotifierProvider(create: (context) => BeachDataProvider()),
        ],
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionsBuilder(),
                },
              ),
            ),
            // darkTheme: ThemeData(
            //   brightness: Brightness.dark,
            //   pageTransitionsTheme: PageTransitionsTheme(
            //     builders: {
            //       TargetPlatform.android: CustomPageTransitionsBuilder(),
            //       TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            //     },
            //   ),
            // ),
            onGenerateRoute: (settings) => _appRouter.onGenerateRoute(settings),
            title: 'ShoreAlert',
            debugShowCheckedModeBanner: false,
            home: const PermissionChecker(),
          );
        });
  }
}
