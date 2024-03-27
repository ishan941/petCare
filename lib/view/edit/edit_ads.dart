import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/ads_provider.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/view/ads/adsform.dart';
import 'package:provider/provider.dart';

class EditAds extends StatefulWidget {
  const EditAds({super.key});

  @override
  State<EditAds> createState() => _EditAdsState();
}

class _EditAdsState extends State<EditAds> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getAds();
    });

    super.initState();
  }

  getAds() async {
    var adsProvider = Provider.of<AdsProvider>(context, listen: false);
    adsProvider.getTokenFromSharedPref();
    await adsProvider.getAdsImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<AdsProvider>(
          builder: (context, adsProvider, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: adsProvider.adsImageList.length,
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
                                          child: Image.network(adsProvider
                                              .adsImageList[index].adsImage!)),
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
                                  showDeleteConfirmationDialog(
                                      context,
                                      adsProvider,
                                      adsProvider.adsImageList[index].id!);
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

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, AdsProvider adsProvider, int id) async {
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
                await adsProvider.deleteCategory(id);
                if (adsProvider.deleteAdsUtil == StatusUtil.success) {
                  Helper.snackBar("SuccessFully Deleted", context);
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
