import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/view/adopt/donateData.dart';
import 'package:provider/provider.dart';

class AdoptAll extends StatefulWidget {
  const AdoptAll({super.key});

  @override
  State<AdoptAll> createState() => _AdoptAllState();
}

class _AdoptAllState extends State<AdoptAll> {
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
      body: Consumer<DonateProvider>(
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
              Expanded(
                child: ListView.builder(
                  itemCount: donateProvider.donatePetList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateData(donate: donateProvider.donatePetList[index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width * 0.36,
                                  child: Image.network(
                                    donateProvider
                                            .donatePetList[index].imageUrl ??
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
                                  width: MediaQuery.of(context).size.width*0.5,
                                  child: Row(
                                    children: [
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
                                                fontWeight: FontWeight.w400),
                                          ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text(
                                            donateProvider
                                                    .donatePetList[index].petname ??
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
                                      Spacer(),
                                      Icon(Icons.favorite_outline),
                                      SizedBox(width: 5,)
                                    ],
                                  ),
                                
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 15, color: ColorUtil.primaryColor),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(donateProvider
                                            .donatePetList[index].location ??
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
