import 'package:cloud_firestore/cloud_firestore.dart';

class FetchTest {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> tests() {
  return _firebaseFirestore
      .collection("Test Series")
      .snapshots();
}  

 Stream<QuerySnapshot> solutions() {
  return _firebaseFirestore
      .collection("videosolution")
      .snapshots();
}  
}
