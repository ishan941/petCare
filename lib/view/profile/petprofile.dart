import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/mypet.dart';
import 'package:project_petcare/provider/mypet_provider.dart';
import 'package:provider/provider.dart';

class PetProfile extends StatefulWidget {
  final MyPet? myPet;

  PetProfile({super.key, this.myPet});

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var myPetProvider = Provider.of<MyPetProvider>(context, listen: false);
      myPetProvider.nameController.text = widget.myPet?.petName ?? "";
      myPetProvider.dobController.text = widget.myPet?.dateOfBirth ?? "";
      myPetProvider.typeController.text = widget.myPet?.petType ?? "";
      myPetProvider.breedController.text = widget.myPet?.petSex ?? "";
      myPetProvider.sexController.text = widget.myPet?.petSex ?? "";
      myPetProvider.colorController.text = widget.myPet?.petColor ?? "";
      myPetProvider.descriptionController.text =
          widget.myPet?.description ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.primaryColor,
        title: Text("${widget.myPet?.petName ?? ""}'s Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<MyPetProvider>(
          builder: (context, myPetProvider, child) => Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 100,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Center(
                    child: Text(
                  widget.myPet?.petName?.substring(0, 1) ?? "",
                  style: TextStyle(fontSize: 50),
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("Pet's information"),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Colors.grey.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              _buildRow("Name", myPetProvider),
                              _buildRow("Date of Birth", myPetProvider),
                              _buildRow("Type", myPetProvider),
                              _buildRow("Breed", myPetProvider),
                              _buildRow("Sex", myPetProvider),
                              _buildRow("Color", myPetProvider),
                              _buildRow("Description", myPetProvider),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, MyPetProvider myPetProvider) {
    return Column(
      children: [
        Row(
          children: [
            Text(label),
            Spacer(),
            InkWell(
              onTap: () {
                if (label == 'Breed') {
                  _showDropdownDialog(context, label, myPetProvider);
                } else {
                  _showTextAlertDialog(context, label, myPetProvider);
                }
              },
              child: Text(
                label == 'Breed'
                    ? myPetProvider.petBreed ?? 'Tap to add'
                    : _getControllerValue(label, myPetProvider),
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  String _getControllerValue(String label, MyPetProvider myPetProvider) {
    switch (label) {
      case 'Name':
        return myPetProvider.nameController.text;
      case 'Date of Birth':
        return myPetProvider.dobController.text;
      case 'Type':
        return myPetProvider.typeController.text;
      case 'Sex':
        return myPetProvider.sexController.text;
      case 'Color':
        return myPetProvider.colorController.text;
      case 'Description':
        return myPetProvider.descriptionController.text;
      default:
        return '';
    }
  }

  void _showTextAlertDialog(
      BuildContext context, String label, MyPetProvider myPetProvider) {
    String userInput = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter $label'),
          content: TextFormField(
            onChanged: (value) {
              userInput = value;
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: 'Enter your $label here',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                myPetProvider.saveMyPetDetailsToFireBase();
                if (myPetProvider.myPetUtil == StatusUtil.success) {
                  Helper.snackBar(successfullySavedStr, context);
                } else {
                  Helper.snackBar(failedToSaveStr, context);
                }
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showDropdownDialog(
      BuildContext context, String label, MyPetProvider myPetProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $label'),
          content: DropdownButton<String>(
            value: myPetProvider.petBreed,
            onChanged: (String? value) {
              myPetProvider.petBreed = value;
              Navigator.of(context).pop(); // Close the AlertDialog
            },
            items: dogBreedList // Replace with your actual list of breeds
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
