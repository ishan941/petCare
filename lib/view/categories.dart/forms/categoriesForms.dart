import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class CategoriesForms extends StatefulWidget {
  const CategoriesForms({super.key});

  @override
  State<CategoriesForms> createState() => _CategoriesFormsState();
}

class _CategoriesFormsState extends State<CategoriesForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) => SizedBox(
          child: Column(
            children: [
              Container(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickImageFormGallery(categoriesProvider);
                      },
                      child: DottedBorder(
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Text("Pick Image"),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: categoriesProvider.image != null
                          ? Image.file(File(categoriesProvider.image!.path))
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ShopTextForm(
                      hintText: "Name",
                      onChanged: (value) {
                        categoriesProvider.categoryName = value;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await categoriesProvider
                              .saveCategoriesDataToFireBase();

                          if (categoriesProvider.categoriesUtil ==
                              StatusUtil.success) {
                            Helper.snackBar(successfullySavedStr, context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()),
                                (route) => false);
                          } else {
                            Helper.snackBar(failedToSaveStr, context);
                          }
                        },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImageFormGallery(CategoriesProvider categoriesProvider) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await categoriesProvider.setImage(image);
  }
}
