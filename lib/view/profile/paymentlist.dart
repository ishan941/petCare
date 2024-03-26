import 'package:flutter/material.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/payment_provider.dart';
import 'package:provider/provider.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      getData();
    });
    super.initState();
  }
  getData()async{
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getTokenFromSharedPref();
    await paymentProvider.getPaymentDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.BackGroundColorColor,
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) =>  Column(
          children: [
            Container(
              height: 300,
            color: Colors.blue,
            child: Expanded(
              child: ListView.builder(
                itemCount: paymentProvider.paymenList.length,
                itemBuilder: (context,index) =>
              Container(
                height: 200,
              color: Colors.white,

              width: 200,
              child: Column(
                children: [
                  Text(paymentProvider.paymenList[index].userName ?? ""),
                  Text("${paymentProvider.paymenList[index].productName ?? ""} @  ${paymentProvider.paymenList[index].price ?? ""}"),
                ],
              )
              )
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}