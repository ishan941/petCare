import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/helper.dart';
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
    await signUpProvider.getTokenFromSharedPref();
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
                  backgroundColor: ColorUtil.primaryColor,
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
                          builder: (context, ourServiceProvider, child) =>
                              Stack(
                                children: [ui(), loader(ourServiceProvider)],
                              )),
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

  Widget loader(OurServiceProvider ourServiceProvider) {
    return ourServiceProvider.getDashServiceUtil == StatusUtil.loading
        ? Center(
            child: Helper.backdropFilter(context), // Loading indicator
          )
        : SizedBox();
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
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                color: ColorUtil.BackGroundColorColor,
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
                                                  .dashApiServiceList.isEmpty
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .3,
                                                    ),
                                                    // LoadingAnimationWidget
                                                    //     .hexagonDots(

                                                    //         color: ColorUtil
                                                    //             .primaryColor,
                                                    //         size: 100),
                                                   Helper.primaryLoader(),
                                                   SizedBox(height: 10,),
                                                    Text("Loading...",
                                                    style: appBarTitle,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                categories(categoriesProvider),
                                                // ads(adsProvider),
                                                // ourservice(context),
                                                // Image.asset(assets/images/streetpets.png),
                                                Container(
                                                  child: Image.asset(
                                                      "assets/images/streetpets.png"),
                                                ),
                                                _ourservice(context,
                                                    ourServiceProvider),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
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
          ),
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
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => CategoriesExplore()));
                    //   },
                    //   child: Text(exploreStr,
                    //       style: TextStyle(
                    //           color: ColorUtil.primaryColor, fontSize: 18)),
                    // ),
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
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
