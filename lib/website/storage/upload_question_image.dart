// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:file_picker/file_picker.dart';
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

  Future<String> uploadVideoSolution(
      Uint8List video, BuildContext context) async {
    Reference ref =
        _storage.ref().child("videosolution").child("${const Uuid().v7()}.jpg");
    UploadTask uploadTask = ref.putData(video);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Uploading of solution is in progress....")));
    TaskSnapshot snap = await uploadTask;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Uploading of solution is in progress....Wait a little bit")));
    String downloadUrl = await snap.ref.getDownloadURL();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Video Uploaded, Please remain on screen")));
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

getVideo() async {
  final ImagePicker picker = ImagePicker();

  final XFile? galleryVideo =
      await picker.pickVideo(source: ImageSource.gallery);
  if (galleryVideo != null) {
    return galleryVideo.readAsBytes();
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
          const SnackBar(content: Text("Successfully uploaded test series")));
      Navigator.of(context).pop();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred: ${e.toString()}")));
      return false;
    }
  }

  Future<bool> uploadSolution(String testName, String videoUrl,
      BuildContext context, String thumbnailUrl) async {
    try {
      await _firebaseFirestore
          .collection("Test Series")
          .doc(testName)
          .set({'name': testName, 'videoUrl': videoUrl, 'image': thumbnailUrl});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfully uploaded Video Solution")));
      Navigator.of(context).pop();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred: ${e.toString()}")));
      return false;
    }
  }
}
