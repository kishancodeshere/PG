import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pg/componets/OwnerBottomNavigation.dart';
import 'package:pg/componets/reuseWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProfile extends StatefulWidget {

  final String admin;
  const AdminProfile({Key? key, required this.admin}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {

  final TextEditingController name = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Pass = TextEditingController();
  final TextEditingController Number = TextEditingController();
  final TextEditingController InstaLink = TextEditingController();
  // getdata()async{
  //
  //   final firestore = FirebaseFirestore.instance;
  //   final collectionReference = firestore.collection('users');
  //   final usersQuery = collectionReference.where('Name');
  //
  //
  //   print(usersQuery);
  //
  // }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xffE5E6E4),
      appBar: AppBar(
        title: Text('Admin Profile '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(children: [
            const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 55,
              foregroundImage: AssetImage('Images/icon.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            resueLoginTextField(
                text: 'Name',
                icon: Icons.people_alt_outlined,
                isPasswordType: true,
                controller: name,
                size: 370,readonly: true),
            const SizedBox(height: 10),
            resueLoginTextField(
                text: 'Email',
                icon: Icons.email_outlined,
                isPasswordType: false,
                controller: Email,
                size: 370,readonly: true),
            SizedBox(height: 10),
            resueLoginTextField(
                text: 'Contact Number',
                icon: Icons.call_outlined,
                isPasswordType: false,
                controller: Number,
                size: 370,readonly: false),
            SizedBox(height: 10),
            resueLoginTextField(
                text: 'Change Password',
                icon: Icons.password_outlined,
                isPasswordType: true,
                controller: Number,
                size: 370,readonly: false),
            const SizedBox(height: 20),
            resueLoginTextField(
                text: "Instagram Link",
                icon: FontAwesomeIcons.instagram,
                isPasswordType: false,
                controller: InstaLink,
                size: 370,readonly: false),
            const SizedBox(height: 20),
            reuseOutlinedButton(
                text: "Update",
                context: context,
                path: '/AdminProfile',
                height: 43),
            SizedBox(height: 10),
          ]),
        ),
      ),
      bottomNavigationBar: OwnerBottomNavigationBar(admin: widget.admin),
    );



  }
}
