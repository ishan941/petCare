import 'package:flutter/material.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:provider/provider.dart'; // Assuming ApiService class definition

class SearchHere extends StatefulWidget {
  const SearchHere({Key? key}) : super(key: key);

  @override
  State<SearchHere> createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSellingPetData();
  }

  // Method to fetch selling and donated pet data based on search query
  void getSellingPetData() async {
    var sellingProvider = Provider.of<SellingPetProvider>(context, listen: false);
    var token = sellingProvider.getTokenFromSharedPref();// Assuming you have a method to get the token
    var query = _searchController.text;
    // await sellingProvider.getSearchSellingPet(token);
    // await sellingProvider.getSearchDonatePet(token, query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SearchBar(onChanged: (_) {}, controller: _searchController)
        ],
      ),
    );
  }
}
