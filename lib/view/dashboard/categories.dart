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
  List<LoadImages> imageList = [
    LoadImages(
      images: "assets/images/catsCategores.png",
    ),
    LoadImages(
      images: "assets/images/Group 1058.png",
    ),
    LoadImages(
      images: "assets/images/fishCategores.png",
    ),
    LoadImages(
      images: "assets/images/rabbitCategories.png",
    )
  ];
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
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 8.0,
                  // mainAxisSpacing: 8.0,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,
                    vertical: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // decoration: BoxDecoration(
                        //    color: Colors.blue,
                        //   borderRadius: BorderRadius.circular(20)
                        // ),
                        child: Image.asset(imageList[index].images!,
                        fit: BoxFit.cover,
                        ),
                        
                        ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
