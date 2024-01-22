import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/view/donate/donate_2.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class DonateFirstPage extends StatefulWidget {
  const DonateFirstPage({super.key});

  @override
  State<DonateFirstPage> createState() => _DonateFirstPageState();
}

class _DonateFirstPageState extends State<DonateFirstPage> {
  String? gender;
  Object? value;
  // late SingleValueDropDownController _cnt;
  FocusNode textFieldFocusNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();

 

  // List of items in our dropdown menu

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
          builder: (context, adoptProvider, child) => 
          Column(
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
                      onChanged: (val) {
                        adoptProvider.petname = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petAgeStr),
                    ShopTextForm(
                      onChanged: (val) {
                        adoptProvider.petage = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     const Text(petWeightStr),
                    ShopTextForm(
                      onChanged: (val) {
                        adoptProvider.petweight = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                     const Text(petSexStr),
                    ShopTextForm(
                      onChanged: (val) {
                        adoptProvider.gender = val;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(petBreadStr),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropDownTextField(
                        dropdownRadius: 10,
                        clearOption: false,
                        textFieldFocusNode: textFieldFocusNode,
                        searchFocusNode: searchFocusNode,
                        searchAutofocus: true,
                        dropDownItemCount: 8,
                        searchShowCursor: false,
                        enableSearch: true,
                        searchKeyboardType: TextInputType.text,
                        dropDownList: const [
                          DropDownValueModel(
                              name: "Golden Retriever", value: "value1"),
                          DropDownValueModel(
                            name: 'Pet Bull',
                            value: "value2",
                          ),
                          DropDownValueModel(name: 'name3', value: "value3"),
                          DropDownValueModel(
                            name: 'name4',
                            value: "value4",
                          ),
                          DropDownValueModel(name: 'name5', value: "value5"),
                          DropDownValueModel(name: 'name6', value: "value6"),
                          DropDownValueModel(name: 'name7', value: "value7"),
                          DropDownValueModel(name: 'name8', value: "value8"),
                          DropDownValueModel(name: 'name7', value: "value7"),
                          DropDownValueModel(name: 'name8', value: "value8"),
                          DropDownValueModel(name: 'name7', value: "value7"),
                          DropDownValueModel(name: 'name8', value: "value8"),
                        ],
                        onChanged: (value) {
                          adoptProvider.petbread = value;
                        },
                      ),
                    ),
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
                                    child: Image.file(
                                      File(adoptProvider.image!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  )
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateSecond()));
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

  pickImageFromGalleryForDonate(AdoptProvider adoptProvider) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) return;

    adoptProvider.setImage(image);
  }
}
