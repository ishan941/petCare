import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';

class CategoriesExplore extends StatefulWidget {
  const CategoriesExplore({super.key});

  @override
  State<CategoriesExplore> createState() => _CategoriesExploreState();
}

class _CategoriesExploreState extends State<CategoriesExplore> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Text(
                  categoriesStr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
         
          ],
        ),
      ),
    );
  }
}
