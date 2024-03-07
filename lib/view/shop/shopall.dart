import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/shopFavourite.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';

import 'package:provider/provider.dart';

class ShopAll extends StatefulWidget {
  ShopAll({
    Key? key,
  });

  @override
  State<ShopAll> createState() => _ShopAllState();
}

class _ShopAllState extends State<ShopAll> {
  late TextEditingController _searchController = TextEditingController();
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true, initialScrollOffset: 0.0);

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getShopData();
    });

    super.initState();
  }

  getShopData() async {
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
    shopProvider.setFavourite(false);
    await shopProvider.itemDetails();
    await shopProvider.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtil.BackGroundColorColor,
          iconTheme: IconThemeData.fallback(),
          title: Text(
            shopStr,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyCart()));
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorUtil.primaryColor,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopFavourite()));
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
          ],
        ),
        body: Consumer<ShopProvider>(
          builder: (context, shopProvider, child) =>
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             child: Column(
              children: [
                ConstSearch(
                    prefixIcon: Icon(Icons.search),
                    
                    controller: _searchController,
                    onChanged: (_) {
                    //  _searchHere();
                    },
                     hintText: searchHereStr),
                    SizedBox(height: 20,),
                 _buildShopItems(shopProvider)
               
              ],
                     ),
           ),
        ),
      ),
    );
  }

  Widget _buildShopItems(ShopProvider shopProvider) {
    return shopProvider.getshopIemsUtil == StatusUtil.loading
        ? SimmerEffect.shimmerEffect()
        : shopProvider.shopItemsList.isEmpty
            ? Center(
                child: Text("No Data available"),
              )
            : Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Image.network(
                                              shopProvider.shopItemsList[index]
                                                      .images ??
                                                  "",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              IconButton(
                                                  onPressed: ()async {
                                                    shopProvider.
                                                       updateFavouriteList(shopProvider.shopItemsList[index]);
                                                  },
                                                  icon: Icon(
                                                      shopProvider
                                                              .checkFavourite(shopProvider.shopItemsList[index])
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border_rounded,
                                                      color: shopProvider
                                                              .checkFavourite(shopProvider.shopItemsList[index])
                                                          ? Colors.red
                                                          : Colors.white)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      shopProvider.shopItemsList[index].product ??
                                          "",
                                      style: textStyleSmallTitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 244, 211, 67),
                                          size: 15,
                                        ),
                                        Text(
                                          "4.2/5 (453)",
                                          style: textStyleMini,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Rs",
                                          style: textStyleSmallSized,
                                        ),
                                        Text(
                                          shopProvider
                                                  .shopItemsList[index].price ??
                                              "",
                                          style: subTitleText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    ),
                  ),
                ),
              );
  }
  _searchHere(ShopProvider shopProvider){
    // String searchValue = _searchController.text.toLowerCase();

    // List<Shop> shopList = shopProvider.itemDetails();

  }
}
