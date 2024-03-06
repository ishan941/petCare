import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:provider/provider.dart';

class AdoptDetails extends StatefulWidget {
  final Adopt? adopt;

  AdoptDetails({super.key, this.adopt});

  @override
  State<AdoptDetails> createState() => _AdoptDetailsState();
}

class _AdoptDetailsState extends State<AdoptDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => Stack(
          children: [
            ui(context),
            Column(
              children: [],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
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
              ],
            ),
            Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
                            onTap: () => Navigator.pop(context),
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
                    SizedBox(),
                    SizedBox(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorUtil.primaryColor)),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopBuyNow(shopList: shopProvider.shopItemsList)));
                      },
                      child: Text('Contact'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorUtil.primaryColor)),
                      onPressed: () {
                        // _showAlertDialog(context);
                      },
                      child: Text('Add to cart'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget ui(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 3,
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Image.network(
                  widget.adopt!.imageUrl ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: ),
                  Text(
                    widget.adopt!.petbread ?? "No data availavile",
                    style: mainTitleText,
                  ),
                  Text(
                    widget.adopt!.petname ?? "",
                    style: titleText,
                  ),
                  Row(
                    children: [
                      Text(
                        petWeightStr,
                        style: subTitleText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "-  ${widget.adopt!.petweight ?? ""}",
                        style: textStyleSmallSized,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        petAgeStr,
                        style: subTitleText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.adopt!.petage ?? "",
                        style: titleText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        petSexStr,
                        style: subTitleText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.adopt!.gender ?? "",
                        style: titleText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        contactNumberStr,
                        style: subTitleText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.adopt!.phone ?? "",
                        style: titleText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        locationStr,
                        style: subTitleText,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.adopt!.location ?? "",
                        style: titleText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
}
