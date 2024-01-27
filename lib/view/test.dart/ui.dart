import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constant.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:project_petcare/view/forms/categoriesForms.dart';

class UiTest extends StatefulWidget {
  const UiTest({super.key});

  @override
  State<UiTest> createState() => _UiTestState();
}

class _UiTestState extends State<UiTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                          color: Color(0xFFDFE2FF),
                          height: MediaQuery.of(context).size.height),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 160,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(6, 6),
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 3,
                              )
                            ]),
                        width: MediaQuery.of(context).size.width * .8,
                        height: 120,
                      ),
                    ),
                    Text('Forms'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesForms()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Add Categories"),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_rounded)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DonateFirstPage()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Form for add Adopt"),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_rounded)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
