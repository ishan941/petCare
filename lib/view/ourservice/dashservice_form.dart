import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/view/shop/shoptextform.dart';
import 'package:provider/provider.dart';

class ServiceForm extends StatefulWidget {
 final OurService? ourService;
  ServiceForm({Key? key, this.ourService}) : super(key: key);

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      gettoken();
    });

    super.initState();
  }

  gettoken() async{
    var ourServiceProvider = Provider.of<OurServiceProvider>(context, listen: false);
    await ourServiceProvider.getTokenFromSharedPref();
    await ourServiceProvider.serviceController.text;
     if (widget.ourService != null) {
      ourServiceProvider.serviceController.text = widget.ourService!.service ?? "";
      // ourServiceProvider.setImageUrl(cpimageUrl) = widget.categories!.categoriesImage;
      ourServiceProvider.setPpImageUrl(widget.ourService!.ppImage ?? "");
      ourServiceProvider.setImageUrl(widget.ourService!.cpImage ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<OurServiceProvider>(
          builder: (context, ourServiceProvider, child) =>
              SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ourServiceProvider.clearOurServiceData();
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Icon(Icons.arrow_back_ios_new_outlined),
                          ],
                        )),
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ShopTextForm(
                      labelText: selectServiceReqStr,
                      controller: ourServiceProvider.serviceController ,
                      // onChanged: (value) {
                      //   ourServiceProvider.service = value;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return selectServiceValiStr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImageFromGalleryForService(ourServiceProvider);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            height: 200,
                            width: MediaQuery.of(context).size.width * .85,
                            child: ourServiceProvider.cpimage != null
                                ? Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(ourServiceProvider.cpimage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      Text(uploadForCpStr),
                                    ],
                                  )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImageFormGalleryForPpImage(ourServiceProvider);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: MediaQuery.of(context).size.width * .85,
                        child: ourServiceProvider.ppimage != null
                            ? Padding(
                                padding: const EdgeInsets.all(1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(ourServiceProvider.ppimage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text(uploadforPpStr),
                                ],
                              )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ourServiceProvider.saveDashOurService();

                          if (ourServiceProvider.dashServiceUtil ==
                              StatusUtil.success) {
                            Helper.snackBar(successfullySavedStr, context);
                            Navigator.pop(context);
                          } else if (ourServiceProvider.dashServiceUtil ==
                              StatusUtil.error) {
                            Helper.snackBar(failedToSaveStr, context);
                          }
                        }
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImageFromGalleryForService(OurServiceProvider ourServiceProvider) async {
    final cpimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (cpimage == null) {
      return null;
    } else {
      ourServiceProvider.setImage(cpimage);
    }
  }

  pickImageFormGalleryForPpImage(OurServiceProvider ourServiceProvider) async {
    final ppimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (ppimage == null) return;
    ourServiceProvider.setPpImage(ppimage);
  }
}
