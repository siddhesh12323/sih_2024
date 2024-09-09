import 'package:flutter/material.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/presentation/screens/about_screen.dart';
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
        final args = routeSettings.arguments;
        if (args is Map<String, dynamic> &&
            args.containsKey('search_query') &&
            args.containsKey('filter_by')) {
          final searchQuery = args['search_query'] as String;
          final filterBy = args['filter_by'] as String;
          return MaterialPageRoute(
            builder: (_) => SearchScreen(
              searchQuery: searchQuery,
              filterBy: filterBy,
            ),
          );
        }
        // If no arguments or incorrect arguments, navigate to default screen
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(
            searchQuery: null,
            filterBy: null,
          ),
        );
      case '/beach_info_screen':
        final args = routeSettings.arguments;
        if (args is Map<String, dynamic> && args.containsKey('beach_object')) {
          final beachDataList = args['beach_object'] as BeachDataList;
          return MaterialPageRoute(
            builder: (_) => BeachInfoScreen(beachDataList: beachDataList),
          );
        }
        // If no arguments or incorrect arguments, navigate to default screen
        return MaterialPageRoute(
          builder: (_) => const BeachInfoScreen(
            beachDataList: null,
          ),
        );
      case '/about_screen':
        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const PermissionChecker());
    }
  }
}
