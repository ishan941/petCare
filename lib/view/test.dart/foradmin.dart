import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/view/adopt/adoptDetails.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:provider/provider.dart';

class ForAdmin extends StatefulWidget {
  const ForAdmin({super.key});

  @override
  State<ForAdmin> createState() => _ForAdminState();
}

class _ForAdminState extends State<ForAdmin> {
//   @override
//   void initState() {
//     getAdoptValue();
//     super.initState();
//   }
//   getAdoptValue()async{
//     DonateProvider donateProvider =  Provider.of<DonateProvider>(context, listen: false);
// await donateProvider.petDetails();

//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => Consumer<DonateProvider>(
          builder: (context, donateProvider, child) => SafeArea(
            child: Column(
              children: [
                Container(
                    height: 50,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_sharp)),
                        Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              adoptStr,
                              style: subTitleText,
                            ),
                            Text(adoptYourFavouritePetStr)
                          ],
                        )
                      ],
                    )),
             adoptProvider.adoptDetailsList.isNotEmpty?   Expanded(
                  child: ListView.builder(
                    itemCount: adoptProvider.adoptDetailsList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdoptDetails(
                                      adopt:
                                          adoptProvider.adoptDetailsList[index],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 3,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    child: Image.network(
                                      adoptProvider.adoptDetailsList[index]
                                              .imageUrl ??
                                          "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    // color: Colors.red ,

                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              adoptProvider
                                                      .adoptDetailsList[index]
                                                      .petBreed ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            Text(
                                              adoptProvider
                                                      .adoptDetailsList[index]
                                                      .petName ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                              maxLines: 2, // Adjust as needed
                                              overflow: TextOverflow
                                                  .ellipsis, // Handle overflow gracefully
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                              Icons.location_on_outlined,
                                              size: 15,
                                              color: ColorUtil.primaryColor),
                                        ),
                                        Flexible(
                                          child: Text(
                                            adoptProvider
                                                    .adoptDetailsList[index]
                                                    .location ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // IconButton(
                                      //     onPressed: () {
                                      //       showDeleteConfirmationDialog(
                                      //           context,
                                               
                                      //           // adoptProvider
                                      //           //     .adoptDetailsList[index]
                                      //           //     .id!);
                                      //     },
                                      //     icon: Icon(
                                      //       Icons.delete_forever,
                                      //       color: Colors.red,
                                      //     )),
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateFirstPage(adopt: adoptProvider.adoptDetailsList[index],)));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :Center(child: Text("No data Available"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, AdoptProvider adoptProvider, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await adoptProvider.deleteAdoptData(id).then((value) async {
                  if (adoptProvider.deleteAdoptDetails == StatusUtil.success) {
                    await adoptProvider.getAdoptdata();
                    Helper.snackBar("Delete Successfully", context);
                    Navigator.pop(context);
                    
                  }
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
