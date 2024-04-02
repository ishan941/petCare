import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/constDescriptionForm.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/adopt.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/loader.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class SellingPet extends StatefulWidget {
  final String? choice;
  final Adopt? adopt;
  SellingPet({this.choice, this.adopt, Key? key}) : super(key: key);

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
  List<String> petBreadList = ["Dog", "Cat", "Fish"];
  List<String> dogBredList = List.from(dogBreedList);
  List<String> catBreadList = List.from(catBreedList);
  List<String> fishBreadList = List.from(fishBreedList);
  // List<String> _getBreedList(String petCategory) {
  //   switch (petCategory) {
  //     case "Dog":
  //       return dogBreedList;
  //     case "Cat":
  //       return catBreedList;
  //     case "Fish":
  //       return fishBreedList;
  //     default:
  //       return [];
  //   }
  // }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller();
    });

    super.initState();
  }

  controller() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    var petCareProvider = Provider.of<PetCareProvider>(context, listen: false);
    await sellingPetProvider.getTokenFromSharedPref();
    sellingPetProvider.setUserName(petCareProvider.userName ?? "");
    sellingPetProvider.setUserPhone(petCareProvider.userPhone ?? "");

    if (widget.adopt != null) {
      sellingPetProvider.petNameController.text = widget.adopt!.petName ?? "";
      sellingPetProvider.petAgeController.text = widget.adopt!.petAge ?? "";
      sellingPetProvider.petAgeController.text = widget.adopt!.petPrice ?? "";
      sellingPetProvider.petWeightController.text =
          widget.adopt!.petWeight ?? "";
      sellingPetProvider.ownerLocationController.text =
          widget.adopt!.location ?? "";
      sellingPetProvider.setImageUrl(widget.adopt!.imageUrl ?? "");
      sellingPetProvider.setId(widget.adopt!.id!);
      sellingPetProvider.setPetGender(widget.adopt!.gender ?? "");
      sellingPetProvider.setCategory(widget.adopt!.categories ?? "");
      sellingPetProvider.setAgeTime(widget.adopt!.petAgeTime ?? "");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<SellingPetProvider>(context, listen: false).clearData();
          return true; // Allow back navigation
        },
        child: Scaffold(
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
                builder: (context, adoptProvider, child) => Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(children: [
                          const SizedBox(
                            width: 20,
                          ),
                          // CircularPercentIndicator(
                          //   radius: 30,
                          //   animation: true,
                          //   animateFromLastPercent: true,
                          //   percent: adoptProvider.per,
                          //   center: Text("1 to 3"),
                          //   progressColor: ColorUtil.primaryColor,
                          //   onAnimationEnd: () {
                          //     adoptProvider.updatePercent(0.333);
                          //   },
                          // ),
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
                              hintText: 'Luffy',
                              controller: sellingPetProvider.petNameController,
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
                                  width:
                                      MediaQuery.of(context).size.width * .18,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: ShopTextForm(
                                    hintText: "30",
                                    controller:
                                        sellingPetProvider.petAgeController,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CustomDropDown(
                                      hintText: "Days",
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
                              hintText: "5 kg",
                              controller:
                                  sellingPetProvider.petWeightController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(petSexStr),
                            CustomDropDown(
                                hintText: "Male",
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
                                hintText: "Dog",
                                onChanged: (value) {
                                  sellingPetProvider.petCategories = value;
                                },
                                value: sellingPetProvider.petCategories,
                                itemlist: petCategoriesList),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Pick Image'),
                            InkWell(
                              onTap: () {
                                pickImageFromGalleryForDonate(
                                    sellingPetProvider);
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all()),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: sellingPetProvider.imageUrl != null
                                        ? Image.network(
                                            sellingPetProvider.imageUrl!,
                                            fit: BoxFit.cover,
                                          )
                                        : sellingPetProvider.image != null
                                            ? Image.file(
                                                File(sellingPetProvider
                                                    .image!.path),
                                                fit: BoxFit.cover,
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .photo_library_outlined,
                                                    color: ColorUtil
                                                        .secondaryColor,
                                                    size: 60,
                                                  ),
                                                  Text(
                                                      "Uploade image from Gallery")
                                                ],
                                              ),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Description"),
                            DescriptionTextForm(
                              hintText: "Write some this about your pet",
                              controller:
                                  sellingPetProvider.descriptionController,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            const Text(locationStr),
                            ShopTextForm(
                              hintText: "Banepa Nala Kavre",
                              controller:
                                  sellingPetProvider.ownerLocationController,
                            ),
                            if (widget.choice == 'Sale')
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  const Text('Pet Price'),
                                  ShopTextForm(
                                    controller:
                                        sellingPetProvider.petPriceController,
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FormLoader()));
                                      if (widget.choice == "Sale") {
                                        selling(sellingPetProvider);
                                      } else if (widget.choice == "Donate") {
                                        donate(sellingPetProvider);
                                      }
                                    }
                                  },
                                  child: Text(submitStr)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

  Future<void> selling(SellingPetProvider sellingPetProvider) async {
    await sellingPetProvider.sendSellingPet();
    if (sellingPetProvider.saveSellingPetutil == StatusUtil.success) {
      Helper.snackBar(successfullySavedStr, context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (Route<dynamic> route) => false);
      sellingPetProvider.clearData();
      //  adoptProvider.formKey!.currentState!.reset();
    } else {
      Helper.snackBar(sellingPetProvider.errorMessage!, context);
      Navigator.pop(context);
    }
  }

  Future<void> donate(SellingPetProvider sellingPetProvider) async {
    await sellingPetProvider.sendDonatePet();
    if (sellingPetProvider.saveDonatePetUtil == StatusUtil.success) {
      Helper.snackBar(successfullySavedStr, context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (Route<dynamic> route) => false);
      sellingPetProvider.clearData();
      //  adoptProvider.formKey!.currentState!.reset();
    } else {
      Helper.snackBar(sellingPetProvider.errorMessage!, context);
      Navigator.pop(context);
    }
  }
}
