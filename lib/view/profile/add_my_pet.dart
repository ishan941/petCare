import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/customDropMenu.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/mypet_provider.dart';
import 'package:provider/provider.dart';

class AddMyPet extends StatefulWidget {
  const AddMyPet({super.key});

  @override
  State<AddMyPet> createState() => _AddMyPetState();
}

class _AddMyPetState extends State<AddMyPet> {
  List<String> petList = ["Dog", "Cat", "Fish", "Parrot", "rabbit"];
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: ColorUtil.primaryColor,
            title: Text("Add your new pet"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            )),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<MyPetProvider>(
            builder: (context, myPetProvider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDropDown(
                  hintText: "Pet Bread",
                  itemlist: petList,
                  onChanged: (value) {
                    myPetProvider.petType = value;
                  },
                  
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Your pet Name"),
                  controller: myPetProvider.nameController,
                  // onChanged: (value) {
                  //   myPetProvider.petName = value;
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name of your pet";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      await myPetProvider.saveMyPetDetailsToFireBase();
                      if (myPetProvider.myPetUtil == StatusUtil.success) {
                        Helper.snackBar("Successfully saved", context);
                        Navigator.pop(context);
                      } else {
                        Helper.snackBar("Failed to Save", context);
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
