//! import 'package:firebase_auth/firebase_auth.dart';
//! import 'package:flutter/material.dart';
//! import 'package:quiz_app/utils/globals.dart';

//! class Authorization {
//!   final String name;
//!   final String email;
//!   final String password;
//!   final int? bornYear;
//!   final String? gender;
//!   final String? highestQualification;

//!   Authorization(
//!       {required this.name,
//!       required this.email,
//!       required this.password,
//!       required this.bornYear,
//!       required this.gender,
//!       required this.highestQualification});

//!   final FirebaseAuth _auth = FirebaseAuth.instance;
//!   Future<bool> createAccount() async {
//!     try {
//!       _auth.createUserWithEmailAndPassword(email: email, password: password);
//!       bool isVerificationSend = await sendVerification();
//!       if (!isVerificationSend) {
//!         scaffold.currentState!.showSnackBar(const SnackBar(
//!           content: Text("Check your credentials"),
//!           duration: Duration(seconds: 2),
//!         ));
//!         return false;
//!       }
//!       if (!_auth.currentUser!.emailVerified) {
//!         scaffold.currentState!
//!             .showSnackBar(const SnackBar(content: Text("Verify your email")));
//!       }
//!       return true;
//!     } on FirebaseAuthException catch (e) {
//!       scaffold.currentState!.showSnackBar(SnackBar(content: Text(e.message!)));
//!       return false;
//!     }
//!   }

//!   Future<bool> sendVerification() async {
//!     try {
//!       await _auth.currentUser!.sendEmailVerification();
//!       scaffold.currentState!.showSnackBar(
//!           SnackBar(content: Text("Verification link has been sent to $email")));
//!       return true;
//!     } on FirebaseAuthException catch (e) {
//!       scaffold.currentState?.showSnackBar(SnackBar(content: Text(e.message!)));
//!       return false;
//!     }
//!   }
//! }
