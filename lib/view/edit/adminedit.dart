import 'package:flutter/material.dart';
import 'package:project_petcare/view/edit/edit_ads.dart';
import 'package:project_petcare/view/edit/edit_donate.dart';
import 'package:project_petcare/view/edit/edit_ourserice.dart';
import 'package:project_petcare/view/edit/edit_selling.dart';
import 'package:project_petcare/view/edit/edit_shop.dart';
import 'package:project_petcare/view/edit/edit_category.dart';

class EditListUi extends StatefulWidget {
  const EditListUi({super.key});

  @override
  State<EditListUi> createState() => _EditListUiState();
}

class _EditListUiState extends State<EditListUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditCategory()));
              },
              child: Text("category"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditAds()));
              },
              child: Text("Ads"),
            ),
            
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditOurService()));
              },
              child: Text("OurService"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditShop()));
              },
              child: Text("Shop"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditSelling()));
              },
              child: Text("Selling"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditDonate()));
              },
              child: Text("Donate"),
            ),
          ],
        ),
      ),
    );
  }
}
