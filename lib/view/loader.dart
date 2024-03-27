import 'package:flutter/material.dart';
import 'package:project_petcare/helper/helper.dart';

class FormLoader extends StatefulWidget {
  final String? customText; // Add customText parameter

  const FormLoader({Key? key, this.customText}) : super(key: key);

  @override
  State<FormLoader> createState() => _FormLoaderState();
}

class _FormLoaderState extends State<FormLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Helper.primaryLoader(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : 100.0),
            child: Text(widget.customText ?? 'Pelase wait..',
            textAlign: TextAlign.center,
            ),
          ), // Use customText parameter
        ],
      ),
    );
  }
}
