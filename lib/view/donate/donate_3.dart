import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';
import 'package:provider/provider.dart';

class DonateThird extends StatefulWidget {
  const DonateThird({super.key});

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
                    child: Image.file(
                      File(adoptProvider.image!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(adoptProvider.petname ?? ""),
                  Text(adoptProvider.petweight ?? ""),
                  Text(adoptProvider.petbread ?? ""),
                  Text(adoptProvider.phone ?? ""),
                  Text(adoptProvider.petage ?? ""),
                  Text(adoptProvider.name ?? ""),
                  Text(adoptProvider.phone ?? ""),
                  Text(adoptProvider.location ?? ""),
                  ElevatedButton(
                      onPressed: () {
                        adoptProvider.sendAdoptValueToFireBase(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                            (Route<dynamic> route) => false);
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
}
