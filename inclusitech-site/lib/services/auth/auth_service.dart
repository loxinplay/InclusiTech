import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // instance of firestore

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // sign in
  Future<UserCredential> signInwithEmailandPassword(
      String email, String password) async{
try{
  // sign in
  UserCredential userCredential =
  await  _firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  // add a new document for the user in collection if it doesnt exists
  _fireStore.collection('users').doc(userCredential.user!.uid).set({
    'uid' : userCredential.user!.uid,
    'email' : email,
  }, SetOptions(merge: true));

  return userCredential;
}
// catch any errors
on FirebaseAuthException catch (e){
  throw Exception(e.code);
}
  }
  // create a new user
  Future<UserCredential> signUpWithEmailandPassword (String email,password) async{
    try{
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
    return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
    // after creating user, lets create a new document for the user in the users collection


    // _fireStore.collection('users').doc(userCredential.user!.uid).set({
    //   'uid' : userCredential.user!.uid,
    //   'email' : email,
    // },
    // );

  }
// sign out
Future<void> signOut() async => await FirebaseAuth.instance.signOut();
  }

