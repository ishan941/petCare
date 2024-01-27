import 'package:flutter/material.dart';
import 'package:project_petcare/model/ourservice.dart';

class ServiceDetails extends StatefulWidget {
  final OurService? ourService;
  ServiceDetails({super.key, this.ourService});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height * .4,
          ),
          Text(widget.ourService!.profession!),
        ],
      ),
    );
  }
}
