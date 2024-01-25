import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/customs/consttextform.dart';
import 'package:project_petcare/view/shop/confirmation_item.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:project_petcare/view/shop/shope_sale.dart';
import 'package:provider/provider.dart';

class ShopAll extends StatefulWidget {
  ShopAll({
    Key? key,
  });

  @override
  State<ShopAll> createState() => _ShopAllState();
}

class _ShopAllState extends State<ShopAll> {
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true, initialScrollOffset: 0.0);

  @override
  void initState() {
    getShopData();
    super.initState();
  }

  getShopData() async {
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
    await shopProvider.itemDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtil.BackGroundColorColor,
          iconTheme: IconThemeData.fallback(),
          title: Text(
            "Shop",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopSale()));
                },
                icon: Icon(Icons.shopping_cart_outlined))
          ],
        ),
        body: Consumer<DonateProvider>(
          builder: (context, donateProvider, child) => 
          Consumer<ShopProvider>(
              builder: (context, shopProvider, child) => Stack(
                    children: [
                      ui(),
                      loader(donateProvider),
                    ],
                  )),
        ));
  }

  loader(DonateProvider donateProvider) {
    if (donateProvider.donageUtil == StatusUtil.loading) {
      Helper.simmerEffect(context);
    } else
    return  SizedBox();
  }
 

   ui() {
    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) =>  Consumer<DonateProvider>(
        builder: (context, donateProvider, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ConstTextForm(
                          hintText: "Search here...",
                          suffixIcon: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmationShopItem()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: 55,
                          height: 55,
                          child: Icon(Icons.sort),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Consumer<ShopProvider>(
              builder: (context, shopProvider, child) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: shopProvider.shopItemsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetails(
                                shop: shopProvider.shopItemsList[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 3,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 7),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height *
                                              0.15,
                                          width: MediaQuery.of(context).size.width,
                                          child: Image.network(
                                            shopProvider
                                                    .shopItemsList[index].images ??
                                                "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        loaderForShop(shopProvider),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  shopProvider.shopItemsList[index].product ?? "",
                                  style: textStyleSmallTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 244, 211, 67),
                                      size: 15,
                                    ),
                                    Text(
                                      "4.2/5 (453)",
                                      style: textStyleMini,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("Rs",
                                    style: textStyleSmallSized,
                                    ),
                                    Text(
                                      shopProvider.shopItemsList[index].price ??
                                        "",
                                        style: subTitleText,
                                        ),
                                  ],
                                ),
                                    
                               
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
   loaderForShop(ShopProvider shopProvider){
    if(shopProvider.shopIetms == StatusUtil.loading){
      Helper.simmerEffect(context);
    }
    else{
      return SizedBox();
    }
  }
}
