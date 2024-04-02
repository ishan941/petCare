import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/feedprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/adoption/sellingPetForm.dart';
import 'package:project_petcare/view/adoption/ds_details.dart';
import 'package:project_petcare/view/search_here.dart';
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
     Future.delayed(Duration.zero, () async {
      getToken();
      await getFeed();
      await getUserPhone();
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // void loadData() async {
   
  // }

  void getToken() {
    var sellingProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    sellingProvider.getTokenFromSharedPref();
  }

  Future<void> getFeed() async {
    var sellingProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    sellingProvider.getTokenFromSharedPref();

    await sellingProvider.getSellingPetData();
    await sellingProvider.getDonatePetData();
    // await sellingProvider.get
  }

  getUserPhone() async {
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    await petCareProvider.getTokenFromSharedPref();

    await petCareProvider.getUserPhone();
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
          child: Consumer<SignUpProvider>(
            builder: (context, signUpProvider, child) => Consumer<FeedProvider>(
              builder: (context, feedProvider, child) =>
                  Consumer<SellingPetProvider>(
                builder: (context, sellingPetProvider, child) =>
                    Consumer<PetCareProvider>(
                  builder: (context, petCareProvider, child) =>
                      CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: ColorUtil.BackGroundColorColor,
                        elevation: 0,
                        pinned: true,
                        flexibleSpace: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return FlexibleSpaceBar(
                              title: constraints.maxHeight > 50
                                  ? Row(
                                      children: [
                                        Text(
                                          'PetCare',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: ColorUtil.primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchPage()));
                                            // await sellingPetProvider.searchSellingPet();
                                          },
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
                                        ),
                                      ],
                                    )
                                  : null,
                              centerTitle: false,
                            );
                          },
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Divider(
                                thickness: 6,
                              ),
                              TabBar(
                                controller: _tabController,
                                labelColor: ColorUtil.primaryColor,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: ColorUtil.primaryColor,
                                tabs: [
                                  Tab(child: Text('Selling Pet')),
                                  Tab(child: Text('Donated Pet')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        child: sellingPetProvider.sellingPetList.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Helper.primaryLoader(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Please wait....",
                                  ),
                                ],
                              )
                            : TabBarView(
                                controller: _tabController,
                                children: [
                                  ListView.builder(
                                    itemCount: sellingPetProvider
                                        .sellingPetList.length,
                                    itemBuilder: (context, index) => sellingPet(
                                        sellingPetProvider,
                                        index,
                                        context,
                                        signUpProvider,
                                        petCareProvider),
                                  ),
                                  ListView.builder(
                                    itemCount:
                                        sellingPetProvider.donatePetList.length,
                                    itemBuilder: (context, index) => donatePet(
                                        sellingPetProvider,
                                        index,
                                        context,
                                        petCareProvider),
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
    );
  }

  Widget sellingPet(
      SellingPetProvider sellingPetProvider,
      int index,
      BuildContext context,
      SignUpProvider signUpProvider,
      PetCareProvider petCareProvider) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ds_details(
                    adopt: sellingPetProvider.sellingPetList[index])));
      },
      child: sellingPetProvider.sellingPetList.isEmpty
          ? Helper.primaryLoader()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            sellingPetProvider.sellingPetList[index].imageUrl ??
                                " ",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      sellingPetProvider.sellingPetList[index].isSold
                          ? Row(
                              children: [
                                Spacer(),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                                  
                                  child: Container(
                                    color: ColorUtil.primaryColor,
                                
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Sold"),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sellingPetProvider
                                    .sellingPetList[index].ownerName ??
                                " ",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                "Rs",
                                style: smallTitleText,
                              ),
                              Text(
                                sellingPetProvider
                                        .sellingPetList[index].petPrice ??
                                    "Free",
                                style: mainTitleText,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      petCareProvider.userPhone ==
                              sellingPetProvider
                                  .sellingPetList[index].ownerPhone
                          ? ElevatedButton(
                              onPressed: () {
                                // Show dialog
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Sold'),
                                      content: Text(
                                          'Do you want to make your item sold?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            // Close dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await sellingPetProvider.requestSold(
                                                sellingPetProvider
                                                    .sellingPetList[index].id!);
                                            if (sellingPetProvider
                                                    .makeSoldUtil ==
                                                StatusUtil.success) {
                                              Helper.snackBar(
                                                  "Your item is listed as Sold",
                                                  context);
                                              Navigator.of(context).pop();
                                            } else if (sellingPetProvider
                                                    .makeSoldUtil ==
                                                StatusUtil.error) {
                                              Helper.snackBar(
                                                  "Failed", context);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("Sold"))
                          : SizedBox()
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget donatePet(SellingPetProvider sellingPetProvider, int index,
      BuildContext context, PetCareProvider petCareProvider) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Ds_details(
                    adopt: sellingPetProvider.donatePetList[index])));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      sellingPetProvider.donatePetList[index].imageUrl ?? " ",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                sellingPetProvider.donatePetList[index].isSold
                    ? Row(
                        children: [
                          Spacer(),
                          Container(
                            
                            color: ColorUtil.primaryColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Adopted",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      sellingPetProvider.donatePetList[index].ownerName ?? " ",
                      style: mainTitleText,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      sellingPetProvider.donatePetList[index].petName ?? " ",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                petCareProvider.userPhone ==
                        sellingPetProvider.donatePetList[index].ownerPhone
                    ? ElevatedButton(
                        onPressed: () {
                          // Show dialog
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Donated'),
                                content: Text(
                                    'Do you want to make your item adopted?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Close dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await sellingPetProvider.requestAdopted(
                                          sellingPetProvider
                                              .donatePetList[index].id!);
                                      if (sellingPetProvider.makeAdoptedUtil ==
                                          StatusUtil.success) {
                                        Helper.snackBar(
                                            "Your item is listed as Adopted",
                                            context);
                                        Navigator.of(context).pop();
                                      } else if (sellingPetProvider
                                              .makeAdoptedUtil ==
                                          StatusUtil.error) {
                                        Helper.snackBar("Failed", context);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Adopted"))
                    : SizedBox()
              ],
            ),
          ],
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
}
