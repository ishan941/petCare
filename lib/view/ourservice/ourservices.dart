import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/dashservice.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/customs/consttextform.dart';
import 'package:project_petcare/view/ourservice/profession.dart';
import 'package:project_petcare/view/ourservice/serviceDetail.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:provider/provider.dart';

class OurServicesMore extends StatefulWidget {
  final DashService? dashService;
  

  OurServicesMore({Key? key, this.dashService, }) : super(key: key);

  @override
  State<OurServicesMore> createState() => _OurServicesMoreState();
}

class _OurServicesMoreState extends State<OurServicesMore>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    getvalue();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  getvalue()async{
    var ourServiceProvider = Provider.of<OurServiceProvider>(context, listen: false);
    await ourServiceProvider.getProfessionData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtil.BackGroundColorColor,
          iconTheme: const IconThemeData.fallback(),
          title: Text(
            (widget.dashService!.service!),
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => YourProfession()));
              },
              icon: Icon(Icons.person_add_alt_1_rounded),
            ),
            SizedBox(width: 5),
          ],
        ),
        body: Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) =>  Column(
            children: [
              SizedBox(height: 10,),
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ConstTextForm(
                          hintText: "Search here...",
                          suffixIcon: const Icon(Icons.search),
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
                          unselectedLabelColor:
                              Colors.black, // Change the color of unselected text
                          indicatorColor: Colors.red,
                          tabs: [
                            Tab(
                              child: Text(
                                'Popular Vet',
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Nearby Vet',
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
                              all(ourServiceProvider),
                              nearby(context),
                              lastVisited(context),
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
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Widget all(OurServiceProvider ourServiceProvider) {
    return Expanded(
      child: Consumer<OurServiceProvider>(
        builder: (context, ourServiceProvider, child) =>  Column(
          children: [
      
         
          Container(
            height: 500,
            // color: Colors.red,
            child: ListView.builder(
              itemCount: ourServiceProvider.professionDataList.length,
              itemBuilder: (context, index)=>

            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceDetails(ourService: ourServiceProvider.professionDataList[index])));
                },
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child:  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.9,
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width*.25,
                      ),
                      Text(ourServiceProvider.professionDataList[index].fullname??""),
                    ],
                  ),
                ),
              ),
            )),
          )
          ],
        ),
      ),
    );
  }
  Widget nearby(BuildContext context) {
    return Column(
      children: [
        Expanded(
          
          child: Container(
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget lastVisited(BuildContext context) {
    return Column(
      children: [
      
        Expanded(
          child: Container(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  

  
}
