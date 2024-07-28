import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:url_launcher/url_launcher.dart';

Widget notesWidgets(DocumentSnapshot doc, Size size, BuildContext context) {
  Future<void> _launchUrl(_url, BuildContext context) async {
    try {
      await launchUrl(_url);
    } catch (e) {
      print(_url);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Some error occurred" + e.toString())));
    }
  }

  Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          print(data['pdf']);
          await _launchUrl(Uri.parse("${data['pdf']}"), context);
        },
        child: Container(
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image(image: NetworkImage(data['image'])),
                getText(s: data['name'], size: size.width * 0.06)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
