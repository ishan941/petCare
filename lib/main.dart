import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:project_petcare/core/smooth_scrollable.dart';
import 'package:project_petcare/firebase_options.dart';
import 'package:project_petcare/provider/adoptprovider.dart';
import 'package:project_petcare/provider/ads_provider.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/provider/donateprovider.dart';
import 'package:project_petcare/provider/feedprovider.dart';
import 'package:project_petcare/provider/mypet_provider.dart';
import 'package:project_petcare/provider/ourservice_provider.dart';
import 'package:project_petcare/provider/payment_provider.dart';
import 'package:project_petcare/provider/petcareprovider.dart';
import 'package:project_petcare/provider/scanner_provider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:project_petcare/provider/shop_provider.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/buttomnav.dart';
import 'package:project_petcare/view/shop/shopall.dart';
import 'package:provider/provider.dart';

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
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getFCMToken();
    // readValueFromSharedPreference();
    notificationSetting();
    init();
    foreGroundMessage();
    super.initState();
  }

  final GlobalKey<NavigatorState> firebaseNavigatorKey =
      GlobalKey<NavigatorState>();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//send this token to backend for notification
  Future<void> getFCMToken() async {
    String? fcmToken = await messaging.getToken();
    print('FCM Token: $fcmToken');
  }

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        firebaseNavigatorKey.currentState?.pushNamed('/notification');
      },
    );
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification_id, title, value, notificationDetails,
        payload: 'Not present');
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: KhaltiScope(
        navigatorKey: firebaseNavigatorKey,
        publicKey: "test_public_key_ab4ce8ec82bf4663a471363d88b43d82",
        builder: (context, khaltiNavigatorKey) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PetCareProvider()),
            ChangeNotifierProvider(create: (context) => DonateProvider()),
            ChangeNotifierProvider(create: (context) => ShopProvider()),
            ChangeNotifierProvider(create: (context) => OurServiceProvider()),
            ChangeNotifierProvider(create: (context) => AdoptProvider()),
            ChangeNotifierProvider(create: (context) => SignUpProvider()),
            ChangeNotifierProvider(create: (context) => CategoriesProvider()),
            ChangeNotifierProvider(create: (context) => MyPetProvider()),
            ChangeNotifierProvider(create: (context) => FeedProvider()),
            ChangeNotifierProvider(create: (context) => SellingPetProvider()),
            ChangeNotifierProvider(create: (context) => AdsProvider()),
            ChangeNotifierProvider(create: (context) => PaymentProvider()),
            ChangeNotifierProvider(create: (context) => ScannerProvider())
          ],
          child: MaterialApp(

            navigatorKey: khaltiNavigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [KhaltiLocalizations.delegate],
            routes: {
              '/notification': (context) => ShopAll(),
            },
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            // home: SplashScreen(),
            // home: LoginPage(),
            home: BottomNavBar(),
            // home: MyProfile(),
          ),
        ),
      ),
    );
  }

  notificationSetting() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  foreGroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationAndroid(
          message.notification!.title!, message.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      firebaseNavigatorKey.currentState?.pushNamed('/notification');
    });
  }
}
