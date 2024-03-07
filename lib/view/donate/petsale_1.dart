import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class SellingPet extends StatefulWidget {

  SellingPet({super.key});

  @override
  State<SellingPet> createState() => _SellingPetState();
}

class _SellingPetState extends State<SellingPet> {
  String? gender;
  Object? value;
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  List<String> petAgeCalcList = ["Days", "Months", "Year"];
  List<String> petBreadList = List.from(dogBreedList);
  List<String> petGenderList = ["Male", "Female", "Others"];

  

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
        child: Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) =>  Consumer<AdoptProvider>(
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
                            sellingPetProvider.petName = value;
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
                            sellingPetProvider.petAge = value;
                           },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomDropDown(
                                onChanged: (value) {
                                  sellingPetProvider.petAgeTime = value;
                                },
                                value: sellingPetProvider.petAgeTime,
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
                            sellingPetProvider.petWeight = value;
                           },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(petSexStr),
                      CustomDropDown(
                          onChanged: (value) {
                            sellingPetProvider.petGender = value;
                          },
                          value: adoptProvider.petGender,
                          itemlist: petGenderList),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(petBreadStr),
                      // CustomDropDown(
                      //     onChanged: (value) {
                      //       sellingPetProvider.petBreed = value;
                      //     },
                      //     value:  sellingPetProvider.petBreed,
                      //     itemlist: petGenderList),
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
                        ElevatedButton(
                        onPressed: () async {
                          // await adoptProvider.sendAdoptValueToFireBase(context);
                          await sellingPetProvider.sendSellingPet();
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
                ),
              ],
            ),
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
