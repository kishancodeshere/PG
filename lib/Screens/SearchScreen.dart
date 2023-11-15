import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pg/componets/UserBottomNavigation.dart';

class SearchScreen extends StatefulWidget {
  final String user;
  const SearchScreen({super.key, required this.user});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List data = [];

  void searchdata(String query) async{
    final result = await FirebaseFirestore.instance.collection('PG_details').where('City', isEqualTo: query).get();

    setState(() {
      data = result.docs.map((e) => e.data()).toList();
    });
  }


  // final CollectionReference _firestore =
  //     FirebaseFirestore.instance.collection('PG_details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search PG"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search here'),
                onChanged: (query){
                  searchdata(query);
                },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]['PGName']),
              subtitle: Text(data[index]['City']),
            );
          }),
        )
      ]),
      bottomNavigationBar: UserBottomNavigation(user: widget.user),
    );
  }
}
