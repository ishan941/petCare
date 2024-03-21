import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/donate/petsale_3.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class DonateOrSale extends StatefulWidget {
  final String? choice;
  final Adopt? adopt;
  DonateOrSale({required this.choice, this.adopt, Key? key}) : super(key: key);

  @override
  State<DonateOrSale> createState() => _DonateOrSaleState();
}

class _DonateOrSaleState extends State<DonateOrSale> {
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
  void initState() {
    Future.delayed(Duration.zero, () {
      controller();
    });

    super.initState();
  }

  controller() {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    if (widget.adopt != null) {
      sellingPetProvider.petNameController.text = widget.adopt!.petName!;
      sellingPetProvider.petAgeController.text = widget.adopt!.petAge!;
      sellingPetProvider.petWeightController.text = widget.adopt!.petWeight!;
      sellingPetProvider.ownerLocationController.text = widget.adopt!.location!;
      sellingPetProvider.petPriceController.text = widget.adopt!.petPrice!;
      sellingPetProvider.setImageUrl(widget.adopt!.imageUrl);
      sellingPetProvider.setId(widget.adopt!.id!);
      sellingPetProvider.setPetGender(widget.adopt!.gender!);
      sellingPetProvider.setCategory(widget.adopt!.categories!);
      sellingPetProvider.setAgeTime(widget.adopt!.petAgeTime!);
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
          getTitle(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<SellingPetProvider>(
        builder: (context, sellingPetProvider, child) =>
            Consumer<AdoptProvider>(
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
                      Text('Pick Image'),
                      InkWell(
                        onTap: () {
                          pickImageFromGalleryForDonate(sellingPetProvider);
                        },
                        child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child:
                                // adoptProvider.image != null
                                //     ? Image.file(
                                //         File(adoptProvider.image!.path),
                                //         fit: BoxFit.cover,
                                //       ):
                                //        Icon(
                                //                 Icons.photo_library_outlined,
                                //                 size: 70,
                                //                 color:
                                //                     Colors.black.withOpacity(0.5),
                                //               ),
                                ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: sellingPetProvider.imageUrl != null
                                  ? Image.network(
                                      sellingPetProvider.imageUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : sellingPetProvider.image != null
                                      ? Image.file(
                                          File(sellingPetProvider.image!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.add_a_photo),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(locationStr),
                      ShopTextForm(
                        controller: sellingPetProvider.ownerLocationController,
                        // onChanged: (value) {
                        //   sellingPetProvider.ownerLocation = value;
                        // },
                      ),
                      if (widget.choice == 'Sale')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text('Pet Price'),
                            ShopTextForm(
                              controller: sellingPetProvider.petPriceController,
                              // onChanged: (value) {
                              //   sellingPetProvider.petPrice = value;
                              // },
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        child: ElevatedButton(
                            onPressed: () {
                              if (widget.choice == 'Sale') {
                                // Navigate to the same page with Sale-specific content
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DonateOrSaleConfirmation(
                                            choice: 'Sale',
                                             adopt: sellingPetProvider.sellingPetList.first,
                                            ),
                                  ),
                                );
                              } else if (widget.choice == 'Donate') {
                                // Navigate to the same page with Donate-specific content
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DonateOrSaleConfirmation(
                                           adopt: sellingPetProvider.donatePetList.first,
                                            choice: 'Donate'),
                                  ),
                                );
                              }
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
      ),
    );
  }

  pickImageFromGalleryForDonate(SellingPetProvider sellingPetProvider) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) return;

    sellingPetProvider.setImage(image);
  }
}
