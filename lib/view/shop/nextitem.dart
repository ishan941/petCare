import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/pricing.dart';
import 'package:provider/provider.dart';

class NextDescription extends StatefulWidget {
  const NextDescription({super.key});

  @override
  State<NextDescription> createState() => _NextDescription();
}

class _NextDescription extends State<NextDescription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? description;
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
                      center: Text(twoofFourStr),
                      progressColor: ColorUtil.primaryColor,
                      onAnimationEnd: () {
                        shopProvider.updatePercent(0.5);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          writeDesStr,
                          style: subTitleText,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(nextStepPriceStr)
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
                                  Material(
                                    // color: ColorUtil.BackGroundColorColor,
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        shopProvider.description = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return descriptionValiStr;
                                        }
                                        return null;
                                      },
                                      maxLines: null, // Allow multiple lines
                                      decoration: InputDecoration(
                                          labelText: descriptionreqStr,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 150,
                                              horizontal:
                                                  20), // Adjust vertical padding
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  )
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NextPricing()));
                                  } else {
                                    Helper.snackBar(
                                        "Your Description Box is empty",
                                        context);
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
