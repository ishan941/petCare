import 'package:flutter/material.dart';
import 'package:project_petcare/model/mypet.dart';


class PetProfile extends StatefulWidget {
  MyPet? myPet;
  PetProfile({super.key, this.myPet});

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myPet!.petName ?? ""),
        centerTitle: true,
      ),
      body: Column(),
    );
  }
}
