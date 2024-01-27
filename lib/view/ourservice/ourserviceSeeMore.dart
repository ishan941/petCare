import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';

class OurServiceSeeMore extends StatefulWidget {
  const OurServiceSeeMore({super.key});

  @override
  State<OurServiceSeeMore> createState() => _OurServiceSeeMoreState();
}

class _OurServiceSeeMoreState extends State<OurServiceSeeMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                child:Row(

                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
                    Center(
                      child: Text("Our Service",
                    style: mainTitleText,)),
                  ],
                ),
              ),
             
            ],
          )
        ],
      ),
    );
  }
}