import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/donate.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/adoption/ds_details.dart';
import 'package:project_petcare/view/adoption/sellingPetForm.dart';
import 'package:project_petcare/view/donate/petsale_2.dart';
import 'package:provider/provider.dart';

class MyPetsMore extends StatefulWidget {
  const MyPetsMore({super.key});

  @override
  State<MyPetsMore> createState() => _MyPetsMoreState();
}

class _MyPetsMoreState extends State<MyPetsMore> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getMyPet();
    });
    super.initState();
  }

  getMyPet() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    await sellingPetProvider.getTokenFromSharedPref();
    await sellingPetProvider.getMyPet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtil.BackGroundColorColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtil.BackGroundColorColor,
          iconTheme: IconThemeData.fallback(),
          title: Text(
            "My Pets",
            style: appBarTitle,
          ),
        ),
        body: Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) => Column(
            children: [
              sellingPetProvider.myPetList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Helper.emptyLoader(),
                          Text("Your Pet List is empty")
                        ],
                      ),
                    )
                  : Container(
                      child: Expanded(
                        child: ListView.builder(
                            itemCount: sellingPetProvider.myPetList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Ds_details(
                                          adopt: sellingPetProvider
                                              .myPetList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .1,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorUtil.primaryColor,
                                                  ),
                                                  child: sellingPetProvider
                                                          .myPetList[index]
                                                          .imageUrl!
                                                          .isEmpty
                                                      ? Text(
                                                          sellingPetProvider
                                                                  .myPetList[
                                                                      index]
                                                                  .petName
                                                                  ?.substring(
                                                                      0, 1) ??
                                                              "",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        )
                                                      : Image.network(
                                                          sellingPetProvider
                                                                  .myPetList[
                                                                      index]
                                                                  .imageUrl ??
                                                              "",
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                                Text(sellingPetProvider
                                                        .myPetList[index]
                                                        .petName ??
                                                    ""),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                sellingPetProvider
                                                            .myPetList[index]
                                                            .petPrice ==
                                                        null
                                                    ? Text(
                                                        "Adoption",
                                                        style: textStyleMini,
                                                      )
                                                    : Text(
                                                        "Selling",
                                                        style: textStyleMini,
                                                      ),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () {
                                                      if (sellingPetProvider
                                                              .myPetList[index]
                                                              .petPrice ==
                                                          null) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SellingPetForm(
                                                                choice:
                                                                    "Donate",
                                                                adopt: sellingPetProvider
                                                                        .myPetList[
                                                                    index],
                                                              ),
                                                            ));
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SellingPetForm(
                                                                choice: "Sale",
                                                                adopt: sellingPetProvider
                                                                        .myPetList[
                                                                    index],
                                                              ),
                                                            ));
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: ColorUtil
                                                          .primaryColor,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      sellingPetProvider
                                                                  .myPetList[
                                                                      index]
                                                                  .petPrice ==
                                                              null
                                                          ? showDonationDelete(
                                                              context,
                                                              sellingPetProvider,
                                                              sellingPetProvider
                                                                  .myPetList[
                                                                      index]
                                                                  .id!)
                                                          : showSellingDelete(
                                                              context,
                                                              sellingPetProvider,
                                                              sellingPetProvider
                                                                  .myPetList[
                                                                      index]
                                                                  .id!);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDonationDelete(BuildContext context,
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
                await sellingPetProvider.deleteDonatedPet(id);
                if (sellingPetProvider.deletedDonatedPetUtil ==
                    StatusUtil.success) {
                  Helper.snackBar("Successfully deleted", context);
                  Navigator.pop(context);
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

  Future<void> showSellingDelete(BuildContext context,
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
                if (sellingPetProvider.deleteSellingPetUtil ==
                    StatusUtil.success) {
                  Helper.snackBar("Successfully deleted", context);
                  Navigator.pop(context);
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
