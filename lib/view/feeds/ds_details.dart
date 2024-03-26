import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

class Ds_details extends StatefulWidget {
  final Adopt? adopt;
  Ds_details({super.key, this.adopt});

  @override
  State<Ds_details> createState() => _Ds_detailsState();
}

class _Ds_detailsState extends State<Ds_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        body: Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Stack(
              children: [
                Column(
                  children: [
                    // ListView.builder(
                    //   itemCount: 1,
                    //   itemBuilder: (context, index) => Padding(
                    //     padding: const EdgeInsets.all(15),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            child: Image.network(widget.adopt!.imageUrl ?? ""),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.adopt!.petName ?? '',
                                  style: mainTitleText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.star,
                                //       size: 20,
                                //       color: Colors.orange,
                                //     ),
                                //     SizedBox(
                                //       width: 2,
                                //     ),
                                //     Text("4.5"),
                                //     SizedBox(
                                //       width: 30,
                                //     ),
                                //     SizedBox(
                                //       width: 3,
                                //     ),
                                //     Text('Reviews'),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                 Row(
                                  children: [
                                    Text("Phone - "),
                                    Text(
                                      widget.adopt!.ownerPhone ??
                                          "Invalid phone",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: ColorUtil.primaryColor),
                                    ),
                                  ],
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
                                      widget.adopt!.petPrice ?? "Free",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: ColorUtil.primaryColor),
                                    ),

                                    SizedBox(
                                      width: 30,
                                    ),

                                    // Text(
                                    //   "Rs 5000",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w400,
                                    //       decoration:
                                    //           TextDecoration.lineThrough,
                                    //       decorationThickness: 1.5),
                                    // ),
                                    // SizedBox(
                                    //   width: 7,
                                    // ),
                                    // Text("-15%")
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
                                  widget.adopt!.location ?? "",
                                  style: subTitleText,
                                ),
                                Text(
                                  widget.adopt!.description ?? "",
                                  style: titleText,
                                  maxLines: 10,
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                    //   ),
                    // ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
