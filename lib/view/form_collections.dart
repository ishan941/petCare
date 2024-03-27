import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/ourservicedto.dart';
import 'package:project_petcare/view/categories.dart/forms/categoriesForms.dart';
import 'package:project_petcare/view/donate/donate_1.dart';
import 'package:project_petcare/view/logins/normalloginform.dart';
import 'package:project_petcare/view/ourservice/apiservicedto.dart';
import 'package:project_petcare/view/ourservice/ourservicedto.dart';
import 'package:project_petcare/view/ourservice/ourserdto_form.dart';
import 'package:project_petcare/view/ourservice/dashservice_form.dart';
import 'package:project_petcare/view/ads/adsform.dart';
import 'package:project_petcare/view/shop/post_item.dart';
import 'package:project_petcare/view/test.dart/testPage.dart';

class FormCollection extends StatefulWidget {
  const FormCollection({super.key});

  @override
  State<FormCollection> createState() => _UiTestState();
}

class _UiTestState extends State<FormCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil.primaryColor,
        actionsIconTheme: IconThemeData.fallback(),
        elevation: 0,
        title: Text(
          "Forms",
          style: appBarTitle,
        ),
      ),
      backgroundColor: ColorUtil.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100,
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
                      height: 60,
                    ),
                    Center(
                      child: GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestPage()));
                        },
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
                    ),
                    Text('Forms'),
                    categoriesForm(context),
                    adsForm(context),
                    serviceDash(context),
                    ourServiceDto(context),
                    shopItemForm(context),
                    professionServiceForm(context),
                    
                    adoptForm(context),
                    normalForm(context),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget categoriesForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoriesForms()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }

  Widget adoptForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DonateFirstPage()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }

  Widget professionServiceForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => YourProfession()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("OurServiceDto Form"),
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
    );
  }

  Widget shopItemForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShopSale()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Form for add shop item"),
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
    );
  }

  Widget serviceDash(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ServiceForm()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Service in dash"),
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
    );
  }

  Widget adsForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdsForm()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Add ads"),
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
    );
  }

  Widget normalForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NormalForm()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Normal Form"),
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
    );
  }

  Widget ourServiceDto(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OurServiceDtoForm()));
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Our ServiceDtio"),
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
    );
  }
}
