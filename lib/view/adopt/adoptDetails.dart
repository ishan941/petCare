import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:provider/provider.dart';

class AdoptDetails extends StatefulWidget {
 final Adopt? adopt;

  AdoptDetails({super.key, this.adopt});

  @override
  State<AdoptDetails> createState() => _AdoptDetailsState();
}

class _AdoptDetailsState extends State<AdoptDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
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
                      widget.adopt!.imageUrl ?? "",
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
                        widget.adopt!.petbread ?? "No data availavile",
                        style: mainTitleText,
                      ),
                      Text(
                        widget.adopt!.petname ?? "",
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
                           "-  ${widget.adopt!.petweight ?? ""}",
                            style: textStyleSmallSized,
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
                            widget.adopt!.petage ?? "",
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
                            widget.adopt!.gender ?? "",
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
                            widget.adopt!.phone ?? "",
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
                            widget.adopt!.location ?? "",
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
