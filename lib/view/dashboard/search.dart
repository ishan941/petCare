import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/view/shop/shoptextform.dart'; // Import this package

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    // Set the status bar color to white
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: CustomScrollView(
        primary: true,
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            title: const Text("Search"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  // handle the press
                },
              ),
            ],
            floating: false, // Set this to false to keep SliverAppBar always visible
            pinned: true, // Set this to true to keep SliverAppBar at the top of the screen
          ),
          // SliverToBoxAdapter is used to place non-sliver widgets within CustomScrollView
          SliverToBoxAdapter(
            child: YourContentWidget(), // Replace with your content widget
          ),
        ],
      ),
    );
  }
}


class YourContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       SizedBox(height: 30,),
       Container(
        height: 40,
        width: MediaQuery.of(context).size.width*.8,
         child: ShopTextForm(
          hintText: "Search Here",
         ),
       ),
        
      ],
    );
  }
}
