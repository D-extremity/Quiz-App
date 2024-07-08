import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(Uint8List img) async {
    Reference ref =
        _storage.ref().child("QuestionImage").child("${const Uuid().v7()}.jpg");
    UploadTask uploadtask = ref.putData(img);
    TaskSnapshot snap = await uploadtask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

getImage() async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return image.readAsBytes();
  }
}

class UploadTest {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> uploadTest(String testName, String testImageUrl,
      List<Map<String, String>> testQuestions, BuildContext context) async {
    try {
      await _firebaseFirestore.collection("Test Series").doc(testName).set({
        'name': testName,
        'coverImg': testImageUrl,
        'testQuest': testQuestions
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully uploaded test series")));
      Navigator.of(context).pop();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred: ${e.toString()}")));
      return false;
    }
  }
}
