import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/mypet_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/adoption/ds_details.dart';
import 'package:project_petcare/view/profile/add_my_pet.dart';
import 'package:project_petcare/view/profile/verifyYourAccount_1.dart';
import 'package:project_petcare/view/shop/shopdetails.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double offsetY = 1.0;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // getMyPetData();
      getData();
      getMyPet();
    });
    super.initState();
  }

  getMyPetData() async {
    var myPetProvider = Provider.of<MyPetProvider>(context, listen: false);
    await myPetProvider.getMyPetDetailsFromFireBase();
  }

  getMyPet() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    await sellingPetProvider.getTokenFromSharedPref();
    await sellingPetProvider.getMyPet();
  }

  getData() async {
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    petCareProvider.getTokenFromSharedPref();
    await petCareProvider.getUserFullName();
    await petCareProvider.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddMyPet()));
            },
            child: Icon(Icons.add)),
        backgroundColor: ColorUtil.BackGroundColorColor,
        body: Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) =>
              Consumer<MyPetProvider>(
            builder: (context, myPetProvider, child) => Consumer<ShopProvider>(
              builder: (context, shopProvider, child) =>
                  Consumer<SignUpProvider>(
                builder: (context, signUpProvider, child) =>
                    Consumer<PetCareProvider>(
                  builder: (context, petCareProvider, child) => GestureDetector(
                    onVerticalDragUpdate: (details) {},
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: ColorUtil.BackGroundColorColor,
                          elevation: 0,
                          expandedHeight: 250.0,
                          floating: false,
                          pinned: true,
                          centerTitle: true,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: false,
                            title: Text(
                              'My Profile',
                              style: TextStyle(color: ColorUtil.primaryColor),
                            ),
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Transform.translate(
                                  offset: Offset(0.0, offsetY),
                                  child: petCareProvider.profilePicture != null
                                      ? Image.network(
                                          petCareProvider.profilePicture!,
                                          fit: BoxFit.cover,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _showAlertDialogNOProfile(
                                                    context, petCareProvider);
                                              },
                                              child: Text(
                                                  "You haven't set your profile picture"),
                                            ),
                                            Text(
                                                "Click here for profile Picture"),
                                          ],
                                        ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //    bottom: PreferredSize(
                          //   preferredSize: Size.fromHeight(50), // Adjust the height as needed
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 15),
                          //     child: _profile(signUpProvider, petCareProvider),
                          //   ),
                          // ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _profile(signUpProvider, petCareProvider),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // myPetProvider.getPetData  ?
                                  _myPet(sellingPetProvider),
                                  // :
                                  SizedBox(),
                                  myFavourite(shopProvider),
                                ],
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
      ),
    );
  }

  Widget _profile(
      SignUpProvider signUpProvider, PetCareProvider petCareProvider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerifyYourAccount()));
        },
        child: ClipRRect(
          child: Container(
            alignment: Alignment.center,
            // color: ColorUtil.BackGroundColorColor,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * .08,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                      // height: MediaQuery.of(context).size.height * .06,
                      height: 60,
                      width: 60,
                      // width: MediaQuery.of(context).size.,
                      child: petCareProvider.profilePicture != null
                          ? Image.network(
                              petCareProvider.profilePicture!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/emptypp.png")),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text("My Profile"),
                    Text(
                      petCareProvider.userFullName ?? "User",
                      style: mainTitleText,
                    ),
                    Text(petCareProvider.userEmail ?? " No email found"),
                
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myPet(
    SellingPetProvider sellingPetProvider,
    // ShopProvider shopProviderm,
    // MyPetProvider myPetProvider,
    //  String userEmail
  ) {
    // List<MyPet> userPets = myPetProvider.myPetList.where((pet)=>pet.userEmail ==userEmail).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text("My pet"),
              Spacer(),
              Text(
                "View more",
                style: TextStyle(color: ColorUtil.primaryColor),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .3,
          child: ListView.builder(
              // itemCount: myPetProvider.myPetList.length,
              itemCount: sellingPetProvider.myPetList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ds_details(
                            adopt: sellingPetProvider.myPetList[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .45,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorUtil.primaryColor,
                                ),
                                child: Center(
                                  // Display the first two letters of the pet's name
                                  child: Text(
                                    sellingPetProvider.myPetList[index].petName
                                            ?.substring(0, 1) ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height * .1,
                              ),
                              Text(
                                  sellingPetProvider.myPetList[index].petName ??
                                      "")
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
        ),
      ],
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
                                          shop:
                                              shopProvider.favouriteList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 25,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
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
                                                          shopProvider
                                                                  .favouriteList[
                                                                      index]
                                                                  .description ??
                                                              "",
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
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Transform.translate(
                                                offset: Offset(0, -7),
                                                child: IconButton.outlined(
                                                    onPressed: () async {
                                                      shopProvider
                                                          .updateFavouriteList(
                                                              shopProvider
                                                                      .favouriteList[
                                                                  index]);
                                                    },
                                                    icon: Icon(
                                                        shopProvider.checkFavourite(
                                                                shopProvider
                                                                        .favouriteList[
                                                                    index])
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_rounded,
                                                        color: shopProvider
                                                                .checkFavourite(
                                                                    shopProvider
                                                                            .favouriteList[
                                                                        index])
                                                            ? Colors.red
                                                            : Colors.white)),
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

  pickImageFromGallery(PetCareProvider petCareProvider) async {
    final userImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (userImage == null) return;
    await petCareProvider.setImage(userImage);
  }

  void _showAlertDialogNOProfile(
      BuildContext context, PetCareProvider petCareProvider) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          title: Text(
            "Profile Picture",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          content: Column(
            children: [
              Text("Do You want to add you profile picture For your account?"),
              petCareProvider.userImage != null
                  ? Image.file(File(petCareProvider.userImage!.path))
                  : SizedBox()
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery(petCareProvider);
              },
              child: Text("Choose Image form gallery"),
            ),
            ElevatedButton(
              onPressed: () async {
                await petCareProvider.uploadeImageInFirebase();
                if (petCareProvider.userImageUtil == StatusUtil.success) {
                  Helper.snackBar("Successfully Saved", context);
                  Navigator.pop(context);
                } else {
                  Helper.snackBar('Failed to save', context);
                }
              },
              child: Text("Upload"),
            ),
          ],
        );
      },
    );
  }
}
