import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/donate/donate_3.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class DonateSecond extends StatefulWidget {
  Adopt? adopt;
   DonateSecond({super.key, this.adopt});

  @override
  State<DonateSecond> createState() => _DonateSecondState();
}

class _DonateSecondState extends State<DonateSecond> {
  @override
  void initState() {
      var adoptProvider = Provider.of<AdoptProvider>(context, listen: false);
    if (adoptProvider != null) {
      adoptProvider.petnameController.text = widget.adopt!.petname!;
      adoptProvider.petAgeController.text = widget.adopt!.petage!;
      adoptProvider.petweightController.text = widget.adopt!.petweight!;
     
    }
    super.initState();
  }
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
        builder: (context, adoptProvider, child) => SingleChildScrollView(
          child: Column(
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
                    center: Text("2 to 3"),
                    progressColor: ColorUtil.primaryColor,
                    onAnimationEnd: () {
                      adoptProvider.updatePercent(0.60);
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Your Name"),
                    ShopTextForm(
                      controller: adoptProvider.ownerNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(contactNumberStr),
                    ShopTextForm(
                     controller: adoptProvider.ownerPhoneController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(locationStr),
                    ShopTextForm(
                     controller: adoptProvider.ownerLocationController,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonateThird(adopt: adoptProvider.adoptDetailsList.first, )));
                          },
                          child: const Text(nextStr)),
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
