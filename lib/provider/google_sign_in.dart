import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future GoogleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final userCollection = FirebaseFirestore.instance.collection('Users');
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final userDoc = await userCollection.doc(userId).get();

    if (!userDoc.exists) {
      await userCollection.doc(userId).set({
        'profilePicUrl': FirebaseAuth.instance.currentUser?.photoURL,
        'displayName': FirebaseAuth.instance.currentUser?.displayName,
        'email': FirebaseAuth.instance.currentUser?.email,
      });
    }

    notifyListeners();
  }

  Future GoogleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
