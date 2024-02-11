import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/response/response.dart';
import 'package:project_petcare/view/customs/consttextform.dart';
import 'package:project_petcare/view/ourservice/profession.dart';
import 'package:project_petcare/view/ourservice/serviceDetail.dart';
import 'package:project_petcare/view/search_here.dart';
import 'package:provider/provider.dart';

class OurServicesMore extends StatefulWidget {
  final DashService? dashService;

  OurServicesMore({
    Key? key,
    this.dashService,
  }) : super(key: key);

  @override
  State<OurServicesMore> createState() => _OurServicesMoreState();
}

class _OurServicesMoreState extends State<OurServicesMore>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getvalue();
      SchedulerBinding.instance.addPostFrameCallback((_) {});
    });
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  getvalue() async {
    var ourServiceProvider =
        Provider.of<OurServiceProvider>(context, listen: false);
    String chosenProfession = widget.dashService!.service!;
    List<OurService> filteredList =
        ourServiceProvider.filterByProfession(chosenProfession);
    ourServiceProvider.setFilteredProfessionData(filteredList);
    await ourServiceProvider.getProfessionData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Scaffold(
          backgroundColor: ColorUtil.BackGroundColorColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorUtil.BackGroundColorColor,
            iconTheme: const IconThemeData.fallback(),
            title: Text(
              (widget.dashService!.service ?? ""),
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YourProfession()));
                },
                icon: Icon(Icons.person_add_alt_1_rounded),
              ),
              SizedBox(width: 5),
            ],
          ),
          body: Consumer<OurServiceProvider>(
            builder: (context, ourServiceProvider, child) => Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchHere()));
                            },
                            child:
                                // Container(
                                //   height: 50,
                                //   color: Colors.red,
                                // )
                                ConstTextForm(
                              controller: _searchController,
                              hintText: searchHereStr,
                              suffixIcon: const Icon(Icons.search),
                              onChanged: (_) {
                                _searchHere(ourServiceProvider);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 3,
                              color: Colors.grey.withOpacity(1),
                              offset: const Offset(2, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        width: 55,
                        height: 55,
                        child: const Icon(Icons.sort),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      exploreVetStr,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                DefaultTabController(
                  length: 3,
                  child: Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors
                                .black, // Change the color of unselected text
                            indicatorColor: Colors.red,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Popular',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Nearby',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Last Visited',
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                popular(ourServiceProvider),
                                nearby(ourServiceProvider),
                                lastVisited(ourServiceProvider),
                              ],
                            ),
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
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget popular(OurServiceProvider ourServiceProvider) {
    List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) => ourServiceProvider
                              .getProfessionUtil ==
                          StatusUtil.loading
                      ? SimmerEffect.shimmerEffect()
                      : ourServiceProvider.getProfessionUtil == StatusUtil.error
                          ? Text("Error: ${ourServiceProvider.errorMessage}")
                          : Padding(
                              padding: const EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ServiceDetails(
                                              ourService:
                                                  filteredList[index])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 110,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              child: ourServiceProvider
                                                          .getProfessionUtil ==
                                                      StatusUtil.loading
                                                  ? SimmerEffect.shimmerEffect()
                                                  : Image.network(
                                                      filteredList[index]
                                                              .profilePicture ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                    ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .9,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    filteredList[index]
                                                            .fullname ??
                                                        "",
                                                    style: subTitleText,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "  ${filteredList[index].profession ?? ""}",
                                                    style: textStyleMini,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .phone_in_talk_outlined,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    " -  ${filteredList[index].phone ?? ""}",
                                                    style: textStyleSmallSized,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.email_outlined,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                      " -  ${filteredList[index].email ?? ""}",
                                                      style:
                                                          textStyleSmallSized),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorUtil
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    height: 30,
                                                    width: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Book Now",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                  Text(filteredList[index]
                                                          .location ??
                                                      "")
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
          ],
        ),
      ),
    );
  }

  Widget nearby(OurServiceProvider ourServiceProvider) {
    List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceDetails(
                                    ourService: filteredList[index])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 110,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    child: Image.network(
                                      filteredList[index].profilePicture ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          filteredList[index].fullname ?? "",
                                          style: subTitleText,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "  ${filteredList[index].profession ?? ""}",
                                          style: textStyleMini,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_in_talk_outlined,
                                          size: 15,
                                        ),
                                        Text(
                                          " -  ${filteredList[index].phone!}",
                                          style: textStyleSmallSized,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          size: 15,
                                        ),
                                        Text(
                                            " -  ${filteredList[index].email!}",
                                            style: textStyleSmallSized),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ColorUtil.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "Book Now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        Text(filteredList[index].location ?? "")
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
          ],
        ),
      ),
    );
  }

  Widget lastVisited(OurServiceProvider ourServiceProvider) {
    List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceDetails(
                                    ourService: filteredList[index])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 110,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    child: Image.network(
                                      filteredList[index].profilePicture ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          filteredList[index].fullname ?? "",
                                          style: subTitleText,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "  ${filteredList[index].profession ?? ""}",
                                          style: textStyleMini,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_in_talk_outlined,
                                          size: 15,
                                        ),
                                        Text(
                                          " -  ${filteredList[index].phone!}",
                                          style: textStyleSmallSized,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          size: 15,
                                        ),
                                        Text(
                                            " -  ${filteredList[index].email!}",
                                            style: textStyleSmallSized),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ColorUtil.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "Book Now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        Text(filteredList[index].location ?? "")
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
          ],
        ),
      ),
    );
  }

  _searchHere(OurServiceProvider ourServiceProvider) async {
    String query = _searchController.text.toLowerCase();
    try {
      String chosenProfession = widget.dashService!.service!;
      List<OurService> filteredList =
          ourServiceProvider.filterByProfession(chosenProfession);
      ourServiceProvider.setFilteredProfessionData(filteredList);
      await ourServiceProvider.getProfessionData();
      if (ourServiceProvider.getProfessionUtil == StatusUtil.success) {
        List<OurService> professionData = ourServiceProvider.professionDataList;
        List<OurService> searchResult = professionData
            .where((service) =>
                service.fullname!.toLowerCase().contains(query) ||
                service.location!.toString().contains(query))
            .toList();
        ourServiceProvider.setFilteredProfessionData(searchResult);
      } else {
        print("Error: ${ourServiceProvider.errorMessage}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
