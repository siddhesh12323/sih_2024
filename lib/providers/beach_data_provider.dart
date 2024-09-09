import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sih_1/models/beach_data_model.dart';
// import 'beach_data_list.dart';  // Import your BeachDataList class

class BeachDataProvider with ChangeNotifier {
  List<BeachDataList> _beachDataList = [];
  bool _isLoading = false;
  String _error = '';

  List<BeachDataList> get beachDataList => _beachDataList;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<List<BeachDataList>> fetchBeachData() async {
    try {
      final response = await http
          .get(Uri.parse('https://shi2024-api.onrender.com/get_beach_data'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _beachDataList =
            jsonData.map((data) => BeachDataList.fromJson(data)).toList();
        return _beachDataList;
      } else {
        throw Exception('Failed to load beach data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
