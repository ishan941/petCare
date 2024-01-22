import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:provider/provider.dart';

class Practice1 extends StatefulWidget {
  const Practice1({super.key});

  @override
  State<Practice1> createState() => _Practice1State();
}

class _Practice1State extends State<Practice1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DonateProvider>(
        builder: (context, donateProvider, child) => 
        Stack(
          children: [
             ui(donateProvider, context),
             loader(donateProvider),
          ],
        )
      ),
    );
  }
  Widget loader(DonateProvider donateProvider){
    return Consumer<DonateProvider>(builder: (context, donateProvider, child) {
      if(donateProvider.donageUtil==StatusUtil.loading){
        return Helper.backdropFilter(context);

      }else {
        return SizedBox();
      }
    } );
  }

  Widget ui(DonateProvider donateProvider, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: (){
              if(donateProvider.donageUtil==StatusUtil.loading){
                Helper.backdropFilter(context);
               
              }
 Navigator.push(context, MaterialPageRoute(builder: (context)=> DonateFirstPage()));
          
              
            }, child: (Text("Submit"))),
          )
        ],
      );
  }
  
}