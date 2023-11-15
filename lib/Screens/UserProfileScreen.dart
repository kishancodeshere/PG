import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pg/componets/UserBottomNavigation.dart';
import 'package:pg/componets/reuseWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class User {
  String name;
  String id;

  User({required this.name, required this.id});
}

class UserProfileScreen extends StatefulWidget {
  final String user;
  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController instalink = TextEditingController();
  var user = {};
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List users = [];

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('manageUser').get().then((value) {
        // print("firestore vals ==>  $value");
        // print("firestore vals ==>  ${value.docs.length}");
        for (var element in value.docs) {
          //print("===>${element.data()['Email']}");
          //users.add(User(name: element.data()['Email'], id: element.id));
          users.add({
            "id": element.id,
            "Email": element.data()['Email'],
            "Password": element.data()['Password'],
            "Username": element.data()['Username'],
          });
          // User user = users.singleWhere(
          // (element) => element.data()['Email'] == widget.user,
          
          // );

        }

         print(users[0]['Email']);
        //print(user);
      });
    });
    // for(var item in users)
    // {

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E6E4),
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(children: [
            const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 55,
              foregroundImage: AssetImage('Images/icon.jpg'),
            ),
            const SizedBox(height: 10),
            resueLoginTextField(
                text: "UserName",
                icon: Icons.person_outline,
                isPasswordType: true,
                controller: name,
                size: 370,
                readonly: true),
            const SizedBox(height: 20),
            resueLoginTextField(
                text: 'Email',
                icon: Icons.email_outlined,
                isPasswordType: false,
                controller: email,
                size: 370,
                readonly: true),
            const SizedBox(height: 10),
            resueLoginTextField(
                text: 'Change Password',
                icon: Icons.password_outlined,
                isPasswordType: true,
                controller: pass,
                size: 370,
                readonly: false),
            const SizedBox(height: 20),
            resueLoginTextField(
                text: "Instagram Link",
                icon: FontAwesomeIcons.instagram,
                isPasswordType: false,
                controller: instalink,
                size: 350,
                readonly: false),
            const SizedBox(height: 20),
            reuseOutlinedButton(
                text: 'Update',
                context: context,
                path: '/UserProfileScreen',
                height: 43),
            const SizedBox(height: 10),
          ]),
        ),
      ),
      bottomNavigationBar: UserBottomNavigation(user: widget.user),
    );
  }
}
