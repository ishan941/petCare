import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
                  Text(widget.ourService!.fullname!,
                style: subTitleText,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                child: Image.network(
                  widget.ourService!.profilePicture!,
                  fit: BoxFit.cover,
                ),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Text(widget.ourService!.profession!),
                SizedBox(height: 15,),
                Text("About",
                style: mainTitleText,
                ),
                Text(widget.ourService!.description ?? "Description not available ..."),
                Text("Phone Number -  ${widget.ourService!.phone ?? "Phone Number not available"}")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
