import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/donate/donate_2.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class DonateFirstPage extends StatefulWidget {
  Adopt? adopt;
  DonateFirstPage({super.key, this.adopt});

  @override
  State<DonateFirstPage> createState() => _DonateFirstPageState();
}

class _DonateFirstPageState extends State<DonateFirstPage> {
  String? gender;
  Object? value;
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  List<String> petAgeCalcList = ["Days", "Months", "Year"];
  List<String> petBreadList = List.from(dogBreedList);
  List<String> petGenderList = ["Male", "Female", "Others"];

  // List of items in our dropdown menu
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, () {
  //     var adoptProvider = Provider.of<AdoptProvider>(context, listen: false);
  //     if (widget.adopt != null) {
  //       adoptProvider.petnameController.text = widget.adopt!.petname!;
  //       adoptProvider.petAgeController.text = widget.adopt!.petage!;
  //       adoptProvider.petweightController.text = widget.adopt!.petweight!;
  //       adoptProvider.setPetGender(widget.adopt!.gender!);
  //       adoptProvider.setPetBread(widget.adopt!.petbread!);
  //       adoptProvider.setImageUrl(widget.adopt!.imageUrl);
  //       adoptProvider.setPetAgeTime(widget.adopt!.petAgeTime!);
  //       adoptProvider.ownerLocationController.text = widget.adopt!.location!;
  //       adoptProvider.ownerNameController.text = widget.adopt!.name!;
  //       adoptProvider.ownerPhoneController.text = widget.adopt!.phone!;
  //     }
  //   });

  //   super.initState();
  // }

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
      body: SingleChildScrollView(
        child: Consumer<AdoptProvider>(
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
                    center: Text("1 to 3"),
                    progressColor: ColorUtil.primaryColor,
                    onAnimationEnd: () {
                      adoptProvider.updatePercent(0.333);
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pet Details"),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Next Step: Your Details"),
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
                    const Text(petNameStr),
                    ShopTextForm(
                         onChanged: (value){
                          adoptProvider.petName = value;
                         },
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petAgeStr),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .6,
                          child: ShopTextForm(
                            onChanged: (value){
                          adoptProvider.petAge = value;
                         },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomDropDown(
                              onChanged: (value) {
                                adoptProvider.petAgeTime = value;
                              },
                              value: adoptProvider.petAgeTime,
                              itemlist: petAgeCalcList),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petWeightStr),
                    ShopTextForm(
                      onChanged: (value){
                          adoptProvider.petWeight = value;
                         },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petSexStr),
                    CustomDropDown(
                        onChanged: (value) {
                          adoptProvider.petGender = value;
                        },
                        value: adoptProvider.petGender,
                        itemlist: petGenderList),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petBreadStr),
                    CustomDropDown(
                        onChanged: (value) {
                          adoptProvider.petBreed = value;
                        },
                        value:  adoptProvider.petBreed,
                        itemlist: dogBreedList),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        pickImageFromGalleryForDonate(adoptProvider);
                      },
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        child:
                            //
                            adoptProvider.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: adoptProvider.imageUrl != null &&
                                            adoptProvider.image != null
                                        ? Image.network(adoptProvider.imageUrl!)
                                        : adoptProvider.image != null
                                            ? Image.file(
                                                File(adoptProvider.image!.path),
                                                fit: BoxFit.cover,
                                              )
                                            : SizedBox())
                                : Icon(
                                    Icons.photo_library_outlined,
                                    size: 70,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                      ),
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
                                    builder: (context) => DonateSecond(
                                      adopt: adoptProvider.adoptDetailsList.first
                                      )));
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

  pickImageFromGalleryForDonate(AdoptProvider adoptProvider) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) return;

    adoptProvider.setImage(image);
  }
}
