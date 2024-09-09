import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/models/beach_data_model.dart';
import 'package:sih_1/presentation/utils/search_card.dart';
import 'package:sih_1/providers/beach_data_provider.dart';
import 'package:sih_1/providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  final String? searchQuery;
  final String? filterBy;
  const SearchScreen(
      {super.key, required this.searchQuery, required this.filterBy});

  @override
  Widget build(BuildContext context) {
    List<BeachDataList> searchResults = [];
    if (filterBy == 'Beach Name') {
      searchResults = Provider.of<BeachDataProvider>(context, listen: false)
          .beachDataList
          .where((element) => element.beachName!
              .toLowerCase()
              .contains(searchQuery!.toLowerCase()))
          .toList();
    } else if (filterBy == 'City/Area Name') {
      searchResults = Provider.of<BeachDataProvider>(context, listen: false)
          .beachDataList
          .where((element) => element.area!
              .where((element) =>
                  element.toLowerCase().contains(searchQuery!.toLowerCase()))
              .isNotEmpty)
          .toList();
    } else if (filterBy == 'State Name') {
      searchResults = Provider.of<BeachDataProvider>(context, listen: false)
          .beachDataList
          .where((element) =>
              element.state!.toLowerCase().contains(searchQuery!.toLowerCase()))
          .toList();
    } else {
      searchResults = Provider.of<BeachDataProvider>(context, listen: false)
          .beachDataList
          .where((element) =>
              element.beachPosition!.lat!.toString().contains(searchQuery!) ||
              element.beachPosition!.long!.toString().contains(searchQuery!))
          .toList();
    }
    log(searchResults.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Consumer<SearchFilterProvider>(
          builder: (context, searchFilterProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'You searched for "${searchFilterProvider.searchText}" in "${searchFilterProvider.filterBy}"',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                searchResults.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: searchcard(searchResults[index], context));
                        })
                    : const Center(
                        child: Text(
                        'No beaches found with your search! Try again with different keywords.',
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
