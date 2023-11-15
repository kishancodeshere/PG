import 'package:flutter/material.dart';
import 'package:pg/componets/Backend.dart';
import 'package:pg/componets/OwnerBottomNavigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerHomeScreen extends StatefulWidget {
  final String admin;
  const OwnerHomeScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  String text = "ejbeebeoryg3bxccdertyujnbvdfjcdjep3u";
  late String handle = "Login";
  @override
  void initState() {
    if (widget.admin == "null")
      handle = "Login";
    else
      handle = "Logout";
  }

  final CollectionReference _data =
      FirebaseFirestore.instance.collection('PG_details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PG Guide"),
        leading: const Padding(
          //padding:EdgeInsets.all(8.0),
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
          child: CircleAvatar(
            radius: 10.0,
            foregroundImage: AssetImage("Images/icon.jpg"),
          ),
        ),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                if (widget.admin == "null") {
                  handle = "Logout";
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                  print(widget.admin);
                }
                setState(() {});
              },
              icon: Icon(Icons.login),
              label: Text("$handle", style: TextStyle(fontSize: 20))),
          const SizedBox(width: 5)
        ],
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: StreamBuilder(
        stream: _data.where("Owner", isEqualTo: widget.admin).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                return Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(25, 5, 25, 9),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Image.asset(
                            documentSnapshot['imageUrl'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                documentSnapshot['PGName'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        print(documentSnapshot.id);
                                      },
                                      icon: Icon(Icons.edit_outlined)),
                                  IconButton(
                                      onPressed: () {
                                        Backend b = new Backend();
                                        b.deletePG(documentSnapshot.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Pg deleted Successfully'),
                                            duration: Duration(
                                                seconds:
                                                    2), // Duration for how long the SnackBar will be visible.
                                          ),
                                        );
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.delete_outline)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: OwnerBottomNavigationBar(
        admin: widget.admin,
      ),
    );
  }
}
