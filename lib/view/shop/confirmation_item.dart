import 'package:flutter/material.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:provider/provider.dart';

class ConfirmationShopItem extends StatefulWidget {
  const ConfirmationShopItem({super.key});

  @override
  State<ConfirmationShopItem> createState() => _ConfirmationShopItemState();
}

class _ConfirmationShopItemState extends State<ConfirmationShopItem> {
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () {
  //     getdata();
  //   });

  //   super.initState();
  // }

  // getdata() async {
  //   var donateProvider = Provider.of<DonateProvider>(context, listen: false);
  //   await donateProvider.petDetails();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ShopProvider>(
        builder: (context, shopProvider, child) => Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopDetails(
                                        shop: shopProvider.shopItemsList[index],
                                      )));
                        },
                        child: Container(
                          child: Image.network(
                              shopProvider.shopItemsList[index].images ?? ""),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
