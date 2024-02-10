import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/shopBuyNow.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

class ShopDetails extends StatefulWidget {
  final Shop? shop;

  ShopDetails({this.shop});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: SafeArea(
        child: Consumer<ShopProvider>(
          builder: (context, shopProvider, child) => Consumer<DonateProvider>(
            builder: (context, donateProvider, child) => Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  child: Image.network(widget.shop!.images!),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.shop!.product!,
                                        style: mainTitleText,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text("4.5"),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text('Reviews'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Rs.',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: ColorUtil.primaryColor),
                                          ),
                                          Text(
                                            widget.shop!.price!,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: ColorUtil.primaryColor),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "Rs 5000",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationThickness: 1.5),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text("-15%")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "About",
                                        style: mainTitleText,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.shop!.description!,
                                        style: titleText,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                // Container at the bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * .2,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopAll())),
                                child: Icon(
                                  Icons.storefront_outlined,
                                  color: ColorUtil.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Shop')
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * .2,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () =>
                                    _showAlertDialog(context, shopProvider),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: ColorUtil.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Add to cart')
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorUtil.primaryColor)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopBuyNow(
                                        shopList: shopProvider.shopItemsList)));
                          },
                          child: Text('Buy Now'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorUtil.primaryColor)),
                          onPressed: () {
                            // shopProvider.updateCartList(
                            //    widget.shop!);
                            _showAlertDialog(context, shopProvider);
                          },
                          child: Text('Add to cart'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(
    BuildContext context,
    ShopProvider shopProvider,
  ) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
            widget.shop!.product!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: Text(
            "Do you want to add this item to your Cart ?",
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
                if (shopProvider.shopCartList.contains(widget.shop)) {
                  Helper.snackBar("Already on the Cart", context);
                  Navigator.pop(context);
                } else {
                  shopProvider.updateCartList(widget.shop!);
                  Navigator.of(context).pop();
                  Helper.snackBar(
                    "Your item has been successfully saved to your cart. Please visit My Cart.",
                    context,
                  );
                }
              },
              child: Text("Add to Cart"),
            ),
          ],
        );
      },
    );
  }
}
