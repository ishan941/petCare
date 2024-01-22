import 'package:flutter/material.dart';

class FormForTrainner extends StatefulWidget {
  const FormForTrainner({super.key});

  @override
  State<FormForTrainner> createState() => _FormForTrainnerState();
}

class _FormForTrainnerState extends State<FormForTrainner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("FormforTrainner"),
    );
  }
}