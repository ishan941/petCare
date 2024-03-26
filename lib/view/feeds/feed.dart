import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/feedprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/feeds/petsale_1.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getFeed();
    });

    super.initState();
  }

  getFeed() async {
    var feedProvider = Provider.of<FeedProvider>(context, listen: false);
    await feedProvider.getFeedValueFromFireBase();
  }
 List<String> petCategoriesList= ["Dog", "Cat", "Fish"];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        body: SafeArea(
          child: Consumer<SellingPetProvider>(
            builder: (context, sellingPetProvider, child) =>  Consumer<PetCareProvider>(
              builder: (context, petCareProvider, child) => Consumer<FeedProvider>(
                builder: (context, feedProvider, child) =>
                 CustomScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
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
                              'PetFeed',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                   color: ColorUtil.primaryColor),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search,
                              color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> FeedForm()));
                              _DonateOrSale(context);
                            //  _CategoriesOfPet(context, choice);
                              },
                              icon: Icon(Icons.add,
                               color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        // expandedTitleScale: double.nan
                      // ),
                    ),
          
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: petCareProvider.profilePicture != null
                                        ? Image.network(
                                            petCareProvider.profilePicture ?? "",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/emptypp.png",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("You have something about pet?"),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration:
                                              BoxDecoration(shape: BoxShape.circle),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              feedProvider
                                                       .feedList[index].profile ??
                                                  " ",
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
                                          overflow: TextOverflow
                                              .ellipsis, // Handle overflow gracefully
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
                                            child: feedProvider
                                                        .feedList[index].image !=
                                                    null
                                                ? Image.network(
                                                    feedProvider
                                                        .feedList[index].image!,
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
                                          width: MediaQuery.of(context).size.width *
                                              .4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                feedProvider
                                                        .feedList[index].contains ??
                                                    "",
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
                                  if (index != feedProvider.feedList.length - 1)
                                    Divider(
                                      thickness: 3,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: feedProvider.feedList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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

  // void _CategoriesOfPet(BuildContext context, String choice) async {
  //   String? category = await showDialog<String>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Consumer<SellingPetProvider>(
  //         builder: (context, sellingPetProvider, child) => AlertDialog(
  //           title: const Text("Categories"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 DropdownButtonFormField<String>(
  //                   // value: sellingPetProvider.petCategory,
  //                   items: petCategoriesList
  //                       .map((category) => DropdownMenuItem(
  //                             value: category,
  //                             child: Text(category),
  //                           ))
  //                       .toList(),
  //                   onChanged: (value) {
  //                     sellingPetProvider.petCategories = value;
  //                   },
  //                   decoration: InputDecoration(
  //                     labelText: "Select Category",
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             Row(
  //               children: [
  //                 Spacer(),
  //                 TextButton(
  //                   child: const Text('Proceed'),
  //                   onPressed: () {
  //                     Navigator.pop(context, sellingPetProvider.petCategories);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );

  //   if (category != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SellingPet(choice: choice, category: category),
  //       ),
  //     );
  //   }
  // }
}