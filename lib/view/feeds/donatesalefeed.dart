import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/feedprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/donate/petsale_1.dart';
import 'package:provider/provider.dart';

class DonateSaleFeed extends StatefulWidget {
  const DonateSaleFeed({Key? key}) : super(key: key);

  @override
  State<DonateSaleFeed> createState() => _DonateSaleFeedState();
}

class _DonateSaleFeedState extends State<DonateSaleFeed>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadData();
  }

  void loadData() async {
    await Future.delayed(Duration.zero);
    getToken();
    await getFeed();
  }

  getToken() {
    var selliingProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    selliingProvider.getTokenFromSharedPref();
  }

  Future<void> getFeed() async {
    var selliingProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    selliingProvider.getTokenFromSharedPref();

    await selliingProvider.getSellingPetData();
    await selliingProvider.getDonatePetData();
  }

  List<String> petCategoriesList = ["Dog", "Cat", "Fish"];
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        body: SafeArea(
          child: Consumer<FeedProvider>(
            builder: (context, feedProvider, child) =>
                Consumer<SellingPetProvider>(
              builder: (context, sellingPetProvider, child) =>
                  Consumer<PetCareProvider>(
                builder: (context, petCareProvider, child) => CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: ColorUtil.BackGroundColorColor,
                      expandedHeight: 50.0,
                      elevation: 0,
                      floating: true,
                      pinned: false,
                      snap: true,
                      centerTitle: false,
                      // flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        children: [
                          Text(
                            'PetCare',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: ColorUtil.primaryColor),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _DonateOrSale(context);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    // SliverList(
                    //   delegate: SliverChildListDelegate(
                    //     [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         child: Row(
                    //           children: [
                    //             ClipRRect(
                    //               borderRadius: BorderRadius.circular(100),
                    //               child: Container(
                    //                 height: 60,
                    //                 width: 60,
                    //                 child: petCareProvider.profilePicture !=
                    //                         null
                    //                     ? Image.network(
                    //                         petCareProvider.profilePicture ??
                    //                             "",
                    //                         fit: BoxFit.cover,
                    //                       )
                    //                     : Image.asset(
                    //                         "assets/images/emptypp.png",
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             Text("You have something about pet?"),
                    //           ],
                    //         ),
                    //       ),
                    //       Divider(
                    //         thickness: 3,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return DefaultTabController(
                          // animationDuration: Duration(seconds: 9),
                          length: 2, // Number of tabs
                          child: Column(
                            children: [
                              Divider(
                                thickness: 6,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TabBar(
                                  controller: _tabController,
                                  labelColor: ColorUtil.primaryColor,
                                  unselectedLabelColor: Colors.black,
                                  indicatorColor: ColorUtil.primaryColor,
                                  tabs: [
                                    Tab(child: Text('Selling Pet')),
                                    Tab(child: Text('Donated Pet')),
                                    // Tab(child: Text('Last Visited')),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      sellingPetProvider
                                              .sellingPetList.isNotEmpty
                                          ? Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                // scrollDirection: Axis.vertical,
                                                itemCount: sellingPetProvider
                                                    .sellingPetList.length,
                                                itemBuilder: (context, index) =>
                                                    sellingPet(
                                                        sellingPetProvider,
                                                        index,
                                                        context),
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  // scrollDirection: Axis.vertical,
                                                  itemCount: feedProvider
                                                      .feedList.length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      fromFireBase(
                                                          feedProvider,
                                                          sellingPetProvider,
                                                          index,
                                                          context)),
                                            ),
                                      sellingPetProvider
                                              .donatePetList.isNotEmpty
                                          ? Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                // scrollDirection: Axis.vertical,
                                                itemCount: sellingPetProvider
                                                    .donatePetList.length,
                                                itemBuilder: (context, index) =>
                                                    donatePet(
                                                        sellingPetProvider,
                                                        index,
                                                        context),
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  // scrollDirection: Axis.vertical,
                                                  itemCount: feedProvider
                                                      .feedList.length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      fromFireBase(
                                                          feedProvider,
                                                          sellingPetProvider,
                                                          index,
                                                          context)),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sellingPet(
      SellingPetProvider sellingPetProvider, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      sellingPetProvider.sellingPetList[index].imageUrl ?? " ",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sellingPetProvider.sellingPetList[index].petName ?? " ",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    // onDoubleTap: () {
                    //   feedProvider.handleDoubleTap(index);
                    // },
                    child: sellingPetProvider.sellingPetList[index].imageUrl !=
                            null
                        ? Image.network(
                            sellingPetProvider.sellingPetList[index].imageUrl ??
                                " ",
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
                  ),
                ),

                Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                // : Icon(Icons.favorite_outline),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sellingPetProvider.sellingPetList[index].location ??
                            " ",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(height: 5),
                      // Container(
                      //   width: MediaQuery.of(context)
                      //           .size
                      //           .width *
                      //       .7,
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         size: 15,
                      //         color: ColorUtil.primaryColor,
                      //       ),
                      //       const SizedBox(
                      //         width: 2,
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           feedProvider.feedList[index]
                      //                   .contains ??
                      //               "",
                      //           maxLines: 1,
                      //           overflow:
                      //               TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // if (index != sellingPetProvider.sellingPetList.length)
          //   Divider(
          //     thickness: 3,
          //   ),
        ],
      ),
    );
  }

  Widget donatePet(
      SellingPetProvider sellingPetProvider, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      sellingPetProvider.donatePetList[index].imageUrl ?? " ",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  sellingPetProvider.donatePetList[index].petName ?? " ",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    // onDoubleTap: () {
                    //   feedProvider.handleDoubleTap(index);
                    // },
                    child: sellingPetProvider.donatePetList[index].imageUrl !=
                            null
                        ? Image.network(
                            sellingPetProvider.donatePetList[index].imageUrl ??
                                " ",
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
                  ),
                ),
                // feedProvider.feedList[index].isDoubleTapped?
                Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                // : Icon(Icons.favorite_outline),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sellingPetProvider.donatePetList[index].location ?? " ",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(height: 5),
                      // Container(
                      //   width: MediaQuery.of(context)
                      //           .size
                      //           .width *
                      //       .7,
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         size: 15,
                      //         color: ColorUtil.primaryColor,
                      //       ),
                      //       const SizedBox(
                      //         width: 2,
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           feedProvider.feedList[index]
                      //                   .contains ??
                      //               "",
                      //           maxLines: 1,
                      //           overflow:
                      //               TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (index != sellingPetProvider.donatePetList.length)
            Divider(
              thickness: 3,
            ),
        ],
      ),
    );
  }

  Widget fromFireBase(FeedProvider feedProvider,
      SellingPetProvider sellingPetProvider, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      feedProvider.feedList[index].profile ?? " ",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  feedProvider.feedList[index].name ?? "",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onDoubleTap: () {
                      feedProvider.handleDoubleTap(index);
                    },
                    child: feedProvider.feedList[index].image != null
                        ? Image.network(
                            feedProvider.feedList[index].image!,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
                  ),
                ),
                feedProvider.feedList[index].isDoubleTapped
                    ? Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_outline),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feedProvider.feedList[index].contains ?? "",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(height: 5),
                      // Container(
                      //   width: MediaQuery.of(context)
                      //           .size
                      //           .width *
                      //       .7,
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         size: 15,
                      //         color: ColorUtil.primaryColor,
                      //       ),
                      //       const SizedBox(
                      //         width: 2,
                      //       ),
                      //       Flexible(
                      //         child: Text(
                      //           feedProvider.feedList[index]
                      //                   .contains ??
                      //               "",
                      //           maxLines: 1,
                      //           overflow:
                      //               TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (index != feedProvider.feedList.length)
            Divider(
              thickness: 3,
            ),
        ],
      ),
    );
  }

  void _DonateOrSale(BuildContext context) async {
    String? choice = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Donate Or Sale"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Do you want to sell your pet or Donate? "),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Spacer(),
                TextButton(
                  child: const Text('Sale'),
                  onPressed: () {
                    Navigator.pop(context, 'Sale');
                  },
                ),
                TextButton(
                  child: const Text('Donate'),
                  onPressed: () {
                    Navigator.pop(context, 'Donate');
                  },
                ),
              ],
            ),
          ],
        );
      },
    );

    if (choice != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SellingPet(choice: choice),
        ),
      );
      // _CategoriesOfPet(context, choice);
    }
  }
}
