import 'package:flutter_bloc/flutter_bloc.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:quiz_app/bloc/bloc/auth_bloc_bloc.dart";
import "package:quiz_app/pages/homepage.dart";
import "package:quiz_app/utils/font_style.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthBlocBloc(),
          child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
              listenWhen: (previous, current) {
            return true;
          }, listener: (context, state) {
            if (state is AuthBlocInitialSignUpEvent) {
              Navigator.of(context).pop();
            }
          }, builder: (BuildContext context, AuthBlocState state) {
            return Container(
              // padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        getText(
                            s: "Welcome!",
                            size: size.height * 0.08,
                            fw: fb,
                            color: Colors.white),
                        getText(
                            s: "Your friends are waiting for you!!",
                            size: size.height * 0.028,
                            color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.03),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: size.height * 0.022,
                            ),
                            getText(s: "Email", size: size.height * 0.02),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: ("Enter your Email"),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)))),
                            ),
                            SizedBox(
                              height: size.height * 0.022,
                            ),
                            getText(s: "Password", size: size.height * 0.02),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: ("Enter your Password"),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2)))),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: LinearBorder(),
                                      backgroundColor: Colors.black,
                                      minimumSize: Size(size.width * 0.8,
                                          size.height * 0.06)),
                                  onPressed: () {},
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Center(
                                child:
                                    getText(s: "or", size: size.width * 0.05)),
                            Padding(
                              padding: EdgeInsets.all(size.height * 0.015),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                                },
                                child: Center(
                                    child: Container(
                                  width: size.width * 0.7,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        "assets/g.png",
                                        height: size.height * 0.065,
                                        width: size.width * 0.065,
                                      ),
                                      getText(
                                          s: "Sign in with Google",
                                          size: size.height * 0.03)
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: getText(
                                    s: "Create new account? Click Here",
                                    size: size.width * 0.05,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
