import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/view/dashboard/feed.dart';
import 'package:project_petcare/view/dashboard/homepage.dart';
import 'package:project_petcare/view/profile/account.dart';
import 'package:project_petcare/view/shop/mycart.dart';
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
          height: 65.0,
          items: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.shopping_bag_outlined, 'Shop', 1),
            _buildNavItem(Icons.feed_outlined, 'NewsFeed', 2),
            _buildNavItem(Icons.favorite, 'Favourite', 3),
            _buildNavItem(Icons.person, 'Profile', 4),
            //Icon(Icons.perm_identity, size: 30, color: Colors.white,),
          ],
          color: Colors.white,
          buttonBackgroundColor: ColorUtil.primaryColor,
          backgroundColor: ColorUtil.BackGroundColorColor,
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
        return NewsFeed();
      case 3:
        return ShopFavourite();

      default:
        return Account();
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
              size: 30,
              color: isSelected
                  ? ColorUtil.BackGroundColorColor
                  : ColorUtil.primaryColor),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? ColorUtil.BackGroundColorColor
                    : ColorUtil.primaryColor),
          ),
        ],
      ),
    );
  }
}
