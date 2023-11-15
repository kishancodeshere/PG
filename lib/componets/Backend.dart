import 'package:cloud_firestore/cloud_firestore.dart';

class Backend {
  //CollectionReference _question = FirebaseFirestore.instance.collection("questions");
  CollectionReference _manageUser =
      FirebaseFirestore.instance.collection("manageUser");
  CollectionReference _pgDetails =
      FirebaseFirestore.instance.collection("PG_details");

  Future<void> signup(
      {required String unm,
      required String email,
      required String pwd,
      required String cnfPassword,
      required String role}) async {
    final data = {
      "Email": email,
      "Username": unm,
      "Password": pwd,
      "ConfirmPassword": cnfPassword,
      "Role": role
    };
    await _manageUser.add(data);
  }

  Future<void> AddPGData(
      {required String area,
      required String city,
      required String description,
      required String facilities,
      required String houseNo,
      required String imageUrl,
      required String pgName,
      required String pgType,
      required String pincode,
      required String owner,
      required String price,
      required String room}) async {
    final data = {
      "PGName": pgName,
      "HouseNo": houseNo,
      "City":city,
      "Pincode":pincode,
      "Facilities":facilities,
      "PGType":pgType,
      "Description":description,
      "imageUrl":imageUrl,
      "Owner":owner,
      "Price":price,
      "Area":area,
      "InstaLink":"Not Available",
      "Contact":"Not given by Owner",
      "Rooms":room
    };
    await _pgDetails.add(data);
  }

//   Future<void> addQuestion(String que,String ans)
//   async
//   {
//
//     final data = {
//       "question" : que,
//       "answers":[ans]
//     };
//     await _question.add(data);
//   }
  Future<void> deletePG(String productId)
  async
  {
    await _pgDetails.doc(productId).delete();

  }
//
//   Future<void> addAnswer(String productId,String answer)
//   async
//   {
//     await _question.doc(productId).update({"answers":FieldValue.arrayUnion([answer])});
//
//   }
//
}
