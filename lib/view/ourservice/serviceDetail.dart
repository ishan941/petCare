import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/ourservice.dart';
import 'package:project_petcare/model/ourservicedto.dart';

class ServiceDetails extends StatefulWidget {
  final OurService? ourService;
  final OurServiceDto? ourServiceDto;
  ServiceDetails({super.key, this.ourService, this.ourServiceDto});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        child: Image.network(
                          widget.ourServiceDto!.image ?? "",
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
                        Row(
                          children: [
                            Text(
                                "Name -  ${widget.ourServiceDto!.phone ?? "Phone Number not available"}"),
                            Text(
                              widget.ourServiceDto!.service ?? "",
                              style: mainTitleText,
                            ),
                          ],
                        ),
                        Text(
                            "Phone Number -  ${widget.ourServiceDto!.phone ?? "Phone Number not available"}"),
                        Text(
                            "Email -  ${widget.ourServiceDto!.email ?? "Email not available"}"),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "About",
                          style: mainTitleText,
                        ),
                        Text(widget.ourServiceDto!.description ??
                            "Description not available ..."),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                  Text(
                    widget.ourServiceDto!.fullName ?? "",
                    style: subTitleText,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
