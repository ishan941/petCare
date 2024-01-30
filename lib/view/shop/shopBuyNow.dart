import 'package:flutter/material.dart';
import 'package:project_petcare/model/shop.dart';

class ShopBuyNow extends StatelessWidget {
  final List<Shop> shopList;

  ShopBuyNow({Key? key, required this.shopList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Now"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shopList.length,
              itemBuilder: (context, index) {
                Shop shopItem = shopList[index];

                return ListTile(
                  title: Text(shopItem.product ?? ""),
                  subtitle: Text("Price: \$${shopItem.price}"),
                  // Add more details or customize based on your Shop model
                  // You can also add onTap functionality to navigate to the details page.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
