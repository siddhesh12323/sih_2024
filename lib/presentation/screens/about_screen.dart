import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final List<Map<Color, String>> safetyMarkers = [
    {Colors.red: 'Very Unsafe for Recreational Activities'},
    {Colors.orange: 'Unsafe for Recreational Activities'},
    {Colors.yellow: 'Moderately Safe for Recreational Activities'},
    {Colors.lightGreen: 'Safe for Recreational Activities'},
    {Colors.green: 'Very Safe for Recreational Activities'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView.builder(
        itemCount: safetyMarkers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.location_on,
                    color: safetyMarkers[index].keys.first,
                    size: 30,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(safetyMarkers[index].values.first,
                        style: TextStyle(fontSize: 18))),
              ],
            ),
          );
        },
      ),
    );
  }
}
