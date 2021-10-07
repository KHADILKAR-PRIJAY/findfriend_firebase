// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:find_friend/firebase_auth/user.dart';
//
// class AuthMethods {
//   String token = "some-uid";
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   UserClass? _userFromFirebase(User user) {
//     return (user != null) ? UserClass(user.uid) : null;
//   }
//
//   Future custom() async {
//     try {
//       UserCredential result = await _auth.signInWithCustomToken(token);
//       User? firebaseUser = result.user;
//       return _userFromFirebase(firebaseUser!);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   // Future customSignIn() async {
//   //   try {
//   //     UserCredential result = await _auth.cr;
//   //     User? firebaseUser = result.user;
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
// }
