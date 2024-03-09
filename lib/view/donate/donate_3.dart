import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:provider/provider.dart';

class DonateThird extends StatefulWidget {
    Adopt? adopt;
  DonateThird({Key? key, this.adopt}) : super(key: key);

  @override
  State<DonateThird> createState() => _DonateThirdState();
}

class _DonateThirdState extends State<DonateThird> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<AdoptProvider>(
        builder: (context, adoptProvider, child) => Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(children: [
                const SizedBox(
                  width: 20,
                ),
                CircularPercentIndicator(
                  radius: 30,
                  animation: true,
                  animateFromLastPercent: true,
                  percent: adoptProvider.per,
                  center: Icon(
                    Icons.done,
                    color: ColorUtil.primaryColor,
                    size: 30,
                  ),
                  progressColor: ColorUtil.primaryColor,
                  onAnimationEnd: () {
                    adoptProvider.updatePercent(1);
                  },
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                 
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child:
                   
                    
                     Image.file(
                      File(adoptProvider.image!.path),
                      fit: BoxFit.cover,
                    )
                  ),
                  // Text(adoptProvider.petName ?? ""),
                  // Text(adoptProvider.petWeight ?? "" ),
                  // Text(adoptProvider.petBreed ?? ""),
                  // Text(adoptProvider.petAgeTime ?? ""),
                  // Text(adoptProvider.petAge ?? ""),
                  // Text(adoptProvider.petGender ?? ""),
                  // Text(adoptProvider.ownerName ?? ""),
                  
                  // Text(adoptProvider.ownerNameController.text),
                  // Text(adoptProvider.ownerLocationController.text ),
                  // Text(adoptProvider.ownerPhoneController.text ),

                  //widget
                
                  ElevatedButton(
                      onPressed: () async {
                        await adoptProvider.sendAdoptValueToFireBase(context);
                        if(adoptProvider.adoptUtil == StatusUtil.success){
                          Helper.snackBar(successfullySavedStr, context);
                            Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                            (Route<dynamic> route) => false);
                            //  adoptProvider.formKey!.currentState!.reset();
                        }else{
                          Helper.snackBar(adoptProvider.errorMessage!, context);
                        }
                       
                       
                      
                      },
                      child: Text(submitStr))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  // reset(AdoptProvider adoptProvider){
  //   adoptProvider.petAgeController.clear();
  //   adoptProvider.petnameController.clear();
  //   adoptProvider.petweightController.clear();
  //   adoptProvider.ownerLocationController.clear();
  //   adoptProvider.ownerNameController.clear();
  //   adoptProvider.ownerPhoneController.clear();
  // }
}
