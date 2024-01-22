import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/shop.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:provider/provider.dart';

class ShopDetails extends StatefulWidget {
  Shop? shop;
   ShopDetails({super.key,
  this.shop,
  });

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  List<PetShop> shopList = [
    PetShop(
      itemName:
          "Pedigree Adult Dry Dog Food, (High Protein Variant)PEDIGREE With MarroBites Pieces Adult Dry Dog Food, Steak & Vegetable Flavor is full of the delicious meat and marrow ",
      price: "4,100",
      reviews: "107",
      description:
          "PEDIGREE With MarroBites Pieces Adult Dry Dog Food, Steak & Vegetable Flavor is full of the delicious meat and marrow flavors your dog craves.",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: SafeArea(
          child: Consumer<ShopProvider>(
            builder: (context, shopProvider, child) =>  Consumer<DonateProvider>(
                  builder: (context, donateProvider, child) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                              child: Image.network(
                                 widget.shop!.images!)),
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
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text(shopList[index].reviews!),
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
                                    Text('Rs.',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: ColorUtil.primaryColor)),
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
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 1.5),
                                    ), 
                                    SizedBox(width: 7,),
                                    Text("-15%")
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text("About", style: mainTitleText,),
                                SizedBox(height: 10,),
                                Text( widget.shop!.description!, style: titleText,),
                                SizedBox(height: 25,),
                                 Row(
                                       children: [
                                        Text(petWeightStr, style: subTitleText,),
                                        SizedBox(width: 5,),
                                         Text(donateProvider.donatePetList[index].petweight?? "",style: titleText,),
                                       ],
                                     ),
                                    Row(
                                       children: [
                                        Text(petAgeStr, style: subTitleText,),
                                        SizedBox(width: 5,),
                                         Text(donateProvider.donatePetList[index].petage?? "",style: titleText,),
                                       ],
                                     ),Row(
                                       children: [
                                        Text(petSexStr, style: subTitleText,),
                                        SizedBox(width: 5,),
                                         Text(donateProvider.donatePetList[index].gender?? "",style: titleText,),
                                       ],
                                     ),Row(
                                       children: [
                                        Text(contactNumberStr ,style: subTitleText,),
                                        SizedBox(width: 5,),
                                         Text(donateProvider.donatePetList[index].phone?? "",style: titleText,),
                                       ],
                                     ),Row(
                                       children: [
                                        Text(locationStr ,style: subTitleText,),
                                        SizedBox(width: 5,),
                                         Text( widget.shop!.location?? "",style: titleText,),
                                       ],
                                     ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
                  ),
                ),
          )),
    );
  }
}

class PetShop {
  String? itemName, reviews, price, description;
  PetShop({
    this.description,
    this.itemName,
    this.price,
    this.reviews,
  });
}
