// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class Gender extends StatefulWidget {
//   const Gender({Key? key}) : super(key: key);

//   @override
//   State<Gender> createState() => _GenderState();
// }

// class _GenderState extends State<Gender> {
//   final List<String> items = [
//     'Boys PG',
//     'Girls PG',
//   ];
//   String? genderValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Text(
//           'PG Type',
//           style: TextStyle(
//             fontSize: 14,
//             color: Theme.of(context).hintColor,
//           ),
//         ),
//         items: items
//             .map((String item) => DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(
//                     item,
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ))
//             .toList(),
//         value: genderValue,
//         onChanged: (String? value) {
//           setState(() {
//             genderValue = value;
//           });
//         },
//         buttonStyleData: const ButtonStyleData(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           height: 40,
//           width: 140,
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//         ),
//       ),
//     );
//   }
// }
