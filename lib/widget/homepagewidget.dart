
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:quiz_app/widget/courses_widget.dart';

Widget homepageWidget = SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(
                  s: "Featured Courses",
                  size: size.height * 0.016,
                  fw: FontWeight.w400,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SizedBox(
                  height: size.height * 0.118,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 5; i++) ...[
                        getCourse(),
                        const SizedBox(
                          width: 8,
                          height: 0.1,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        )));


