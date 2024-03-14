import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/mycart.dart';
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
    getShopData();

    super.initState();
  }

  getShopData() async {
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
    Future.delayed(Duration(microseconds: 1), () async {
    await shopProvider.itemDetails();
    shopProvider.setFavourite(false);
    await shopProvider.getUser();
    });
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyCart()));
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
          builder: (context, shopProvider, child) => Padding(
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
                SizedBox(
                  height: 20,
                ),
                shopProvider.shopItemsList.isNotEmpty
                    ? _buildShopItems(shopProvider)
                    : Center(
                        child: Text("Sorry no data available"),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShopItems(ShopProvider shopProvider) {
    return Expanded(
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
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            child: shopProvider.getshopIemsUtil ==
                                    StatusUtil.loading
                                ? SimmerEffect.normalSimmer(context)
                                : Image.network(
                                    shopProvider.shopItemsList[index].images ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 15,
                          child: shopProvider.getshopIemsUtil ==
                                  StatusUtil.loading
                              ? SimmerEffect.textSimmer(context)
                              : Text(
                                  shopProvider.shopItemsList[index].product ??
                                      "",
                                  style: textStyleSmallTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .25,
                          child: shopProvider.getshopIemsUtil ==
                                  StatusUtil.loading
                              ? SimmerEffect.textSimmer(context)
                              : Row(
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .19,
                          child: shopProvider.getshopIemsUtil ==
                                  StatusUtil.loading
                              ? SimmerEffect.textSimmer(context)
                              : Row(
                                  children: [
                                    Text(
                                      "Rs",
                                      style: textStyleSmallSized,
                                    ),
                                    Text(
                                      shopProvider.shopItemsList[index].price ??
                                          "",
                                      style: subTitleText,
                                    ),
                                  ],
                                ),
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
    );
  }

  Widget _buildShimmerRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SimmerEffect.shimemrForShop(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SimmerEffect.shimemrForShop(),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SimmerEffect.shimemrForShop(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SimmerEffect.shimemrForShop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // _searchHere(ShopProvider shopProvider) {
  //   // String searchValue = _searchController.text.toLowerCase();

  //   // List<Shop> shopList = shopProvider.itemDetails();
  // }
}
