import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/nextitem.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class ShopSale extends StatefulWidget {
  const ShopSale({super.key});

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
      body: SafeArea(
        child: Consumer<ShopProvider>(
          builder: (context, shopProvider, child) => Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)),
                    Text(
                      "Post items",
                      style: mainTitleText,
                    ),
                    SizedBox(
                      width: 45,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircularPercentIndicator(
                      radius: 30,
                      animation: true,
                      animateFromLastPercent: true,
                      percent: shopProvider.per,
                      center: Text(oneoffourStr),
                      progressColor: ColorUtil.primaryColor,
                      onAnimationEnd: () {
                        shopProvider.updatePercent(0.25);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          uploadPhotoStr,
                          style: subTitleText,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(nextStepDesStr)
                      ],
                    ),
                  ],
                ),
                Divider(),
                Container(
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ui(shopProvider, context),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NextDescription()));
                                } else {
                                  Helper.snackBar(
                                      "Please fill all the forms", context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation:
                                    5, // Adjust the elevation to control the shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: ColorUtil.primaryColor, // Button color
                                onPrimary: Colors.white, // Text color
                                shadowColor:
                                    Colors.grey.withOpacity(1), // Shadow color
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    nextStr,
                                    style: mainTitleText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImageForShop(shopProvider);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomPaint(
                          painter: DottedBorderPainter(),
                          child: shopProvider.image != null
                              ? Image.file(File(shopProvider.image!.path))
                              : Icon(Icons.add)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(tapToEditStr),
              SizedBox(
                height: 5,
              ),
              Text(tapandHoldRearrangeStr),
            ],
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
