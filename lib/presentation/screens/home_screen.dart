// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/presentation/utils/calculate_safety_index_and_verdict.dart';
import 'package:sih_1/providers/beach_data_provider.dart';
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
  // final List<BeachDataList> _beachDataList = [];

  @override
  void initState() {
    super.initState();
    // Fetch the beach data when the screen initializes
    Provider.of<BeachDataProvider>(context, listen: false).fetchBeachData();
  }

  // Future<List<BeachDataList>> fetchData() async {
  //   final response = await http.get(
  //     Uri.parse('https://shi2024-api.onrender.com/get_beach_data'),
  //   );
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     for (var i in data) {
  //       _beachDataList.add(BeachDataList.fromJson(i));
  //     }
  //     return _beachDataList;
  //   } else {
  //     // If the server returns an error, throw an exception
  //     throw Exception('Failed to load data');
  //   }
  // }

  final List<String> _filterOptions = [
    'Beach Name',
    'City/Area Name',
    'State Name',
    'Coordinates',
  ];

  @override
  Widget build(BuildContext context) {
    // final SearchFilterProvider searchFilterProvider =
    //     Provider.of<SearchFilterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('ShoreAlert'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about_screen');
            },
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<BeachDataList>>(
              future: Provider.of<BeachDataProvider>(context).fetchBeachData(),
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
                  return Consumer<BeachDataProvider>(
                      builder: (context, provider, child) {
                    return FlutterMap(
                      mapController: _mapController,
                      options: const MapOptions(
                        initialCenter: LatLng(20.5937, 78.9629),
                        initialZoom: 4,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        for (int i = 0; i < provider.beachDataList.length; i++)
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(
                                    provider
                                        .beachDataList[i].beachPosition!.lat!,
                                    provider
                                        .beachDataList[i].beachPosition!.long!),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 650,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.network(
                                                  provider
                                                      .beachDataList[i].image!,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  // height: 100,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 12, 16, 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 12,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  provider
                                                                      .beachDataList[
                                                                          i]
                                                                      .beachName!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                    "${provider.beachDataList[i].area![0]}, ${provider.beachDataList[i].state!}"),
                                                              ],
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          const Icon(Icons
                                                              .location_on),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                                '${provider.beachDataList[i].beachPosition!.lat}, ${provider.beachDataList[i].beachPosition!.long}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Safety Index ",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            getBeachVerdict(
                                                                    provider.beachDataList[
                                                                        i])[0]
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        getBeachVerdict(provider
                                                                .beachDataList[
                                                            i])[1] as String,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pushNamed(
                                                              context,
                                                              '/beach_info_screen',
                                                              arguments: {
                                                                'beach_object':
                                                                    provider
                                                                        .beachDataList[i]
                                                              });
                                                        },
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .width,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .blueAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              'View Details',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: getBeachVerdict(
                                              provider.beachDataList[i])[2]
                                          as Color,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  });
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
                                              SnackBar snackBar = SnackBar(
                                                content: Text(
                                                    'You are searching by $value'),
                                                duration: const Duration(
                                                    milliseconds: 1500),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
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
                                SnackBar snackBar = const SnackBar(
                                  content: Text(
                                      'You need to type something to search!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              searchFilterProvider
                                  .setSearchText(_searchController.text);
                              Navigator.pushNamed(context, '/search_screen',
                                  arguments: {
                                    'search_query': _searchController.text,
                                    'filter_by': searchFilterProvider.filterBy,
                                  });
                              // SnackBar snackBar = SnackBar(
                              //   content: Text(
                              //       'Searching for ${_searchController.text} by ${searchFilterProvider.filterBy}'),
                              // );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
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
