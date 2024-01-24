 import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

SaveValueToSharedPreference()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool("isUserLoggedIn", true);

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
  