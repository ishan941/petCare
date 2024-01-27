import 'package:flutter/material.dart';
import 'package:project_petcare/provider/signUpProvider.dart';
import 'package:project_petcare/view/logins/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SaveValueToSharedPreference() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isUserLoggedIn", true);
  await prefs.setBool("isGoogleLoggedIn", true);
}

Future<void> clearLoginStatus() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isUserLoggedIn", false);
    await prefs.setBool('isGoogleLoggedIn', false);
  } catch (e) {
    print("$e");
  }
}

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Consumer<SignUpProvider>(
        builder: (context, signUpProvider, child) => ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: AlertDialog(
            title: const Text('Logout'),
            content: const Text("Are You sure you want to logout"),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text("Yes"),
                onPressed: () async {
                  clearLoginStatus();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert Dialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a simple alert dialog in Flutter.'),
              Text('You can customize the content as needed.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
