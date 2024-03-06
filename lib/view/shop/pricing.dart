import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:provider/provider.dart';

class NextPricing extends StatefulWidget {
  const NextPricing({super.key});

  @override
  State<NextPricing> createState() => _NextPricingState();
}

class _NextPricingState extends State<NextPricing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      center: Text(threeOfFourStr),
                      progressColor: ColorUtil.primaryColor,
                      onAnimationEnd: () {
                        shopProvider.updatePercent(0.75);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          placePriceStr,
                          style: subTitleText,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(nextStepChecking)
                      ],
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //product
                                  Container(
                                    // height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all()),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) {
                                              shopProvider.price = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return descriptionValiStr;
                                              }
                                              return null;
                                            },
                                            maxLines:
                                                null, // Allow multiple lines
                                            decoration: InputDecoration(
                                              labelText: priceReqStr,
                                              // prefixText: "Rs.  ",

                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal:
                                                      20), // Adjust vertical padding
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .045,
                                          width: 0.5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) {
                                              shopProvider.negotiable = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return descriptionValiStr;
                                              }
                                              return null;
                                            },
                                            maxLines:
                                                null, // Allow multiple lines
                                            decoration: const InputDecoration(
                                              labelText: negotiableStr,
                                              // prefixText: "Rs.  ",
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal:
                                                      10), // Adjust vertical padding
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    checkPriceStr,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .9,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    shopProvider.sendValueToFireBase();
                                    if (shopProvider.shopIetms ==
                                        StatusUtil.success) {
                                      Helper.snackBar(
                                          successfullySavedStr, context);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavBar()),
                                          (route) => false);
                                    }
                                    else{
                                      Helper.snackBar(failedToSaveStr, context);
                                    }
                                  } else {
                                    Helper.snackBar(valiPriceStr, context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation:
                                      5, // Adjust the elevation to control the shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary:
                                      ColorUtil.primaryColor, // Button color
                                  onPrimary: Colors.white, // Text color
                                  shadowColor: Colors.grey
                                      .withOpacity(1), // Shadow color
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
                            Container(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
