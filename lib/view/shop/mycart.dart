import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      getShopCart();
    });
   
    super.initState();
  }
  getShopCart()async{
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
   await shopProvider.getUser();
  }
  @override
  Widget build(BuildContext context, ) {
    var shopProvider = Provider.of<ShopProvider>(context);

    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: ColorUtil.BackGroundColorColor,
        // centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black,
          fontSize: 18
          ),
        ),
        
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: shopProvider.shopCartList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your Cart Looks empty.. "),
                  Text("Do you want to visit our shop ?"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ShopAll()));
                    },
                    child: Text("Visit shop"),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: shopProvider.shopCartList.length,
                      itemBuilder: (context, index) {
                        var cartItems = shopProvider.shopCartList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopDetails(
                                    shop: shopProvider.shopCartList[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        child: Image.network(
                                          cartItems.images ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItems.product!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                               _showAlertDialog(context, shopProvider, index);
                                              },
                                              icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
  void _showAlertDialog(BuildContext context, ShopProvider shopProvider, int index) {
 
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
           shopProvider.shopCartList[index].product!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: Text(
            "Do you want to remove this item form your cart List ?",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
               shopProvider.removeCart(shopProvider.shopCartList[index]);
                Navigator.of(context).pop();
                Helper.snackBar(
                  "You removed items form your cart",
                  context,
                );
              },
              child: Text("Remove"),
            ),
          ],
        );
      },
    );
  }
}
