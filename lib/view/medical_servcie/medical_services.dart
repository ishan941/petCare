import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/view/customs/consttextform.dart';
import 'package:project_petcare/view/medical_servcie/lastvisited_Ms.dart';
import 'package:project_petcare/view/medical_servcie/nearby_Ms.dart';
import 'package:project_petcare/view/medical_servcie/popular_Ms.dart';

class MedicalServices extends StatefulWidget {
  // DashService? dashService;
   const MedicalServices({super.key, });

  @override
  State<MedicalServices> createState() => _MedicalServicesState();
}

class _MedicalServicesState extends State<MedicalServices> {

  PageController pageController = PageController();
 final List<bool> _selection = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: const IconThemeData.fallback(),
        title: const Text(
          // (widget.dashService!.service!),
          (""),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ConstTextForm(
                      hintText: "Search here...",
                      suffixIcon: const  Icon(Icons.search),
                    ),
                  ),
                ),
             const    SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 3,
                        color: Colors.grey.withOpacity(1),
                        offset: Offset(2, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: 55,
                  height: 55,
                  child: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
       const    SizedBox(
            height: 15,
          ),
       const    Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                exploreVetStr,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          ToggleButtons (
            isSelected: _selection,
            onPressed: (index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < _selection.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    _selection[buttonIndex] = true;
                  } else {
                    _selection[buttonIndex] = false;
                  }
                }
                pageController.jumpToPage(index);
              });
            },
            borderWidth: 0,
            borderRadius: BorderRadius.zero, // Set border radius to zero
            textStyle: TextStyle(color: Colors.black),
            children: [
              SizedBox
              
              (
                width: 120,
                child: Text(
                 popularVetStr,
                  style: _selection[0]
                      ? const TextStyle(
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          decorationThickness: 2,
                        )
                      : TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5),
                        ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    nearbyVetStr,
                    style: _selection[1]
                        ? const TextStyle(
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            decorationThickness: 2,
                          )
                        : TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                     lastvisitedStr,
                      style: _selection[2]
                          ? const TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              decorationThickness: 2,
                            )
                          : TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
         const  SizedBox(
            height: 20,
          ),
          Expanded(
            child: PageView(
                controller: pageController,
                children:const [
                  Popular_medicalService(),
                  Nearby_MedicalServices(),
                  LastVisited_MedicalServices(),
                ],
                onPageChanged: (index) => setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _selection.length;
                          buttonIndex++) {
                        _selection[buttonIndex] = (buttonIndex == index);
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
