import 'package:flutter/material.dart';

class SearchFilterProvider with ChangeNotifier {
  String _filterBy = 'Beach Name';
  String _searchText = '';

  String get filterBy => _filterBy;
  String get searchText => _searchText;

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void setFilterBy(String value) {
    _filterBy = value;
    notifyListeners();
  }
}
