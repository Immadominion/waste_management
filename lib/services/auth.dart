import 'package:firebase_auth/firebase_auth.dart';

import 'package:waste_management/screens/assets/Guest.dart';



class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  UserCredential? get guest => null;

  //create user obj based on firebase user
  Guest? _userFromFirebaseUser(guest) {
    return guest != null ? Guest(Uid: guest.user!.uid) : null;
  }


  // Guest _userFromFirebase(User? user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return Guest(Uid: user.uid);
  // }

// auth change user stream


  // Stream<Guest?> get guest3 {
  //   return _auth.authStateChanges()
  //       .map((User? user){
  //     print(user?.uid);
  //    return _userFromFirebaseUser(user?.uid as UserCredential );
  //
  //   });
  //}
  // Stream<String?> get onAuthStateChanged =>
  //     _auth.authStateChanges().map(
  //           (User? user) => user?.uid,
  //     );

  Stream<User?> get guest3 {
    return _auth.authStateChanges();
  }
   // Stream<Guest?> get authStateChanges {
   //   return _auth.authStateChanges().map(_userFromFirebaseUser(guest.user.uid));
   // }
  // Stream<UserCredential?> get guest2 {
  //   return _auth.authStateChanges()
  //       .map((User? user) => _userFromFirebaseUser(user.uid));
  //      // .map(_userFromFirebaseUser);
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user= result.user;
      return _userFromFirebaseUser(result);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Future<Guest?> currentUser() async {
  //   final user = _auth.currentUser;
  //   return _userFromFirebase(user!);
  // }
  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  //
  // // register with email and password
  // Future registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     FirebaseUser user = result.user;
  //     // create a new document for the user with the uid
  //     await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
  //     return _userFromFirebaseUser(user);
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }
  //
  // // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}