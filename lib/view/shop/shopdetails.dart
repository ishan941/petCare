import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/payment_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/loader.dart';
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
  void initState() {
    Future.delayed(Duration.zero, () {
      getDetails();
    });
    super.initState();
  }

  getDetails() async {
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
   await paymentProvider.getTokenFromSharedPref();
    paymentProvider.setUserName(petCareProvider.userFullName ?? "");
    paymentProvider.setPrice(widget.shop!.price ?? "");
    paymentProvider.setEmail(petCareProvider.userEmail ?? "");
    paymentProvider.setProductName(widget.shop!.product ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: SafeArea(
        child: Consumer<PaymentProvider>(
          builder: (context, paymentProvider, child) => Consumer<ShopProvider>(
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
                                                  color:
                                                      ColorUtil.primaryColor),
                                            ),
                                            Text(
                                              widget.shop!.price!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorUtil.primaryColor),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              "Rs 5000",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
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
                                          widget.shop!.condition!,
                                          style: subTitleText,
                                        ),
                                        Text(
                                          widget.shop!.description!,
                                          style: titleText,
                                          maxLines: 10,
                                          overflow: TextOverflow.clip,
                                        ),
                                        // TextFormField(
                                        //   onChanged: (value) {
                                        //     paymentProvider.price =
                                        //         widget.shop!.price!;
                                        //   },
                                        // ),
                                        // TextFormField(
                                        //   onChanged: (value) {
                                        //     paymentProvider.productName =
                                        //         widget.shop!.product!;
                                        //   },
                                        // ),
                                        // TextFormField(
                                        //   onChanged: (value) {
                                        //     paymentProvider.userName =
                                        //         widget.shop!.price!;
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 100),
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
                                  onTap: () => _showDialougeToAddCart(
                                      context, shopProvider),
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: ColorUtil.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('My cart')
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorUtil.primaryColor)),
                            onPressed: () async {
                              _showDialougeToBuy(
                                  context, shopProvider, paymentProvider);
                            },
                            child: Text('Buy Now'),
                          ),
                          // ElevatedButton(
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStatePropertyAll(
                          //           ColorUtil.primaryColor)),
                          //   onPressed: () {
                          //     // shopProvider.updateCartList(
                          //     //    widget.shop!);
                          //     _showAlertDialog(context, shopProvider);
                          //   },
                          //   child: Text('Add to cart'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDialougeToAddCart(
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
                  // shopProvider.updateCartList(widget.shop!);
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

  _showDialougeToBuy(BuildContext context, ShopProvider shopProvider,
      PaymentProvider paymentProvider) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
            "Do you want to buy " + widget.shop!.product!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          content: Text(
            "Choose a payment Method",
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () async {
                  Helper().pay(
                      context, int.parse(widget.shop!.price!), shopProvider);
                      if(shopProvider.isPaymentSucessfull == StatusUtil.success){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> FormLoader()), (route) => false);
                      }
                },
                child: Image.asset("assets/images/khalti.png",
                    height: 40, width: 70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
