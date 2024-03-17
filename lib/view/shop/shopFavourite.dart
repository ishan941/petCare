import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:provider/provider.dart';

class ShopFavourite extends StatefulWidget {
  const ShopFavourite({super.key});

  @override
  State<ShopFavourite> createState() => _ShopFavouriteState();
}

class _ShopFavouriteState extends State<ShopFavourite> {
  @override
  void initState() {
    getFavourite();
    super.initState();
  }

  getFavourite() async {
    var shopProvider = Provider.of<ShopProvider>(context, listen: false);
    await shopProvider.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        title: Text(
          "My Favourite",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        // centerTitle: true,
      ),
      body: Consumer<ShopProvider>(
        builder: (context, shopProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shopProvider.favouriteList.isEmpty
                ? favouriteListEmply()
                : favourites(shopProvider),
          ],
        ),
      ),
    );
  }

  Widget favourites(ShopProvider shopProvider) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: shopProvider.favouriteList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShopDetails(shop: shopProvider.favouriteList[index]),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  shopProvider.favouriteList[index].images ??
                                      "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        shopProvider.updateFavouriteList(
                                            shopProvider.favouriteList[index]);
                                      },
                                      icon: Icon(
                                          shopProvider.checkFavourite(
                                                  shopProvider
                                                      .favouriteList[index])
                                              ? Icons.favorite
                                              : Icons.favorite_border_rounded,
                                          color: shopProvider.checkFavourite(
                                                  shopProvider
                                                      .favouriteList[index])
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
                          shopProvider.favouriteList[index].product ?? "",
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
                              color: Color.fromARGB(255, 244, 211, 67),
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
                              shopProvider.favouriteList[index].price ?? "",
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
    );
  }

  Widget favouriteListEmply() => Center(
        child: Container(
            child: Column(
          children: [
            Text("Your Favourite List is empty"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopAll()));
                },
                child: Text("Visit shop"))
          ],
        )),
      );
}
