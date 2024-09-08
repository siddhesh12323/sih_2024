import 'package:flutter/material.dart';

class BeachInfoScreen extends StatelessWidget {
  const BeachInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beach Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Safe for recreational activities"),
            const SizedBox(
              height: 20,
            ),
            const Text("Beach Name, State Name"),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Text("Safety Score"),
                    trailing: Text("90"),
                  ),
                  ListTile(
                    leading: Text("Water Quality"),
                    trailing: Text("Good"),
                  ),
                  ListTile(
                    leading: Text("Sand Quality"),
                    trailing: Text("Good"),
                  ),
                  ListTile(
                    leading: Text("Crowd"),
                    trailing: Text("Moderate"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
