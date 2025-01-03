// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/homepage.dart';

class LoginAuthorization {
  final BuildContext context;
  final String phoneNumber;

  LoginAuthorization(
    this.context, {
    required this.phoneNumber,
  });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInwithPhoneNumber() async {
    final TextEditingController otp = TextEditingController();

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => OTPPage(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otp.text.trim());
                        UserCredential useruid =
                            await _auth.signInWithCredential(credential);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Successfully Signed In"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Some error occurred: Check your OTP"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        log(e.toString());
                      }
                    },
                    otpController: otp,
                  )));
        }),
        codeAutoRetrievalTimeout: (String idk) {});
  }
}

class OTPPage extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController otpController;

  const OTPPage(
      {super.key, required this.onPressed, required this.otpController});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Enter OTP",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: TextField(
                  controller: otpController,
                  maxLength: 6,
                  style: TextStyle(
                    fontSize: 30,
                    color: theme.colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                  onTapOutside: (void v) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: "",
                    focusedBorder: border(theme.colorScheme.primary),
                    enabledBorder: border(theme.colorScheme.onBackground),
                  ))),
          SizedBox(height: size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: theme.colorScheme.onError),
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: theme.colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(20));

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.green,
    background: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Colors.teal,
    secondary: Colors.lime,
    background: Colors.black,
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  ),
);
