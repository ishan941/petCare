import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/view/profile/account.dart';

import 'package:provider/provider.dart';

class DonatedApprove extends StatefulWidget {
  const DonatedApprove({super.key});

  @override
  State<DonatedApprove> createState() => _EditShopState();
}

class _EditShopState extends State<DonatedApprove> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getApprovalDonationById();
    });

    super.initState();
  }

  getApprovalDonationById() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    sellingPetProvider.getTokenFromSharedPref();

    await sellingPetProvider.getApproveDonationPet();
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
                    itemCount: sellingPetProvider.approvalDonatePetList.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Account()));
                          },
                          child: Padding(
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
                                          child: Column(
                                            children: [
                                              Image.network(sellingPetProvider
                                                      .approvalDonatePetList[
                                                          index]
                                                      .imageUrl ??
                                                  " "),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(sellingPetProvider
                                                .approvalDonatePetList[index]
                                                .petName ??
                                            ""),
                                        Text(sellingPetProvider
                                                .approvalDonatePetList[index]
                                                .ownerName ??
                                            ""),
                                        Text(sellingPetProvider
                                                .approvalDonatePetList[index]
                                                .ownerPhone ??
                                            ""),
                                        Text(sellingPetProvider
                                                .approvalDonatePetList[index]
                                                .petAge ??
                                            ""),
                                        Text(sellingPetProvider
                                                .approvalDonatePetList[index]
                                                .petWeight ??
                                            ""),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                onPressed: () async {
                                  // await sellingPetProvider.setIsAccepted(true);

                                  await sellingPetProvider.approveDonate(
                                      sellingPetProvider
                                          .approvalDonatePetList[index].id!);
                                  if (sellingPetProvider
                                          .approveDonatedPetUtil ==
                                      StatusUtil.success) {
                                    Helper.snackBar(
                                        "SuccessFully Approved", context);
                                  } else if (sellingPetProvider
                                          .approveDonatedPetUtil ==
                                      StatusUtil.error) {
                                    Helper.snackBar("Failed", context);
                                  }
                                },
                                child: Text("Approve")),
                            ElevatedButton(
                                onPressed: () async {
                                  await sellingPetProvider.declineDonate(
                                      sellingPetProvider
                                          .approvalDonatePetList[index].id!);
                                },
                                child: Text("Decline"))
                          ],
                        ),
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
                await sellingPetProvider.declineDonate(id);
                if (sellingPetProvider.deletedDonatedPetUtil ==
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
