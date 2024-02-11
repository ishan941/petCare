import 'package:flutter/material.dart';
import 'package:project_petcare/provider/shop_provider.dart';

class SearchHere extends StatefulWidget {
  const SearchHere({super.key});

  @override
  State<SearchHere> createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          SearchBar(
            onChanged: (_){

            },
            controller: _searchController)
        ],
      ),
    );
  }
  searchHere(ShopProvider shopProvider){
    String query = _searchController.text.toLowerCase();
    


  }
}