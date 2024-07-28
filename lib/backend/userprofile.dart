import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadProfile {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> uploadProfile(
      String userName,
      String phoneNumber,
      String bornYear,
      String courseOpted,
      String gender,
      String creduid,
      BuildContext context) async {
    try {
      await _firebaseFirestore.collection("Users").doc("+91$phoneNumber").set({
        'name': userName,
        'number': phoneNumber,
        'bornyear': bornYear,
        'courseOpted': courseOpted,
        'gender': gender,
        'creduid': creduid
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully created profile"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred: ${e.toString()}")));
      return false;
    }
  }

  Future<Map<String, dynamic>> getProfile(
      String uid, BuildContext context) async {
    try {
      Map<String, dynamic> userDetails = await _firebaseFirestore
          .collection("Users")
          .doc(uid)
          .get() as Map<String, dynamic>;
      return userDetails;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: const Text("User is not Registered")));
      return {};
    }
  }
}

Future<bool> updateCourse(String course, String phoneNumber) async {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  try {
    await _firebaseFirestore.collection("Users").doc("+91$phoneNumber").update({
      'courseOpted': course,
    });
    return true;
  } catch (e) {
    return false;
  }
}
