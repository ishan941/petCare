import 'package:flutter/material.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => Column(
          children: [
            TextField(
              onChanged: (value) {
                // Update search term and notify listeners
              adoptProvider.
                    filterByPetName(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by pet name',
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
            Expanded(
              child: Consumer<AdoptProvider>(
                builder: (context, adoptProvider, child) {
                  // Access filtered list from the provider
                  List<Adopt> filteredList = adoptProvider.adoptList;
      
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      // Display items from the filtered list
                      return ListTile(
                        title: Text(filteredList[index].petName ?? ''),
                        // Add more details or actions as needed
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
