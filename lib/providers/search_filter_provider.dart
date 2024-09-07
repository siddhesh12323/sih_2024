import 'package:flutter/material.dart';

class SearchFilterProvider with ChangeNotifier {
  String _filterBy = 'Beach Name';

  String get filterBy => _filterBy;

  void setFilterBy(String value) {
    _filterBy = value;
    notifyListeners();
  }
}
