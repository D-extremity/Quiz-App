import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> uploadResult(
    {required testSeriesName,
    required String name,
    required String userUid,
    required String marks,
    required String totalQuestions}) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    // for admin panel
    await _firestore
        .collection("results")
        .doc(testSeriesName)
        .set({'name': testSeriesName});
    await _firestore
        .collection("results")
        .doc(testSeriesName)
        .collection(testSeriesName)
        .doc(userUid)
        .set({
      'name': name,
      'userUid': userUid,
      'marks': marks,
      'totalQuestions': totalQuestions,
      'testSeriesName': testSeriesName
    });
// for user side
    await _firestore
        .collection("usersideresult")
        .doc(userUid)
        .collection(userUid)
        .doc(testSeriesName)
        .set({
      'name': name,
      'userUid': userUid,
      'marks': marks,
      'totalQuestions': totalQuestions,
      'testSeriesName': testSeriesName
    });

    return "Result saved";
  } catch (e) {
    return "problem occurred";
  }
}
