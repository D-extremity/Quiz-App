  import 'package:flutter/material.dart';
import 'package:quiz_app/utils/font_style.dart';

Widget profileWidget= 
     Stack(children: [
      Container(
        margin: EdgeInsets.only(
          top: size.height * 0.08,
        ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(169, 236, 231, 231),
            boxShadow: [BoxShadow(color: Colors.grey)],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        child: const SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: size.height * 0.02),
        child: Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            maxRadius: size.width * 0.1,
          ),
        ),
      )
    ]);
  
