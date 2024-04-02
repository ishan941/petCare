import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/edit/edit_ourservicedto.dart';
import 'package:project_petcare/view/ourservice/dashservice_form.dart';
import 'package:provider/provider.dart';

class EditOurService extends StatefulWidget {
  const EditOurService({super.key});

  @override
  State<EditOurService> createState() => _EditOurServiceState();
}

class _EditOurServiceState extends State<EditOurService> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getOurService();
    });

    super.initState();
  }

  getOurService() async {
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditOurServiceDto()));
                    },
                    child: Text("OurServiceDto")),
                Expanded(
                  child: ListView.builder(
                    itemCount: ourServiceProvider.dashApiServiceList.length,
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
                                          // height: 90,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          child: Image.network(
                                              ourServiceProvider
                                                  .dashApiServiceList[index]
                                                  .ppImage!)),
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
                                          builder: (context) => ServiceForm(
                                              ourService: ourServiceProvider
                                                  .dashApiServiceList[index])));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(
                                      context,
                                      ourServiceProvider,
                                      ourServiceProvider
                                          .dashApiServiceList[index].id!);
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
      OurServiceProvider ourServiceProvider, int id) async {
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
                await ourServiceProvider.deletOurService(id);
                if (ourServiceProvider.deleteOurServiceUtil ==
                    StatusUtil.success) {
                  Helper.snackBar("Successfully deleted", context);
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
