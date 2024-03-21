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
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: ColorUtil.BackGroundColorColor,
                      elevation: 0,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: sellingPetProvider.sellingPetList.length,
                            itemBuilder: (context, index) =>
                                sellingPet(sellingPetProvider, index, context),
                          ),
                          ListView.builder(
                            itemCount: sellingPetProvider.donatePetList.length,
                            itemBuilder: (context, index) =>
                                donatePet(sellingPetProvider, index, context),
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
    );
  }

  Widget sellingPet(
      SellingPetProvider sellingPetProvider, int index, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Container(
                height: 500,
                width: 300,
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Other widgets for selling pet
      ],
    );
  }

  Widget donatePet(
      SellingPetProvider sellingPetProvider, int index, BuildContext context) {
    return Column(
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Other widgets for donated pet
      ],
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
