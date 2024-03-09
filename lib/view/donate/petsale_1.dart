import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/donate/petsale_2.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class SellingPet extends StatefulWidget {
  final String choice;
  final Adopt? adopt;
  SellingPet({required this.choice, this.adopt, Key? key}) : super(key: key);

  @override
  State<SellingPet> createState() => _SellingPetState();
}

class _SellingPetState extends State<SellingPet> {
  String getTitle() {
    if (widget.choice == 'Sale') {
      return 'Sale';
    } else if (widget.choice == 'Donate') {
      return 'Donate';
    } else {
      return 'Default';
    }
  }

  String? gender;
  Object? value;
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  List<String> petAgeUnitList = ["Days", "Months", "Year"];
  List<String> petGenderList = ["Male", "Female", "Others"];
  List<String> petCategoriesList = ["Dog", "Cat", "Fish"];
  List<String> dogBredList = List.from(dogBreedList);
  List<String> catBreadList = List.from(catBreedList);
  List<String> fishBreadList = List.from(fishBreedList);
  List<String> _getBreedList(String petCategory) {
    switch (petCategory) {
      case "Dog":
        return dogBreedList;
      case "Cat":
        return catBreedList;
      case "Fish":
        return fishBreedList;
      default:
        return [];
    }
  }

  //  String getPetBreedList() {
  //   if () {
  //     return 'Sale';
  //   } else if (widget.choice == 'Donate') {
  //     return 'Donate';
  //   } else {
  //     return 'Default';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: Text(getTitle(), style: appBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<SellingPetProvider>(
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
                        height: 10,
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
                      Row(
                        children: [
                          const Text(petAgeStr),
                          Spacer(),
                          const Text("Units"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .18,
                          )
                        ],
                      ),
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
                                itemlist: petAgeUnitList),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(petWeightStr),
                      ShopTextForm(
                        onChanged: (value) {
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
                          value: sellingPetProvider.petGender,
                          itemlist: petGenderList),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(petCategoriesStr),
                      CustomDropDown(
                          onChanged: (value) {
                            sellingPetProvider.petCategories = value;
                            //  sellingPetProvider.setBreedList(_getBreedList(value));
                          },
                          value: sellingPetProvider.petCategories,
                          itemlist: petCategoriesList),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(petBreadStr),
                      CustomDropDown(
                          onChanged: (value) {
                            sellingPetProvider.petBreed = value;
                          },
                          value: sellingPetProvider.petBreed,
                          itemlist: sellingPetProvider.breedList),
                      const SizedBox(
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
                                        DonateOrSale(choice: 'Sale'),
                                  ),
                                );
                              } else if (widget.choice == 'Donate') {
                                // Navigate to the same page with Donate-specific content
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DonateOrSale(choice: 'Donate'),
                                  ),
                                );
                              }
                            },
                            child: const Text(nextStr),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
}
