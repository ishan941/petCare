import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/loader.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class CategoriesForms extends StatefulWidget {
  final Categories? categories;
  CategoriesForms({Key? key, this.categories}) : super(key: key);

  @override
  State<CategoriesForms> createState() => _CategoriesFormsState();
}

class _CategoriesFormsState extends State<CategoriesForms> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // getCategoryById(id);
      controller();
    });

    super.initState();
  }

  controller() {
    var categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    if (widget.categories != null) {
      categoriesProvider.categoriesNameController.text =
          widget.categories!.categoriesName!;
      categoriesProvider.setImageUrl(widget.categories!.categoriesImage);
      categoriesProvider.setItd(widget.categories!.id);
    }
  }

  // getCategoryById(int id) async {
  //   var categoriesProvider =
  //       Provider.of<CategoriesProvider>(context, listen: false);
  //   await categoriesProvider.getCategoriesById(id);
  // }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) => Form(
          key: _formKey,
          child: SizedBox(
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
                          categoriesProvider.clearField();
                          categoriesProvider.clearImage();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_outlined)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ShopTextForm(
                        hintText: " Category",
                        controller: categoriesProvider.categoriesNameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImageFormGallery(categoriesProvider);
                        },
                        child: DottedBorder(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      categoriesProvider.imageUrl != null
                                          ? Image.network(
                                              categoriesProvider.imageUrl!,
                                              fit: BoxFit.cover,
                                            )
                                          : categoriesProvider.image != null
                                              ? Image.file(
                                                  File(categoriesProvider
                                                      .image!.path),
                                                  fit: BoxFit.cover,
                                                )
                                              : Center(
                                                  child:
                                                      Icon(Icons.add_a_photo)),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            categoriesProvider.clearImage();
                                          },
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.clear,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormLoader()));
                              await categoriesProvider.saveCategory();

                              if (categoriesProvider.categoriesUtil ==
                                  StatusUtil.success) {
                                Helper.snackBar(successfullySavedStr, context);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar()),
                                    (route) => false);
                                categoriesProvider.clearField();
                                categoriesProvider.clearImage();
                              } else {
                                Helper.snackBar(failedToSaveStr, context);
                                Navigator.pop(context);
                              }
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
      ),
    );
  }

  pickImageFormGallery(CategoriesProvider categoriesProvider) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await categoriesProvider.setImage(image);
  }
}
