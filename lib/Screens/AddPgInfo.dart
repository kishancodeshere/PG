import 'package:flutter/material.dart';
import 'package:pg/Screens/OwnerHomeScreen.dart';
import 'package:pg/componets/Backend.dart';
import 'package:pg/componets/ImagePicker.dart';
import 'package:pg/componets/OwnerBottomNavigation.dart';
import 'package:pg/componets/facilities.dart';
import 'package:pg/componets/gender.dart';
import 'package:pg/componets/reuseWidgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddPgInfo extends StatefulWidget {
  final String admin;
  const AddPgInfo({Key? key, required this.admin}) : super(key: key);

  @override
  State<AddPgInfo> createState() => _AddPgInfoState();
}

class _AddPgInfoState extends State<AddPgInfo> {
  final TextEditingController pgName = TextEditingController();
  final TextEditingController homeNo = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController imageUrl = TextEditingController();
  final TextEditingController room = TextEditingController();
  final List<String> items = [
    'AC',
    'Non-AC',
  ];
  String? facilitiesValue;
  final List<String> itemsGender = [
    'Boys PG',
    'Girls PG',
  ];
  String? genderValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffe5e6e4),
      appBar: AppBar(
        title: const Text("Add PG"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Container(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              resueTextField(
                text: "PG Name",
                icon: Icons.add_business,
                isPasswordType: false,
                controller: pgName,
                size: screenWidth,
              ),
              const SizedBox(height: 10),
              resueTextField(
                text: "HouseNo - Society Name",
                icon: Icons.home,
                isPasswordType: false,
                controller: homeNo,
                size: screenWidth,
              ),
              const SizedBox(height: 10),
              resueTextField(
                  text: "Area, Colony",
                  icon: Icons.pin_drop,
                  isPasswordType: false,
                  controller: area,
                  size: screenWidth),
              //State to be added further
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  resueTextField(
                      text: "City",
                      icon: Icons.location_city,
                      isPasswordType: false,
                      controller: city,
                      size: 150),
                  resueTextField(
                      text: "Pincode",
                      icon: Icons.pin,
                      isPasswordType: false,
                      controller: pincode,
                      size: 150),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  resueTextField(
                      text: "Price",
                      icon: Icons.currency_rupee,
                      isPasswordType: false,
                      controller: price,
                      size: 150),
                  resueTextField(
                      text: "No. of Rooms",
                      icon: Icons.home,
                      isPasswordType: false,
                      controller: room,
                      size: 150),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Facilities',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: facilitiesValue,
                        onChanged: (String? value) {
                          setState(() {
                            facilitiesValue = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'PG Type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: itemsGender
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: genderValue,
                        onChanged: (String? value) {
                          setState(() {
                            genderValue = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              reuseFacilitiesContainer(
                  hintText: "PG Facilities", textarea: description),
              const SizedBox(height: 5),
              ImgPicker(),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    if (pgName.text == "" ||
                        homeNo.text == "" ||
                        area.text == "" ||
                        city.text == "" ||
                        pincode.text == "" ||
                        description.text == "" ||
                        room.text == "" ||
                        price.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Please Enter All fields'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ));
                    } else {
                      Backend b = new Backend();

                      b.AddPGData(
                          pgName: pgName.text,
                          houseNo: homeNo.text,
                          area: area.text,
                          city: city.text,
                          pincode: pincode.text,
                          description: description.text,
                          facilities: facilitiesValue!,
                          pgType: genderValue!,
                          imageUrl: "Images/img_8.jpg",
                          price: price.text,
                          owner: widget.admin,
                          room: room.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('PG Added Successfully'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => OwnerHomeScreen(
                                  admin: widget.admin,
                                ),
                              ),
                            );
                          },
                        ),
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OwnerHomeScreen(
                          admin: widget.admin,
                        ),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0A1045),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add PG",
                    style: TextStyle(
                        color: Color(0xffe5e6e4),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
      bottomNavigationBar: OwnerBottomNavigationBar(
        admin: widget.admin,
      ),
    );
  }
}
