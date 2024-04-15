import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/adoption/sellingPetForm.dart';
import 'package:provider/provider.dart';

class EditSelling extends StatefulWidget {
  const EditSelling({super.key});

  @override
  State<EditSelling> createState() => _EditSellingState();
}

class _EditSellingState extends State<EditSelling> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getSellingById();
    });

    super.initState();
  }

  getSellingById() async {
    var sellingPetProvider = Provider.of<SellingPetProvider>(context, listen: false);
    sellingPetProvider.getTokenFromSharedPref();
    await sellingPetProvider.getSellingPetData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sellingPetProvider.sellingPetList.length,
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
                                          child: Column(
                                            children: [
                                              Image.network(sellingPetProvider
                                                  .sellingPetList[index].imageUrl ?? " "),

                                                  Text(sellingPetProvider.sellingPetList[index].petName?? ""),
                                            ],
                                          )),
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
                                          builder: (context) => SellingPetForm(
                                            choice: "Sale",
                                              adopt: sellingPetProvider
                                                  .sellingPetList[index])));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(
                                      context,
                                      sellingPetProvider,
                                      sellingPetProvider
                                          .sellingPetList[index].id!);
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
      SellingPetProvider sellingPetProvider, int id) async {
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
              await sellingPetProvider.deleteSellingPet(id);
                if (sellingPetProvider.deleteSellingPetUtil==
                    StatusUtil.success) {
                  Helper.snackBar("Successfully deleted", context);
                } else
                  Helper.snackBar('Failed to delete', context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
