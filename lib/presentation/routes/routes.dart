import 'package:flutter/material.dart';
import 'package:sih_1/presentation/screens/beach_info_screen.dart';
import 'package:sih_1/presentation/screens/home_screen.dart';
import 'package:sih_1/presentation/screens/search_screen.dart';
import 'package:sih_1/presentation/utils/permission_checker.dart';
import 'package:sih_1/presentation/utils/permission_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const PermissionChecker(),
        );
      case '/home_screen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/permission_screen':
        return MaterialPageRoute(
          builder: (_) => const PermissionScreen(),
        );
      case '/permission_checker':
        return MaterialPageRoute(
          builder: (_) => const PermissionChecker(),
        );
      case '/search_screen':
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case '/beach_info_screen':
        return MaterialPageRoute(
          builder: (_) => const BeachInfoScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const PermissionChecker());
    }
  }
}
