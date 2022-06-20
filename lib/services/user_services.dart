//
// import 'package:firebase_database/firebase_database.dart';
//
// import '../models/user_model.dart';
//
// class UserServices {
//   ///Create User
//   Future createUser(UserModel userModel) async {
//     return await FirebaseDatabase.instance.ref()
//         .child('userCollection');
//
//   }
//
//   ///Fetch User Record
//   // Stream<UserModel> fetchUserRecord(String userID) {
//   //   return FirebaseDatabase.instance.ref()
//   //       .child('userCollection')
//   //       .doc(userID)
//   //       .snapshots()
//   //       .map((userData) => UserModel.fromJson(userData.data()!));
//   // }
//
//   ///Update User Record
//   // Future updateUserDetails(UserModel userModel) async {
//   //   return await FirebaseFirestore.instance
//   //       .collection('userCollection')
//   //       .doc(userModel.docId)
//   //       .update(
//   //           {'contactNumber': userModel.contactNumber, 'name': userModel.name});
//   // }
// }
