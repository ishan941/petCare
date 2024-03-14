import 'package:flutter/material.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:project_petcare/provider/sellpetprovider.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getToken();
    });

    super.initState();
  }

  getToken() async {
    var sellingPetProvider =
        Provider.of<SellingPetProvider>(context, listen: false);
    sellingPetProvider.getTokenFromSharedPref();
    await sellingPetProvider.getSellingPetData();
  }

  getCategory() async {
    var categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoryProvider.getTokenFromSharedPref();
    await categoryProvider.getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) =>
            Consumer<SellingPetProvider>(
          builder: (context, sellingPetProvider, child) =>
              SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                // Container(
                //   height: 100,
                //   width: 100,
                //   color: Colors.red,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => VerificationTest()));
                //     },
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Container(
                //         color: Colors.white,
                //         height: 50,
                //         width: MediaQuery.of(context).size.width,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 20),
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Text("Test"),
                //                   Spacer(),
                //                   Icon(Icons.arrow_forward_rounded)
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ShopSale()));
                //     },
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Container(
                //         color: Colors.white,
                //         height: 50,
                //         width: MediaQuery.of(context).size.width,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 20),
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Text("Google Signin"),
                //                   Spacer(),
                //                   Icon(Icons.arrow_forward_rounded)
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // sellingUi(sellingPetProvider),
                categoriesuiTest(categoriesProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sellingUi(SellingPetProvider sellingPetProvider) {
    return Container(
      height: 200,
      width: 200,
      child: ListView.builder(
          itemCount: sellingPetProvider.sellingPetList.length,
          itemBuilder: (context, index) => Container(
                height: 100,
                width: 100,
                color: Colors.red,
              )),
    );
  }

  Widget categoriesuiTest(CategoriesProvider categoriesProvider) {
    return Container(
      height: 200,
      width: 200,
      child: ListView.builder(
          itemCount: categoriesProvider.categoriesList.length,
          itemBuilder: (context, index) => Container(
                height: 100,
                width: 100,
                // color: Colors.red,
                child: Text(
                  categoriesProvider.categoriesList[index].categoriesImage ?? ""),
              )),
    );
  }
}
