import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/providers/search_filter_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final List<String> _filterOptions = [
    'Beach Name',
    'City/Area Name',
    'State Name',
    'Coordinates (just type latitude, longitude)',
  ];

  @override
  Widget build(BuildContext context) {
    final SearchFilterProvider searchFilterProvider =
        Provider.of<SearchFilterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Name'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                // isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    IconButton(
                      onPressed: () {
                        SnackBar snackBar = SnackBar(
                          content: Text(
                              'Searching for ${_searchController.text} by ${searchFilterProvider.filterBy}'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
