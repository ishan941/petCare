import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:provider/provider.dart';

class DonateOrSaleConfirmation extends StatefulWidget {
  final String? choice;
  final Adopt? adopt;
  DonateOrSaleConfirmation({Key? key, this.adopt, this.choice})
      : super(key: key);

  @override
  State<DonateOrSaleConfirmation> createState() =>
      _DonateOrSaleConfirmationState();
}

class _DonateOrSaleConfirmationState extends State<DonateOrSaleConfirmation> {
  String getTitle() {
    if (widget.choice == 'Sale') {
      return 'Sale';
    } else if (widget.choice == 'Donate') {
      return 'Donate';
    } else {
      return 'Default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: Text(
          "${getTitle()} Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<SellingPetProvider>(
        builder: (context, sellingPetProvider, child) =>
            Consumer<AdoptProvider>(
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
                    ElevatedButton(
                        onPressed: () async {
                          if(widget.choice == "Sale"){
                            selliing(sellingPetProvider);
                          }else if(widget.choice =="Donate"){
                            donate(sellingPetProvider);
                          }
                        }, child: Text(submitStr))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  selliing(SellingPetProvider sellingPetProvider) async {
    await sellingPetProvider.sendSellingPet();
    if (sellingPetProvider.saveSellingPetutil == StatusUtil.success) {
      Helper.snackBar(successfullySavedStr, context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (Route<dynamic> route) => false);
      //  adoptProvider.formKey!.currentState!.reset();
    } else {
      Helper.snackBar(sellingPetProvider.errorMessage!, context);
    }
  }
   donate(SellingPetProvider sellingPetProvider) async {
    await sellingPetProvider.sendDonatePet();
    if (sellingPetProvider.saveDonatePet == StatusUtil.success) {
      Helper.snackBar(successfullySavedStr, context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (Route<dynamic> route) => false);
      //  adoptProvider.formKey!.currentState!.reset();
    } else {
      Helper.snackBar(sellingPetProvider.errorMessage!, context);
    }
  }
}
