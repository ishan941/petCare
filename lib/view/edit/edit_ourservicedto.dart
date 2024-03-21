import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/ads_provider.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/ourservice/apiservicedto.dart';
import 'package:project_petcare/view/ourservice/dashservice_form.dart';
import 'package:provider/provider.dart';

class EditOurServiceDto extends StatefulWidget {
  const EditOurServiceDto({super.key});

  @override
  State<EditOurServiceDto> createState() => _EditOurServiceState();
}

class _EditOurServiceState extends State<EditOurServiceDto> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getOurServiceDto();
    });

    super.initState();
  }

  getOurServiceDto() async {
    var ourServiceProvider =
        Provider.of<OurServiceProvider>(context, listen: false);
    ourServiceProvider.getTokenFromSharedPref();
    await ourServiceProvider.getDashService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ourServiceProvider.ourServiceDtoList.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 100,
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
                                              ourServiceProvider
                                                  .ourServiceDtoList[index]
                                                  .image!)),
                                    ),
                                  ),
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
                                          builder: (context) =>
                                              OurServiceDtoForm(
                                                  ourServiceDto:
                                                      ourServiceProvider
                                                              .ourServiceDtoList[
                                                          index])));
                                },
                                icon: Icon(Icons.edit)),
                            // IconButton(
                            //     onPressed: () {
                            //       // showDeleteConfirmationDialog(context, categoriesProvider, categoriesProvider.categoriesList[index].id!);
                            //       showAboutDialog(context: context);

                            //     }, icon: Icon(Icons.delete)),
                            // GestureDetector(
                            //     onTap: () {
                            //       showDeleteConfirmationDialog(
                            //           context,
                            //           ourServiceProvider,
                            //           categoriesProvider
                            //               .categoriesList[index].id!);
                            //     },
                            //     child: Icon(Icons.delete))
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
                await categoriesProvider.deleteCategory(id).then((value) async {
                  if (categoriesProvider.deleteCategoriesUtil ==
                      StatusUtil.success) {
                    await categoriesProvider.getCategoriesData();
                    Helper.snackBar("Delete Successfully", context);
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
