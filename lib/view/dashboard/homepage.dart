import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/adopt/adoptDetails.dart';
import 'package:project_petcare/view/adopt/donateData.dart';
import 'package:project_petcare/view/adopt/adotp.dart';
import 'package:project_petcare/view/categories.dart/categoriesContain.dart';
import 'package:project_petcare/view/dashboard/categories.dart';
import 'package:project_petcare/view/dashboard/donatenow.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:project_petcare/view/ourservice/ourservices.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:project_petcare/view/dashboard/search.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LoadImages> imageList = [
    LoadImages(
        images: "assets/images/catsCategores.png",
        pageIdentifier: "category1",
        name: "Cat"),
    LoadImages(
        images: "assets/images/Group 1058.png",
        pageIdentifier: "category2",
        name: "Dog"),
    LoadImages(
        images: "assets/images/fishCategores.png",
        pageIdentifier: "category3",
        name: "Fish"),
    LoadImages(
        images: "assets/images/rabbitCategories.png",
        pageIdentifier: "category4",
        name: "Rabbit"),
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getUserName();
      getdata();
      getDashServiceDetailsinUi();
      getAdoptdata();
     
    });

    super.initState();
  }

  getdata() async {
    var donateProvider = Provider.of<DonateProvider>(context, listen: false);
    await donateProvider.petDetails();
  }

  getUserName() async {
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    await signUpProvider.userData();
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

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        body: Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) => Stack(
            children: [
              ui(),
              loader(ourServiceProvider),
            ],
          ),
        ));
  }

  loader(OurServiceProvider ourServiceProvider) {
    if (ourServiceProvider.dashServiceUtil == StatusUtil.loading) {
      return Helper.backdropFilter(context);
    } else {
      return SizedBox();
    }
  }

  ScrollConfiguration ui() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<SignUpProvider>(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Good morning,',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                         signUpProvider.userName ?? 'User',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                    },
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage("assets/images/emptypp.png"),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
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
                                height: 50,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Search(),
                                        ));
                                  },
                                  readOnly: true,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: "Search here...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/streetpets.png"),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 150, left: 15),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DonateFirstPage())),
                                          child: SizedBox(
                                            height: 35,
                                            child: Image.asset(
                                                "assets/images/donatenow.png"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile()));
                                      },
                                      child: const Text(
                                        "Categories",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoriesExplore()));
                                      },
                                      child: Text("Explore",
                                          style: TextStyle(
                                              color: ColorUtil.primaryColor,
                                              fontSize: 18)),
                                    )
                                  ],
                                ),
                              ),
                              //categories
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .15,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imageList.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      String? categoryTitle =
                                          imageList[index].name;

                                      // Use the categoryTitle to navigate to the Search page with dynamic content
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CategoriesContain(
                                          categoryTitle: categoryTitle,
                                        );
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: SizedBox(
                                          height: 50,
                                          child: Image.asset(
                                              imageList[index].images!)),
                                    ),
                                  ),
                                ),
                              ),
                              //end categories

                              //ourservice ui
                              ourservice(context),

                              SizedBox(
                                height: 10,
                              ),
                              //adoupt ui
                              // adopt(context, donateProvider),
                              // SizedBox(
                              //   height: 20,
                              // ),

                              //adopt details
                              adoptdetails(adoptProvider),
                              SizedBox(
                                height: 100,
                              )
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
                  Text(
                    "Adopt",
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
                    "See all",
                    style:
                        TextStyle(fontSize: 18, color: ColorUtil.primaryColor),
                  ))
            ],
          ),
        ),
        Container(
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
                              adopt: adoptProvider.adoptDetailsList[index],
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
                            // height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * 0.36,
                            child: Image.network(
                              adoptProvider.adoptDetailsList[index].imageUrl ??
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
                                adoptProvider
                                        .adoptDetailsList[index].petbread ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                adoptProvider.adoptDetailsList[index].petname ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                                maxLines: 2, // Adjust as needed
                                overflow: TextOverflow
                                    .ellipsis, // Handle overflow gracefully
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 15, color: ColorUtil.primaryColor),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Column(
                                    children: [
                                      Text(adoptProvider.adoptDetailsList[index]
                                              .location ??
                                          ""),
                                    ],
                                  ),
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
      ],
    );
  }

  Column adopt(BuildContext context, DonateProvider donateProvider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adopt",
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
                    "See all",
                    style:
                        TextStyle(fontSize: 18, color: ColorUtil.primaryColor),
                  ))
            ],
          ),
        ),
        donateProvider.donatePetList.isNotEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * .195,
                // color: Colors.green,
                child: ListView.builder(
                    itemCount: donateProvider.donatePetList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonateData(
                                            donate: donateProvider
                                                .donatePetList[index],
                                          )));
                            },
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
                              height: MediaQuery.of(context).size.height * .18,
                              // width: MediaQuery.of(context).size.width*0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.36,
                                        child: Image.network(
                                          donateProvider.donatePetList[index]
                                                  .imageUrl ??
                                              "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          donateProvider.donatePetList[index]
                                                  .petbread ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          donateProvider.donatePetList[index]
                                                  .petname ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2, // Adjust as needed
                                          overflow: TextOverflow
                                              .ellipsis, // Handle overflow gracefully
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                size: 15,
                                                color: ColorUtil.primaryColor),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(donateProvider
                                                    .donatePetList[index]
                                                    .location ??
                                                ""),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
              )
            : const Text("No data available")
      ],
    );
  }

  Column ourservice(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              const Text(
                "Our Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OurServicesMore()));
                  },
                  child: Text(
                    "See all",
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
            height: MediaQuery.of(context).size.height * .25,
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
                                  builder: (context) => OurServicesMore(
                                        dashService: ourServiceProvider
                                            .dashServiceList[index],
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
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .12,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        ourServiceProvider
                                                .dashServiceList[index]
                                                .cpImage ??
                                            "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  //end image container
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.037),
                                  Text(
                                    ourServiceProvider
                                            .dashServiceList[index].service ??
                                        "",
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(
                                    height: 6,
                                  ),
                                  // view ourservice
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorUtil.primaryColor,
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 25,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: const Center(
                                        child: Text(
                                      "View",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
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
                                                .dashServiceList[index]
                                                .ppImage ??
                                            "")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}

class LoadImages {
  String? images;
  String? name;
  String? pageIdentifier;
  LoadImages({this.images, this.pageIdentifier, this.name});
}
