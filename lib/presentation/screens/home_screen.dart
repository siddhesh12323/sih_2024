import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/providers/search_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  // LatLng _currentLocation = LatLng(20.5937, 78.9629);
  final MapController _mapController = MapController();
  // bool _locationLoaded = false;
  final List<BeachDataList> _beachDataList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentLocation();
  // }

  Future<List<BeachDataList>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://shi2024-api.onrender.com/get_beach_data'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var i in data) {
        _beachDataList.add(BeachDataList.fromJson(i));
      }
      return _beachDataList;
    } else {
      // If the server returns an error, throw an exception
      throw Exception('Failed to load data');
    }
  }

  final List<String> _filterOptions = [
    'Beach Name',
    'City/Area Name',
    'State Name',
    'Coordinates (just type latitude, longitude)',
  ];

  @override
  Widget build(BuildContext context) {
    // final SearchFilterProvider searchFilterProvider =
    //     Provider.of<SearchFilterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('App Name'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<BeachDataList>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  var data = snapshot.data!;
                  log(data.toString());
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(20.5937, 78.9629),
                      initialZoom: 4,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      for (var beach in data)
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(beach.beachPosition!.lat!,
                                  beach.beachPosition!.long!),
                              // ignore: avoid_unnecessary_containers
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(beach.image!),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                  height: 10,
                                                ),
                                                const Icon(Icons.location_on),
                                                Text(
                                                    '${beach.beachPosition!.lat}, ${beach.beachPosition!.long}'),
                                              ],
                                            ),
                                            Text(beach.beachName!),
                                            Text(beach.state!),
                                            Text(beach.area![0]),
                                            Text(beach.safetyFactor!
                                                .safetyFactorValue!
                                                .toString()),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                }
              }),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    // isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Start typing...',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // show a bottom modal sheet
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Consumer<SearchFilterProvider>(builder:
                                      (context, searchFilterProvider, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const SizedBox(width: 30),
                                            const Text(
                                              "Search by",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                            const SizedBox(width: 20),
                                          ],
                                        ),
                                        // SizedBox(height: 10),
                                        for (String option in _filterOptions)
                                          RadioListTile(
                                            groupValue:
                                                searchFilterProvider.filterBy,
                                            value: option,
                                            title: Text(option),
                                            onChanged: (value) {
                                              searchFilterProvider
                                                  .setFilterBy(value!);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        const SizedBox(height: 30),
                                      ],
                                    );
                                  });
                                });
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                        Consumer<SearchFilterProvider>(
                            builder: (context, searchFilterProvider, child) {
                          return IconButton(
                            onPressed: () {
                              if (_searchController.text.isEmpty) {
                                SnackBar snackBar = SnackBar(
                                  content: const Text(
                                      'Please enter a search query to proceed.'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              searchFilterProvider
                                  .setSearchText(_searchController.text);
                              Navigator.pushNamed(context, '/search_screen');
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Searching for ${_searchController.text} by ${searchFilterProvider.filterBy}'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(Icons.search),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _getCurrentLocation() async {
  //   try {
  //     // Check if location services are enabled
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       log('Location services are disabled.');
  //       return;
  //     }
  //     // Get current position
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     log('Location retrieved: ${position.latitude}, ${position.longitude}');
  //     setState(() {
  //       _currentLocation = LatLng(position.latitude, position.longitude);
  //       // _locationLoaded = true;
  //     });
  //   } catch (e) {
  //     log('Error retrieving location: $e');
  //   }
  // }
}
