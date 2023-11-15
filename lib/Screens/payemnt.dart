import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart'as http;
class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntent;

  void makePayment() async{

    try{
      print('CALL');
      paymentIntent=await createPaymentIntent();
      print('payment intent --> $paymentIntent');
      var gpay = PaymentSheetGooglePay(merchantCountryCode: "IN",
          currencyCode: "inr",
          testEnv: true);
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent![
            'client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Kishan Yadav',
            googlePay: gpay,

          ));
      displayPaymentSheet();
    }catch(e)
    {
      print(e);

    }
  }


  void displayPaymentSheet() async {
    print("Called...");
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment Successfully");
    }
    catch (e) {
      print('Failed');
    }
  }


  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        'amount': '10000',
        'currency': "inr",
      };

      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51O258fSAYwVWBfMKLhly95eLxb5lRxrEpaHuXKALfj0fJb1y9vS2HNtMvJeXpIVNjdbIpu50ba2FS8ZAMOwT04l400dopGKN4H',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Stripe Example")),
      body: Center(
        child: ElevatedButton(onPressed: () {
          makePayment();
        }, child:const Text("Pay") ),
      ),
    );
  }
}
