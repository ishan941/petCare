import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constDescriptionForm.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/loader.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class ShopSale extends StatefulWidget {
  final Shop? shop;
  ShopSale({super.key, this.shop});

  @override
  State<ShopSale> createState() => _ShopSaleState();
}

class _ShopSaleState extends State<ShopSale> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? product, condition, images, location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        title: Text(
          "Post item",
          style: appBarTitle,
        ),
      ),
      body: SafeArea(
        child: Consumer<ShopProvider>(
          builder: (context, shopProvider, child) => Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please note :",
                      style: subTitleText,
                    ),
                    Text("Please fill form correctly, "),
                    Text("if you added once you cannot edit later"),
                    Text("contain '*' must Fill"),
                    Divider(),
                    ui(shopProvider, context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ui(ShopProvider shopProvider, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //product
              ShopTextForm(
                labelText: productTileReqStr,
                onChanged: (value) {
                  shopProvider.product = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return productValiStr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    productExampleStr,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Spacer(),
                  Text(
                    upTo50,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              //condition
              ShopTextForm(
                onChanged: (value) {
                  shopProvider.condition = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return conditionValiStr;
                  }
                  return null;
                },
                labelText: conditionReqStr,
              ),
              SizedBox(
                height: 15,
              ),
              //location
              ShopTextForm(
                labelText: locationReqStr,
                onChanged: (value) {
                  shopProvider.location = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return locationValiStr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),

              InkWell(
                onTap: () {
                  pickImageForShop(shopProvider);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: shopProvider.imageUrl != null
                        ? Image.network(
                            shopProvider.imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : shopProvider.image != null
                            ? Image.file(
                                File(shopProvider.image!.path),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_library_outlined,
                                    color: ColorUtil.secondaryColor,
                                    size: 60,
                                  ),
                                  Text("Uploade image from Gallery")
                                ],
                              ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DescriptionTextForm(
                hintText: "Description about product/type*",
                onChanged: (value) {
                  shopProvider.description = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ShopTextForm(
                hintText: "Price*",
              ),
              SizedBox(
                height: 20,
              ),
              submit(context, shopProvider),
            ],
          ),
        ),
      ],
    );
  }

  Widget submit(BuildContext context, ShopProvider shopProvider) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * .9,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormLoader()));

                shopProvider.sendValueToFireBase();
                if (shopProvider.shopIetms == StatusUtil.success) {
                  Helper.snackBar(successfullySavedStr, context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                      (route) => false);
                } else {
                  Helper.snackBar(failedToSaveStr, context);
                  Navigator.pop(context);
                }
              } else {
                Helper.snackBar(valiPriceStr, context);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: ColorUtil.primaryColor, elevation: 5, // Adjust the elevation to control the shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), // Text color
              shadowColor: Colors.grey.withOpacity(1), // Shadow color
            ),
            child: Text(
              submitStr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  pickImageForShop(ShopProvider shopProvider) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    shopProvider.setImage(image);
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5;
    final double dashSpace = 5;
    double startY = 1.0;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
