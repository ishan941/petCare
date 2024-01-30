import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';
import 'package:project_petcare/view/shop/mycart.dart';
import 'package:project_petcare/view/profile/profile.dart';
import 'package:project_petcare/view/shop/shopFavourite.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var petcareProvider = Provider.of<PetCareProvider>(context);
    return Scaffold(
      
        bottomNavigationBar: CurvedNavigationBar(
          index: petcareProvider.selecedIndex,
          height: 60.0,
          items: [
            _buildNavItem(Icons.home, 'Home'),
            _buildNavItem(Icons.shopping_bag_outlined, 'Shop'),
            _buildNavItem(Icons.shopping_cart_outlined, 'Cart'),
            _buildNavItem(Icons.favorite, 'Favourite'),
            _buildNavItem(Icons.person, 'Profile'),
            //Icon(Icons.perm_identity, size: 30, color: Colors.white,),
          ],
          color: ColorUtil.primaryColor,
          buttonBackgroundColor: ColorUtil.primaryColor,
          backgroundColor: Color(0XFFE5E8FF),
          animationCurve: Curves.fastEaseInToSlowEaseOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (value) {
            petcareProvider.setIndex(value);
          },
          letIndexChange: (index) => true,
        ),
        body: _getPage(petcareProvider.selecedIndex));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return ShopAll();
      case 2:
        return MyCart();
      case 3:
        return ShopFavourite();

      default:
        return Profile();
    }
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
