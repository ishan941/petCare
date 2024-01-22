import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/donate/donate_3.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class DonateSecond extends StatefulWidget {
  const DonateSecond({super.key});

  @override
  State<DonateSecond> createState() => _DonateSecondState();
}

class _DonateSecondState extends State<DonateSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: const Text(
          donateNowStr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => 
        SingleChildScrollView(
          child: Column(
            children: [
                 SizedBox(
                  height: 100,
                  child: Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: adoptProvider.image != null
                            ? Image.file(
                                File(adoptProvider.image!.path),
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Details"),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Next Step: Confirmation"),
                      ],
                    ),
                  ]),
                ),
                 const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Your Name"),
                      ShopTextForm(
                        onChanged: (val) {
                          adoptProvider.name = val;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(contactNumberStr),
                      ShopTextForm(
                        onChanged: (val) {
                          adoptProvider.phone = val;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(locationStr),
                      ShopTextForm(
                        onChanged: (val){
                          adoptProvider.location = val;
        
                        },
                      ),
        
                     
                      const SizedBox(
                        height: 10,
                      ),
                      
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                          child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateThird()));
                            }, child: const Text(nextStr)),
                      )),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}