import 'package:flutter/material.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';

class ShopBuyNow extends StatelessWidget {
  List<PetShop> shopList = [];
  ShopBuyNow({super.key, required this.shopList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          for (var shop in shopList)
            ListTile(
              title: Text(shop.itemName ?? ''),
              subtitle: Text(shop.description ?? ''),
              // Add other widgets to display shop details
            ),
        ],
      ),
    );
  }
}
