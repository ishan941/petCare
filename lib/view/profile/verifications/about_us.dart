import 'package:flutter/material.dart';
import 'package:project_petcare/helper/string_const.dart';
import 'package:project_petcare/helper/textStyle_const.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        title: Text("About Us",
        style: appBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                
                children: [
                  Image.asset("assets/images/petcareLogi.png"),
                  Text(aboutUs,
                  style: appBarTitle,
                  ),
                  Text(aboutUs,
                  style: appBarTitle,
                  ),
                  Text(aboutUs,
                  style: appBarTitle,
                  ),
                  Text(aboutUs,
                  style: appBarTitle,
                  ),
                  Text(aboutUs,
                  style: appBarTitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}