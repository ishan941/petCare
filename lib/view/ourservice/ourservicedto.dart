import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constSearch.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/simmer.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/ourservice/ourserdto_form.dart';
import 'package:project_petcare/view/ourservice/serviceDetail.dart';
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

  String? address;
  double? lat, long;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
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
    await ourServiceProvider.getOurServiceDto().then((value) {
      ourServiceProvider.setIsValueDisplayed(false);
      getCurrentLocation(ourServiceProvider);
    });
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
                            // popular(ourServiceProvider),
                            popular(ourServiceProvider),
                            nearby(ourServiceProvider),
                            // nearby(ourServiceProvider),
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

  getCurrentLocation(OurServiceProvider ourServiceProvider) async {
    LocationPermission permission = await Helper().getPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Stream<Coordinate> coordinateStream = Helper().getCoordinateStream();
      coordinateStream.listen((Coordinate coordinate) async {
        setState(() {
          lat = coordinate.latitude;
          long = coordinate.longitude;
          address = coordinate.address!;
        });
        if (ourServiceProvider.isValueDisplayed == false) {
          ourServiceProvider.setIsValueDisplayed(true);

          for (int i = 0;
              i < ourServiceProvider.ourServiceDtoList.length;
              i++) {
            List<Location> startLocations = await locationFromAddress(
                ourServiceProvider.ourServiceDtoList[i].location!);

            double haversine = await Helper().calculateDistance(lat!, long!,
                startLocations.first.latitude, startLocations.first.longitude);

            ourServiceProvider.distanceServiceList.add(DistanceService(
                ourServiceDto: ourServiceProvider.ourServiceDtoList[i],
                distance: haversine));
          }

          ourServiceProvider.distanceServiceList
              .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

          print(ourServiceProvider.distanceServiceList);
        }

        // setState(() {
        //   currentAddress = user.data()['Address'];
        //   calculatedDistances[hardwareName] =
        //       '${haversine.toStringAsFixed(3)} KM';
        // });
      });
    }
  }

  Widget nearby(OurServiceProvider ourServiceProvider) {
    // List<OurService> filteredList = ourServiceProvider.filteredProfessionData;
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) => Column(
          children: [
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: ourServiceProvider.distanceServiceList.length,
                  itemBuilder: (context, index) => ourServiceProvider
                              .getOurServiceUtil==
                          StatusUtil.loading
                      ? SimmerEffect.shimmerEffect()
                      : ourServiceProvider.getOurServiceUtil == StatusUtil.error
                          ? Text("Error: ${ourServiceProvider.errorMessage}")
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              child: InkWell(
                                onTap: () {},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 140,
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
                                                      ourServiceProvider
                                                              .ourServiceDtoList[
                                                                  index]
                                                              .image ??
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
                                                    ourServiceProvider
                                                            .distanceServiceList[
                                                                index]
                                                            .ourServiceDto
                                                            ?.fullName ??
                                                        "",
                                                    style: subTitleText,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "  ${ourServiceProvider.distanceServiceList[index].ourServiceDto?.service ?? ""}",
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
                                                    " -  ${ourServiceProvider.distanceServiceList[index].ourServiceDto?.phone ?? ""}",
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
                                                      " -  ${ourServiceProvider.distanceServiceList[index].ourServiceDto?.email ?? ""}",
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ServiceDetails(
                                                                      ourServiceDto: ourServiceProvider
                                                                          .distanceServiceList[
                                                                              index]
                                                                          .ourServiceDto)));
                                                        },
                                                        child: Text(
                                                          "Book Now",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Helper().launchMaps(
                                                          ourServiceProvider
                                                                  .distanceServiceList[
                                                                      index]
                                                                  .ourServiceDto
                                                                  ?.location ??
                                                              "");
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 40,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                      "${ourServiceProvider.distanceServiceList[index].distance?.toStringAsFixed(3)}" +
                                                          "KM",
                                                      style:
                                                          textStyleSmallSized),
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
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceDetails(
                                    ourServiceDto: ourServiceProvider.ourServiceDtoList[index])));
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
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    child: Image.network(
                                      ourServiceProvider.ourServiceDtoList[index].image ?? "",
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
                                          ourServiceProvider.ourServiceDtoList[index].fullName ?? "",
                                          style: subTitleText,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                           ourServiceProvider.ourServiceDtoList[index].service ?? "",
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
                                        ),SizedBox(width: 5,),
                                        Text(
                                          ourServiceProvider.ourServiceDtoList[index].phone ?? "",
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
                                        SizedBox(width: 5,),
                                        Text(
                                           ourServiceProvider.ourServiceDtoList[index].email ?? "",
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
                                        Text(ourServiceProvider.ourServiceDtoList[index].location ?? "")
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
}

class DistanceService {
  OurServiceDto? ourServiceDto;
  double? distance;

  DistanceService({this.ourServiceDto, this.distance});
}
