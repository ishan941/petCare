import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/dashboard/health.dart';
import 'package:project_petcare/view/adoption/pet_care.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';
import 'package:project_petcare/view/profile/account.dart';

import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getToken();
    });
    super.initState();
  }

  getToken() {
    var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    signUpProvider.getTokenFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    var petcareProvider = Provider.of<PetCareProvider>(context);
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: petcareProvider.selecedIndex,
          height: 65.0,
          items: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.shopify_sharp, 'Shop', 1),
            _buildNavItem(Icons.pets, 'Adoption', 2),
            _buildNavItem(Icons.health_and_safety_outlined, 'Health', 3),
            _buildNavItem(Icons.account_balance_sharp, 'Profile', 4),
          ],
          color: Colors.white,
          buttonBackgroundColor: ColorUtil.secondaryColor,
          backgroundColor: ColorUtil.BackGroundColorColor,
          animationCurve: Curves.fastEaseInToSlowEaseOut,
          animationDuration: Duration(milliseconds: 1200),
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
        return DonateSaleFeed();
      case 3:
        return DogHealth();
      case 4:
        return Account();
      default:
        return HomePage();
    }
  }

  Widget _buildNavItem(IconData icon, String label, int currentIndex) {
    var petcareProvider = Provider.of<PetCareProvider>(context);
    var isSelected = petcareProvider.selecedIndex == currentIndex;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 25,
              color: isSelected
                  ? ColorUtil.BackGroundColorColor
                  : ColorUtil.secondaryColor),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? ColorUtil.BackGroundColorColor
                    : ColorUtil.secondaryColor),
          ),
        ],
      ),
    );
  }
}
