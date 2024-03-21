import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/ourservice/profession.dart';
import 'package:project_petcare/view/search_here.dart';
import 'package:provider/provider.dart';

class OurServicesUiDto extends StatefulWidget {
  final OurService? ourService;
  final OurServiceDto? ourServiceDto;

  OurServicesUiDto({
    Key? key,
    this.ourService,
    this.ourServiceDto,
  }) : super(key: key);

  @override
  State<OurServicesUiDto> createState() => _OurServicesUiDtoState();
}

class _OurServicesUiDtoState extends State<OurServicesUiDto>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      getValue();
      SchedulerBinding.instance.addPostFrameCallback((_) {});
    });
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  getValue() async {
    var ourServiceProvider =
        Provider.of<OurServiceProvider>(context, listen: false);
    await ourServiceProvider.getTokenFromSharedPref();
    await ourServiceProvider.getOurServiceDto();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose(); // Dispose of the TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtil.BackGroundColorColor,
          iconTheme: const IconThemeData.fallback(),
          title: Text(
            (widget.ourService!.service ?? ""),
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YourProfession()));
              },
              icon: Icon(Icons.add),
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
                          child: ConstSearch(
                            prefixIcon: Icon(Icons.search),
                            controller: _searchController,
                            hintText: searchHereStr,
                            onChanged: (_) {
                              // _searchHere(ourServiceProvider);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text("Explore " "${widget.ourService!.service ?? ""}")
                ],
              ),
              Flexible(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: ColorUtil.secondaryColor,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: ColorUtil.secondaryColor,
                        tabs: [
                          Tab(child: Text('Popular')),
                          Tab(child: Text('Nearby')),
                          // Tab(child: Text('Last Visited')),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            popular(ourServiceProvider),
                            popular(ourServiceProvider),
                            // nearby(ourServiceProvider),
                            // lastVisited(ourServiceProvider),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget popular(OurServiceProvider ourServiceProvider) {
    // List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: ourServiceProvider.ourServiceDtoList.length,
                  itemBuilder: (context, index) => ourServiceProvider
                              .getOurServiceUtil ==
                          StatusUtil.loading
                      ? SimmerEffect.shimmerEffect()
                      : ourServiceProvider.getOurServiceUtil == StatusUtil.error
                          ? Text("Error: ${ourServiceProvider.errorMessage}")
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ServiceDetails(
                                  //             ourService:
                                  //                 filteredList[index])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 120,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              // child: ourServiceProvider
                                              //             .getProfessionUtil ==
                                              //         StatusUtil.loading
                                              //     ? SimmerEffect.shimmerEffect()
                                              //     : Image.network(
                                              //         filteredList[index]
                                              //                 .profilePicture ??
                                              //             "",
                                              //         fit: BoxFit.cover,
                                              //       ),
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
                                                  // Text(
                                                  //   filteredList[index]
                                                  //           .fullName ??
                                                  //       "",
                                                  //   style: subTitleText,
                                                  // ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  // Text(
                                                  //   "  ${filteredList[index].profession ?? ""}",
                                                  //   style: textStyleMini,
                                                  // ),
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
                                                  // Text(
                                                  //   " -  ${filteredList[index].phone ?? ""}",
                                                  //   style: textStyleSmallSized,
                                                  // ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.email_outlined,
                                                    size: 15,
                                                  ),
                                                  // Text(
                                                  //     " -  ${filteredList[index].email ?? ""}",
                                                  //     style:
                                                  //         textStyleSmallSized),
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
                                                  // Text(
                                                  //     filteredList[index]
                                                  //             .location ??
                                                  //         "Kathmandu",
                                                  //     style:
                                                  //         textStyleSmallSized)
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

  // Widget nearby(OurServiceProvider ourServiceProvider) {
  //   List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
  //   return Expanded(
  //     child: Consumer<OurServiceProvider>(
  //       builder: (context, ourServiceProvider, child) => Column(
  //         children: [
  //           Container(
  //             child: Expanded(
  //               child: ListView.builder(
  //                 itemCount: filteredList.length,
  //                 itemBuilder: (context, index) => Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
  //                   child: InkWell(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => ServiceDetails(
  //                                   ourService: filteredList[index])));
  //                     },
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(12),
  //                       child: Container(
  //                         height: 120,
  //                         color: Colors.white,
  //                         child: Row(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 child: Container(
  //                                   child: Image.network(
  //                                     filteredList[index].profilePicture ?? "",
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                                   height:
  //                                       MediaQuery.of(context).size.height * .9,
  //                                   width:
  //                                       MediaQuery.of(context).size.width * .25,
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Row(
  //                                     children: [
  //                                       Text(
  //                                         filteredList[index].fullName ?? "",
  //                                         style: subTitleText,
  //                                       ),
  //                                       SizedBox(
  //                                         width: 5,
  //                                       ),
  //                                       Text(
  //                                         "  ${filteredList[index].profession ?? ""}",
  //                                         style: textStyleMini,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.phone_in_talk_outlined,
  //                                         size: 15,
  //                                       ),
  //                                       // Text(
  //                                       //   " -  ${filteredList[index].phone!}",
  //                                       //   style: textStyleSmallSized,
  //                                       // ),
  //                                     ],
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.email_outlined,
  //                                         size: 15,
  //                                       ),
  //                                       Text(
  //                                           " -  ${filteredList[index].email!}",
  //                                           style: textStyleSmallSized),
  //                                     ],
  //                                   ),
  //                                   Spacer(),
  //                                   Row(
  //                                     children: [
  //                                       Container(
  //                                         decoration: BoxDecoration(
  //                                             color: ColorUtil.primaryColor,
  //                                             borderRadius:
  //                                                 BorderRadius.circular(8)),
  //                                         height: 30,
  //                                         width: 100,
  //                                         child: Center(
  //                                           child: Text(
  //                                             "Book Now",
  //                                             style: TextStyle(
  //                                                 color: Colors.white),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       Icon(
  //                                         Icons.location_on_outlined,
  //                                         size: 15,
  //                                         color: Colors.black.withOpacity(0.5),
  //                                       ),
  //                                       // Text(filteredList[index].location ?? "")
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

    

  // _searchHere(OurServiceProvider ourServiceProvider) async {
  //   String query = _searchController.text.toLowerCase();
  //   try {
  //     String chosenProfession = widget.ourService!.service!;
  //     List<OurService> filteredList =
  //         ourServiceProvider.filterByProfession(chosenProfession);
  //     ourServiceProvider.setFilteredProfessionData(filteredList);
  //     await ourServiceProvider.getProfessionData();
  //     if (ourServiceProvider.getProfessionUtil == StatusUtil.success) {
  //       List<OurService> professionData = ourServiceProvider.professionDataList;
  //       List<OurService> searchResult = professionData
  //           .where((service) =>
  //               service.fullName!.toLowerCase().contains(query) ||
  //               service.location!.toString().contains(query))
  //           .toList();
  //       ourServiceProvider.setFilteredProfessionData(searchResult);
  //     } else {
  //       print("Error: ${ourServiceProvider.errorMessage}");
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //   }
  // }
}
