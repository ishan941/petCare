import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/firebase_options.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/view/dashboard/buttomnav.dart';

import 'package:project_petcare/view/logins/loginpage.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserExist = false;

  @override
  void initState() {
    readValueFromSharedPreference();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PetCareProvider()),
          ChangeNotifierProvider(create: (context)=> DonateProvider()),
          ChangeNotifierProvider(create: (context)=> ShopProvider()),
          ChangeNotifierProvider(create: (context)=> OurServiceProvider()),
          ChangeNotifierProvider(create: (context)=> AdoptProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          ),
          home: isUserExist ? BottomNavBar() : LoginPage(), 
          // home: BottomNavBar(),
          // home: LoginPage(),
          // home: SignUpPage(),
        )
      ),
    );
  }

  readValueFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserExist = prefs.getBool('isUserExist') ?? false;
    });
  }
}
