import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/model/signUp.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:provider/provider.dart';

class FormFinalProfession extends StatefulWidget {
  SignUp? signUp;
   FormFinalProfession({super.key});

  @override
  State<FormFinalProfession> createState() => _FormFinalProfessionState();
}

class _FormFinalProfessionState extends State<FormFinalProfession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) =>  Consumer<SignUpProvider>(
          builder: (context, signUpProvider, child) => Consumer<OurServiceProvider>(
            builder: (context, ourServiceProvider, child) => Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child:
                  petCareProvider.profilePicture != null ?
                  Image.network(petCareProvider.profilePicture!):
                   Image.file(
                    File(ourServiceProvider.profilePicture!.path),
                    fit: BoxFit.cover,
                  ),
                ),
                
                
                Text(signUpProvider.fullName),
                Text(ourServiceProvider.profession ?? ""),
                Text(signUpProvider.email ?? ""),
                Text(signUpProvider.phone ?? ""),
                Text(ourServiceProvider.userName ?? ""),
                Text(ourServiceProvider.shopLocation ?? ""),
                Text(ourServiceProvider.shopName ?? ""),
                ElevatedButton(
                    onPressed: () async {
                      await ourServiceProvider.saveProfessionData();
                      if (ourServiceProvider.professionUtil == StatusUtil.success) {
                        Helper.snackBar(successfullySavedStr, context);
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomNavBar()), (route) => false);
                      } else {
                        Helper.snackBar(failedToSaveStr, context);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
