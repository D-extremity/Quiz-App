import 'package:flutter/material.dart';
import 'package:quiz_app/utils/font_style.dart';

Widget getCourse() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.302,
        height:size.height*0.118,
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.3,
                child: Image.network(
                    fit: BoxFit.cover,
                    "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/0a26f6ce-4ef9-4d3f-870b-b525a02e91ce.png"),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      s: "TUTION",
                      size: size.width * 0.02,
                      fw: FontWeight.bold,
                      color: Colors.black),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize:
                              Size(size.width * 0.02, size.height * 0.006898982)),
                      onPressed: () {},
                      child: getText(
                          s: "Register",
                          size: size.width * 0.0166,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
