import 'package:cloud_firestore/cloud_firestore.dart';

class FetchTest {
  final String courseOpted;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FetchTest({required this.courseOpted});
  Stream<QuerySnapshot> tests() {
    return _firebaseFirestore
        .collection(courseOpted + "testseries")
        .snapshots();
  }

  Stream<QuerySnapshot> solutions() {
    return _firebaseFirestore.collection(courseOpted + "solution").snapshots();
  }

  Stream<QuerySnapshot> notes() {
    return _firebaseFirestore.collection(courseOpted + "notes").snapshots();
  }

  Stream<QuerySnapshot> results(String userUid) {
    return _firebaseFirestore
        .collection("usersideresult")
        .doc(userUid)
        .collection(userUid)
        .snapshots();
  }
}
