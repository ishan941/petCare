import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';

class LastVisited_MedicalServices extends StatefulWidget {
  const LastVisited_MedicalServices({super.key});

  @override
  State<LastVisited_MedicalServices> createState() =>
      _LastVisited_MedicalServicesState();
}

class _LastVisited_MedicalServicesState
    extends State<LastVisited_MedicalServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Column(
        children: [
          Text("Last Visited"),
        ],
      ),
    );
  }
}
