import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/view/categories.dart/forms/categoriesForms.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getCategories();
    });

    super.initState();
  }

  getCategories() async {
    var categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesProvider.getTokenFromSharedPref();
    await categoriesProvider.getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<CategoriesProvider>(
          builder: (context, categoriesProvider, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: categoriesProvider.categoriesList.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              // height: 200,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                          // height: 180,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: Image.network(
                                              categoriesProvider
                                                  .categoriesList[index]
                                                  .categoriesImage!)),
                                    ),
                                  ),
                                  Text(categoriesProvider
                                      .categoriesList[index].categoriesName!),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoriesForms(
                                              categories: categoriesProvider
                                                  .categoriesList[index])));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(
                                      context,
                                      categoriesProvider,
                                      categoriesProvider
                                          .categoriesList[index].id!);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context,
      CategoriesProvider categoriesProvider, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await categoriesProvider.deleteCategory(id);
                if (categoriesProvider.deleteCategoriesUtil ==
                    StatusUtil.success) {
                  Helper.snackBar("Successfully Deletd", context);
                  Navigator.pop(context);
                } else
                  Helper.snackBar("Failed to delete", context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
