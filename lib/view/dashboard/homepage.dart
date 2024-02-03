import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/adopt/adoptDetails.dart';
import 'package:project_petcare/view/adopt/donateData.dart';
import 'package:project_petcare/view/adopt/adotp.dart';
import 'package:project_petcare/view/categories.dart/categoriesDetails.dart';
import 'package:project_petcare/view/dashboard/categories.dart';
import 'package:project_petcare/view/ourservice/ourserviceSeeMore.dart';
import 'package:project_petcare/view/ourservice/ourservices.dart';
import 'package:project_petcare/view/profile/account.dart';
import 'package:project_petcare/view/dashboard/search.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getGreeting();
      getUserName();
      getCategories();
      getdata();
      getDashServiceDetailsinUi();
      getAdoptdata();
    });

    super.initState();
  }
  getGreeting()async{
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    await petCareProvider.updateGreeting();
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

  getCategories() async {
    var categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    await categoriesProvider.getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.primaryColor,
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

  Widget ui() {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<CategoriesProvider>(
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
                          Stack(
                            children: [
                              Column(
                                children: [
                                  dashHead(signUpProvider, context, petCareProvider),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
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
                                            categories(categoriesProvider),
                                            ourservice(context),
                                            
                                            adoptdetails(adoptProvider),
                                            Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/streetpets.png"),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }

  Widget dashHead(SignUpProvider signUpProvider, BuildContext context, PetCareProvider petCareProvider) {
    return Container(
      height: 190,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "Hello ${signUpProvider.userName},",
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
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/emptypp.png"),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .9,
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
                color: Color(0XFFE6E8FF).withOpacity(0.8)),
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
                hintText: searchHereStr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categories(CategoriesProvider categoriesProvider) {
    return Column(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    style:
                        TextStyle(color: ColorUtil.primaryColor, fontSize: 18)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoriesProvider.categoriesList.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CategoriesDetails(
                        categories: categoriesProvider.categoriesList[index]);
                  }));
                },
                child: Stack(children: [
                  categoriesUi(context, categoriesProvider, index),
                
                ])),
          ),
        ),
      ],
    );
  }

 

  Widget categoriesUi(
      BuildContext context, CategoriesProvider categoriesProvider, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // height: 0,
          // width: MediaQuery.of(context).size.width * .32,
          // color: Color.fromARGB(255, 68, 145, 173),
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    // color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Image.network(
                      categoriesProvider
                              .categoriesList[index].categoriesImage ??
                          "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                categoriesProvider.categoriesList[index].categoriesName ?? "",
                style: titleText,
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
                  SizedBox(height: 10,),
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
         adoptProvider.adoptDetailsList.isEmpty?
        Center(child: Text("No Data available for adopt")):
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
                            height: MediaQuery.of(context).size.height,
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
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                adoptProvider.adoptDetailsList[index].petname ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),

                                overflow: TextOverflow
                                    .ellipsis, // Handle overflow gracefully
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
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
                                        adoptProvider.adoptDetailsList[index]
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
            : const Text(noDateAvailableStr)
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
                            builder: (context) => OurServicesMore(
                                  dashService:
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
                                    child: Image.network(
                                      ourServiceProvider
                                              .dashServiceList[index].cpImage ??
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
                              child: const Center(
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
}


