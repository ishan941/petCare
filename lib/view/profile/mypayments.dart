import 'package:flutter/material.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/payment_provider.dart';
import 'package:provider/provider.dart';

class MyPayments extends StatefulWidget {
  const MyPayments({super.key});

  @override
  State<MyPayments> createState() => _MyPaymentsState();
}

class _MyPaymentsState extends State<MyPayments> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  getData() async {
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getTokenFromSharedPref();
    await paymentProvider.getMyPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      appBar: AppBar(
        backgroundColor: ColorUtil.BackGroundColorColor,
        iconTheme: IconThemeData.fallback(),
        elevation: 0,
        title: Text(
          "My Payments",
          style: appBarTitle,
        ),
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            paymentProvider.paymenList.isEmpty
                ? Column(
                    children: [
                      Helper.primaryLoader(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Your Payment is empty..")
                    ],
                  )
                : Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: paymentProvider.myPaymentList.length,
                          itemBuilder: (context, index) => Container(
                              height: 200,
                              color: Colors.white,
                              width: 200,
                              child: Column(
                                children: [
                                  Text(paymentProvider
                                          .myPaymentList[index].userName ??
                                      ""),
                                  Text(
                                      "${paymentProvider.myPaymentList[index].productName ?? ""} @  ${paymentProvider.myPaymentList[index].price ?? ""}"),
                                ],
                              ))),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
