import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pg/Screens/AddPgInfo.dart';
import 'package:pg/Screens/AdminProfile.dart';
import 'package:pg/Screens/OwnerHomeScreen.dart';

class OwnerBottomNavigationBar extends StatefulWidget {
  final String admin;
  const OwnerBottomNavigationBar({Key? key, required this.admin}) : super(key: key);

  @override
  State<OwnerBottomNavigationBar> createState() => _OwnerBottomNavigationBar();
}

class _OwnerBottomNavigationBar extends State<OwnerBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff95A3B3),
      height: 65,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OwnerHomeScreen(
                    admin: widget.admin,
                    ),
              ),
            );
          },
          icon: Icon(Icons.home_outlined),
          iconSize: 35,
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AddPgInfo(
                    admin: widget.admin,
                    ),
              ),
            );
          },
          icon: Icon(Icons.add_box_outlined),
          iconSize: 35,
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AdminProfile(
                  admin: widget.admin,
                ),
              ),
            );
          },
          icon: Icon(Icons.account_circle_outlined),
          iconSize: 35,
        ),
      ]),
    );
  }
}
