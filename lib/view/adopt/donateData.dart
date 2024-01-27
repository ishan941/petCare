import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:provider/provider.dart';

class DonateData extends StatefulWidget {
 final Donate? donate;

  DonateData({super.key, this.donate});

  @override
  State<DonateData> createState() => _DonateDataState();
}

class _DonateDataState extends State<DonateData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<DonateProvider>(
        builder: (context, donateProvider, child) => Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // height: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 3,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      widget.donate!.imageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: ),
                      
                      Text(
                        widget.donate!.petbread ?? "",
                        style: mainTitleText,
                      ),
                      Text(
                        widget.donate!.petname ?? "",
                        style: titleText,
                      ),
                      Row(
                        children: [
                          Text(
                            petWeightStr,
                            style: subTitleText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.donate!.petweight ?? "",
                            style: titleText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            petAgeStr,
                            style: subTitleText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.donate!.petage ?? "",
                            style: titleText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            petSexStr,
                            style: subTitleText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.donate!.gender ?? "",
                            style: titleText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            contactNumberStr,
                            style: subTitleText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.donate!.phone ?? "",
                            style: titleText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            locationStr,
                            style: subTitleText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.donate!.location ?? "",
                            style: titleText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
