// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class Facilities extends StatefulWidget {

//   const Facilities({Key? key,}) : super(key: key);

//   @override
//   State<Facilities> createState() => _FacilitiesState();
// }

// class _FacilitiesState extends State<Facilities> {

//   final List<String> items = [
//     'AC',
//     'Non-AC',
//   ];
//   String? facilitiesValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(

//             isExpanded: true,
//             hint: Text(
//               'Select Facilities',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Theme.of(context).hintColor,
//               ),
//             ),
//             items: items
//                 .map((String item) => DropdownMenuItem<String>(
//               value: item,
//               child: Text(
//                 item,
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             value: facilitiesValue,
//             onChanged: (String? value) {
//               setState(() {
//                 facilitiesValue = value;
//               });
//             },
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               height: 40,
//               width: 140,
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//             ),
//           ),
//     );
//   }
// }
