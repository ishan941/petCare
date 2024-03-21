import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/ads_provider.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/adopt/adoptDetails.dart';
import 'package:project_petcare/view/adopt/adotp.dart';
import 'package:project_petcare/view/categories.dart/categoriesDetails.dart';
import 'package:project_petcare/view/dashboard/categories.dart';
import 'package:project_petcare/view/ourservice/ourserviceSeeMore.dart';
import 'package:project_petcare/view/ourservice/ourservicedto.dart';
import 'package:project_petcare/view/profile/account.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1), () {
      getToken();
      getGreeting();
      getUserName();
      getCategories();
      getAds();
      getDashService();
      getdata();
      getDashServiceDetailsinUi();
      getAdoptdata();
    });

    super.initState();
    _scrollController = ScrollController();
  }

  getGreeting() async {
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    await petCareProvider.getTokenFromSharedPref();
    await petCareProvider.getUserName();
    await petCareProvider.updateGreeting();
    // await petCareProvider.getProfilePicture();
  }

  getdata() async {
    var donateProvider = Provider.of<DonateProvider>(context, listen: false);
    await donateProvider.petDetails();
  }

  getUserName() async {
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    await signUpProvider.readUserFromSharedPreferences();
  }

  getDashServiceDetailsinUi() async {
    var ourServiceProvider =
        Provider.of<OurServiceProvider>(context, listen: false);
    await ourServiceProvider.dashServiceDetails();
  }

  getAdoptdata() async {
    var adoptProvider = Provider.of<AdoptProvider>(context, listen: false);
    await adoptProvider.getAdoptdata();
  }

  getToken() {
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    signUpProvider.getTokenFromSharedPref();
  }

  getCategories() async {
    var categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.getTokenFromSharedPref();
    await categoriesProvider.getCategoriesData();
  }

  getAds() async {
    var adsProvider = Provider.of<AdsProvider>(context, listen: false);
    await adsProvider.getTokenFromSharedPref();
    await adsProvider.getAdsImage();
  }

  getDashService() async {
    var ourServiceProvider =
        Provider.of<OurServiceProvider>(context, listen: false);
    await ourServiceProvider.getTokenFromSharedPref();
    await ourServiceProvider.getDashService();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.primaryColor,
        body: SafeArea(
          child: Consumer<ShopProvider>(
            builder: (
              context,
              shopProvider,
              child,
            ) =>
                CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor:  ColorUtil.primaryColor,
                  expandedHeight: 130,
                  pinned: true,
                  elevation: 0,
                  // snap: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Pet Care",
                                style: TextStyle(fontSize: 25),
                              )
                              // Text(
                              //     "Hello ${Provider.of<SignUpProvider>(context).userName}"),
                              // Text(
                              //   Provider.of<PetCareProvider>(context).greeting,
                              //   style: TextStyle(fontSize: 12),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      background: dashHead(
                        Provider.of<SignUpProvider>(context),
                        context,
                        shopProvider,
                        Provider.of<PetCareProvider>(context),
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Consumer<OurServiceProvider>(
                        builder: (context, ourServiceProvider, child) => ui(),
                      ),
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

  Widget ui() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Consumer<AdsProvider>(
          builder: (context, adsProvider, child) => Consumer<ShopProvider>(
            builder: (context, shopProvider, child) =>
                Consumer<CategoriesProvider>(
              builder: (context, categoriesProvider, child) =>
                  Consumer<SignUpProvider>(
                builder: (context, signUpProvider, child) =>
                    Consumer<PetCareProvider>(
                  builder: (context, petCareProvider, child) =>
                      Consumer<OurServiceProvider>(
                    builder: (context, ourServiceProvider, child) =>
                        Consumer<DonateProvider>(
                      builder: (context, donateProvider, child) =>
                          Consumer<AdoptProvider>(
                        builder: (context, adoptProvider, child) => Column(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Container(
                                    color: Color(0XFFE5E8FF),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          categoriesProvider
                                                      .categoriesList.isEmpty &&
                                                  adsProvider
                                                      .adsImageList.isEmpty &&
                                                  ourServiceProvider
                                                      .dashApiServiceList
                                                      .isEmpty
                                              ? Column(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/sadpet.webp"),
                                                    Text(
                                                        'No data availabele at the moment...')
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    categories(
                                                        categoriesProvider),
                                                    ads(adsProvider),
                                                    // ourservice(context),
                                                    _ourservice(context,
                                                        ourServiceProvider),
                                                    SizedBox(
                                                      height: 300,
                                                    )
                                                  ],
                                                ),
                                          categoriesProvider
                                                      .categoriesList.isEmpty ||
                                                  adsProvider
                                                      .adsImageList.isEmpty
                                              ? SizedBox(
                                                  height: 350,
                                                  child: Center(
                                                      child: Text(
                                                          "No data Available")),
                                                )
                                              : SizedBox(
                                                  height: 10,
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myFavourite(ShopProvider shopProvider) {
    return shopProvider.getshopIemsUtil == StatusUtil.loading
        ? SimmerEffect.shimmerEffect()
        : Container(
            height: MediaQuery.of(context).size.height * .325,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "My Favourite",
                        style: subTitleText,
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(color: ColorUtil.BackGroundColorColor),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          // color: Colors.red,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shopProvider.favouriteList.length,
                              itemBuilder: (BuildContext context, int index) {
                                // int itemIndex = shopProvider.shopItemsList
                                //     .indexOf(favouriteItems[index]);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShopDetails(
                                                  shop: shopProvider
                                                      .favouriteList[index],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 25,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height*.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .45,
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .134,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      shopProvider
                                                          .favouriteList[index]
                                                          .images!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .1191,
                                                    // color: Colors.red,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          // " ",
                                                          shopProvider
                                                              .favouriteList[
                                                                  index]
                                                              .product!,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: titleText,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          '',
                                                          // favouriteItems[index]
                                                          //     .description!,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textStyleMini,
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Rs. ${shopProvider.favouriteList[index].price!}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: titleText,
                                                            ),
                                                            Spacer(),
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child: Container(
                                                                color: ColorUtil
                                                                    .primaryColor,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .06,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .03,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .3,
                                              left: 120,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.9), // Shadow color
                                                          offset: Offset(6,
                                                              0), // Offset in x and y directions
                                                          blurRadius:
                                                              10, // Blur radius
                                                          spreadRadius: 6,
                                                        )
                                                      ]),
                                                  height: 30,
                                                  width: 30,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Transform.translate(
                                                      offset: Offset(-5, -5),
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            shopProvider
                                                                .updateFavouriteList(
                                                                    shopProvider
                                                                            .favouriteList[
                                                                        index]);
                                                          },
                                                          icon: Icon(
                                                              shopProvider.checkFavourite(
                                                                      shopProvider.favouriteList[
                                                                          index])
                                                                  ? Icons
                                                                      .favorite
                                                                  : Icons
                                                                      .favorite_border_rounded,
                                                              color: shopProvider.checkFavourite(
                                                                      shopProvider
                                                                              .favouriteList[
                                                                          index])
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .white)),
                                                    ),
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
                              }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget dashHead(SignUpProvider signUpProvider, BuildContext context,
      ShopProvider shopProvider, PetCareProvider petCareProvider) {
    return Container(
        // height: 190,
        child:
            dashAppBar(signUpProvider, petCareProvider, context, shopProvider));
  }

  Widget dashAppBar(
      SignUpProvider signUpProvider,
      PetCareProvider petCareProvider,
      BuildContext context,
      ShopProvider shopProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ${petCareProvider.userName},",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    petCareProvider.greeting,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Account()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 55,
                    width: 55,
                    child: petCareProvider.profilePicture != null
                        ? Image.network(
                            petCareProvider.profilePicture!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/emptypp.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstSearch(
            hintText: searchHereStr,
            prefixIcon: Icon(Icons.search),
          ),
        ),
        // myFavourite(shopProvider)
      ],
    );
  }

  Widget categories(CategoriesProvider categoriesProvider) {
    return categoriesProvider.categoriesList.isEmpty
        ? Text("No Data Available for Categories")
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Account()));
                      },
                      child: const Text(
                        categoriesStr,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoriesExplore()));
                      },
                      child: Text(exploreStr,
                          style: TextStyle(
                              color: ColorUtil.primaryColor, fontSize: 18)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .24,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesProvider.categoriesList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CategoriesDetails(
                            categories:
                                categoriesProvider.categoriesList[index],
                          );
                        }),
                      );
                    },
                    child: categoriesUi(context, categoriesProvider, index),
                  ),
                ),
              ),
            ],
          );
  }

  Widget categoriesUi(
      BuildContext context, CategoriesProvider categoriesProvider, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .15,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: categoriesProvider.getCategoriesUtil ==
                            StatusUtil.loading
                        ? SimmerEffect.normalSimmer(context)
                        : Image.network(
                            categoriesProvider
                                    .categoriesList[index].categoriesImage ??
                                "",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .045,
                width: MediaQuery.of(context).size.width * .35,
                decoration: BoxDecoration(
                    color: ColorUtil.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorUtil.primaryColor)),
                child: Center(
                  child: categoriesProvider.categoriesUtil == StatusUtil.loading
                      ? SimmerEffect.normalSimmer(context)
                      : Text(
                          categoriesProvider
                                  .categoriesList[index].categoriesName ??
                              "",
                          style: categoriesTitleText,
                        ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ads(AdsProvider adsProvider) {
    return adsProvider.adsImageList.isEmpty
        ? Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("No ads available RightNow"),
                    Text("Check your internet Connection or try again later")
                  ],
                ),
              ),
            ],
          )
        : ExpandableCarousel(
            options: CarouselOptions(
              // height: 400.0,

              // aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 8000),
              autoPlayCurve: Curves.decelerate,
              enlargeCenterPage: false,
              controller: CarouselController(),
              pageSnapping: true,
              // scrollDirection: Axis.horizontal,
              pauseAutoPlayOnTouch: true,
              pauseAutoPlayOnManualNavigate: true,
              pauseAutoPlayInFiniteScroll: false,
              // enlargeStrategy: CenterPageEnlargeStrategy.scale,
              disableCenter: false,
              showIndicator: true,
              slideIndicator: CircularSlideIndicator(itemSpacing: 20),
            ),
            items: [1, 2, 3, 4].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: adsProvider.adsImageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                adsProvider.adsImageList[index].adsImage ??
                                    "No data available",
                                fit: BoxFit.cover,
                              ),
                            )),
                  );
                },
              );
            }).toList(),
          );
  }

  Widget adoptdetails(AdoptProvider adoptProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    adoptStr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text("Your favourite pet",style: TextStyle(fontSize: 16),)
                ],
              ),
              Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdoptAll()));
                  },
                  child: Text(
                    seeAllStr,
                    style:
                        TextStyle(fontSize: 18, color: ColorUtil.primaryColor),
                  ))
            ],
          ),
        ),
        adoptProvider.adoptDetailsList.isEmpty
            ? Center(child: Text("No Data available for adopt"))
            : Container(
                height: 150,
                // width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: adoptProvider.adoptDetailsList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdoptDetails(
                                    adopt:
                                        adoptProvider.adoptDetailsList[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 3,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 4),
                              ),
                            ]),
                        // height: MediaQuery.of(context).size.height * .18,
                        // width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: Image.network(
                                    adoptProvider
                                            .adoptDetailsList[index].imageUrl ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      adoptProvider.adoptDetailsList[index]
                                              .petBreed ??
                                          "",
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      adoptProvider.adoptDetailsList[index]
                                              .petName ??
                                          "",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),

                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow gracefully
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              size: 15,
                                              color: ColorUtil.primaryColor),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Flexible(
                                            child: Text(
                                              adoptProvider
                                                      .adoptDetailsList[index]
                                                      .location ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget ourservice(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              const Text(
                ourServiceStr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OurServiceSeeMore()));
                  },
                  child: Text(
                    seeAllStr,
                    style:
                        TextStyle(fontSize: 18, color: ColorUtil.primaryColor),
                  )),
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ),
        Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) => SizedBox(
            height: MediaQuery.of(context).size.height * .26,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ourServiceProvider.dashServiceList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                    right: 15, top: 7, bottom: 7, left: 5),

                //full ourservice container
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OurServicesUiDto(
                                  ourService:
                                      ourServiceProvider.dashServiceList[index],
                                )));
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
                        color: const Color.fromARGB(255, 248, 248, 248),
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width * .33,

                    //inside container
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              //image container
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .12,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ourServiceProvider.dashServiceUtil ==
                                            StatusUtil.loading
                                        ? SimmerEffect.normalSimmer(context)
                                        : Image.network(
                                            ourServiceProvider
                                                    .dashServiceList[index]
                                                    .cpImage ??
                                                "",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            //end image container
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.037),

                            Text(
                              ourServiceProvider
                                      .dashServiceList[index].service ??
                                  "",
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            // view ourservice
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorUtil.primaryColor,
                                  borderRadius: BorderRadius.circular(7)),
                              height: 25,
                              width: MediaQuery.of(context).size.width * .2,
                              child: Center(
                                child: Text(
                                  viewStr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Center(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Color.fromARGB(255, 252, 252, 252),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(ourServiceProvider
                                    .dashServiceList[index].ppImage ??
                                ""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ourservice(
      BuildContext context, OurServiceProvider ourServiceProvider) {
    return ourServiceProvider.dashApiServiceList.isEmpty
        ? Text("No data available")
        : Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    const Text(
                      ourServiceStr,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OurServiceSeeMore()));
                        },
                        child: Text(
                          seeAllStr,
                          style: TextStyle(
                              fontSize: 18, color: ColorUtil.primaryColor),
                        )),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              Consumer<OurServiceProvider>(
                builder: (context, ourServiceProvider, child) => SizedBox(
                  height: MediaQuery.of(context).size.height * .26,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ourServiceProvider.dashApiServiceList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          right: 15, top: 7, bottom: 7, left: 5),

                      //full ourservice container
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OurServicesUiDto(
                                        ourService: ourServiceProvider
                                            .dashApiServiceList[index],
                                      )));
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
                              color: const Color.fromARGB(255, 248, 248, 248),
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * .33,

                          //inside container
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    //image container
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .12,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: ourServiceProvider
                                                      .dashServiceUtil ==
                                                  StatusUtil.loading
                                              ? SimmerEffect.normalSimmer(
                                                  context)
                                              : Image.network(
                                                  ourServiceProvider
                                                          .dashApiServiceList[
                                                              index]
                                                          .cpImage ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //end image container
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.037),

                                  Text(
                                    ourServiceProvider.dashApiServiceList[index]
                                            .service ??
                                        "",
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // view ourservice
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtil.primaryColor,
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 25,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Center(
                                      child: Text(
                                        viewStr,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Center(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor:
                                      Color.fromARGB(255, 252, 252, 252),
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      ourServiceProvider
                                              .dashApiServiceList[index]
                                              .ppImage ??
                                          ""),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
