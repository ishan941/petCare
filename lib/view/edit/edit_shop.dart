import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/post_item.dart';
import 'package:provider/provider.dart';

class EditShop extends StatefulWidget {
  const EditShop({super.key});

  @override
  State<EditShop> createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getShopItems();
    });

    super.initState();
  }

  getShopItems() async {
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
    shopProvider.getTokenFromSharedPref();
    // await shopProvider.getShopItems();
          await shopProvider.itemDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<ShopProvider>(
          builder: (context, shopProvider, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: shopProvider.shopItemsList.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                          // height: 180,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: Image.network(shopProvider
                                                  .shopItemsList[index]
                                                  .images ??
                                              "no data")),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      shopProvider.shopItemsList[index].product ??
                                          "Null",
                                      overflow: TextOverflow.fade,
                                      maxLines:
                                          2, // Set the maximum number of lines before text overflow
                                      softWrap: false, // Disallow text wrapping
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShopSale(
                                              shop: shopProvider
                                                  .shopItemsList[index])));
                                },
                                icon: Icon(Icons.edit)),
                            // IconButton(
                            //     onPressed: () {
                            //       // showDeleteConfirmationDialog(context, categoriesProvider, categoriesProvider.categoriesList[index].id!);
                            //       showAboutDialog(context: context);

                            //     }, icon: Icon(Icons.delete)),
                           IconButton(onPressed: (){
                            showDeleteConfirmationDialog(context, shopProvider, shopProvider.shopItemsList[index].id!);
                           }, icon: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context,
      ShopProvider shopProvider, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await shopProvider.deleteShopItem(id).then((value) async {
                  if (shopProvider.deleteShopItemUtil ==
                      StatusUtil.success) {
                    // await shopProvider.getShopItems();
                          await shopProvider.itemDetails();

                    Helper.snackBar("Delete Successfully", context);
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
