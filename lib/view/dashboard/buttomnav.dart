import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/practice/practice1.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:project_petcare/view/shop/shopall.dart';
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> widgetList=[
    HomePage(),
    ShopAll(),
   
    //  HomePage(),
  DonateFirstPage(),
    // Practice1()
    Profile(),
    
      //ForgetPassword(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: index,
          height: 60.0,
          items: [
            
            Icon(Icons.home, size: 30, color: Colors.white,),
            Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white,),
            Icon(Icons.compare_arrows, size: 30, color: Colors.white,),
            Icon(Icons.call_split, size: 30, color: Colors.white,),
            //Icon(Icons.perm_identity, size: 30, color: Colors.white,),
          ],
          color: ColorUtil.primaryColor,
          buttonBackgroundColor: ColorUtil.primaryColor,
          backgroundColor: Colors.white,
          animationCurve: Curves.fastEaseInToSlowEaseOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: widgetList[index],
       
        );
        
  }
}