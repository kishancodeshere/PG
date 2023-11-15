import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pg/componets/CardImageSlider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pg/componets/Backend.dart';

class CardScreen extends StatefulWidget {
  final String data;
  final String price;
  const CardScreen({super.key, required this.data,required this.price});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CollectionReference _data =
      FirebaseFirestore.instance.collection('PG_details');
  void initState() {
    super.initState();
    debugPrint(widget.data);
  }



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
        'amount': '${widget.price}00',
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
      appBar: AppBar(
          title: Text(
        'PG Detail',
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
      )),
      body: StreamBuilder(
        stream: _data.where("PGName", isEqualTo: widget.data).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                print(documentSnapshot['Price']);
                

                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset('Images/img_5.jpg')),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "PG Name : ${documentSnapshot['PGName']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18,color: Color(0xff0A1045)),),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "Address : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18),),
                                      SizedBox(height:6),
                                      Text(
                                          "${documentSnapshot['HouseNo']}, ${documentSnapshot['Area']}, ${documentSnapshot["City"]}${documentSnapshot['Pincode']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                        SizedBox(height:6)
                                      ,Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "PG Type :- ${documentSnapshot['PGType']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                          Text(documentSnapshot['Facilities'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xff0A1045)),),
                                          SizedBox()
                                        ],
                                      ),
                                      SizedBox(height:6),
                                      Text(
                                          "Available Rooms :  ${documentSnapshot['Rooms']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                      
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Amenities",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18,color: Color(0xff0A1045))),
                                      Text(
                                          "${documentSnapshot['Description']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "Email : ${documentSnapshot['Owner']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "Contact No : ${documentSnapshot['Contact']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18)),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "Social Media : ${documentSnapshot['InstaLink']}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18))
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price :  ₹${widget.price}",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xff0A1045)),
              ),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  onPressed: () {

                    makePayment();

                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: const Text('This Feature will add in Future Enhancement'),
                      //   action: SnackBarAction(
                      //     label: 'OK',
                      //     onPressed: () {
                      //
                      //
                      //     },
                      //   ),
                      // ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0A1045),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                        color: Color(0xffe5e6e4),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),)
            ],
          ),
        ),
      ),
    );
  }
}
