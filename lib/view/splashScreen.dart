// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/model/petcare.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';
import 'package:project_petcare/view/logins/loginpage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
 late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  readValue();

    _controller = AnimationController(
      duration: Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // Start the animation
  }

   readValue()async{
 var signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
  bool isLogin=await signUpProvider.readValueFromSharedPreference();
 Future.delayed(Duration(seconds: 2),(){
  if(isLogin){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>BottomNavBar()), (route) => false);
  }else{
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>LoginPage()), (route) => false);
  }

 });
  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PetCareProvider>(
        builder: (context, petCareProvider, child) => 
      Center(
         child: FadeTransition(
           opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Screenshot_2023-12-15_at_18.50.26-removebg-preview.png', // Replace with your logo image path
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 20),
                // Helper.backdropFilter(context)
              ],
            ),
         ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}
