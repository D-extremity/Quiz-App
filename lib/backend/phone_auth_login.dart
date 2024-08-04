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
        // await  showOTPBox(context, () async {
        //     try {
        //       print(otp.text);
        //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //           verificationId: verificationId, smsCode: otp.text.trim());
        //       UserCredential useruid =
        //           await _auth.signInWithCredential(credential);

        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text("Successfully Signed In"),
        //           backgroundColor: Colors.green,
        //         ),
        //       );

        //       Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(builder: (context) => const HomePage()));
        //     } catch (e) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text("Some error occurred: Check your OTP"),
        //           backgroundColor: Colors.orange,
        //         ),
        //       );
        //       log(e.toString());
        //     }
        //   }, otp);
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Enter OTP",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.3, right: size.width * 0.3),
            child: TextField(
                controller: otpController,
                maxLength: 6,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                onTapOutside: (void v) =>
                    FocusScope.of(context).requestFocus(FocusNode()),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabled: true,
                  focusedBorder: border,
                  enabledBorder: border,
                )),
          ),
          SizedBox(height: size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: onPressed,
                child:
                    const Text("Submit", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(20));

// Future<void> showOTPBox(BuildContext context, VoidCallback onPressed,
//     TextEditingController _otpController) async{
//   GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
//   showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             title: Text("OTP Verification"),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("Enter the 6 digit OTP"),
//                 SizedBox(
//                   height: 12,
//                 ),
//                 Form(
//                   key: _formKey1,
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     controller: _otpController,
//                     validator: (value) {
//                       if (value!.length != 6) return "Invalid OTP";
//                     },
//                     decoration: InputDecoration(
//                         labelText: "Enter the otp received",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child:
//                     const Text("Cancel", style: TextStyle(color: Colors.red)),
//               ),
//               TextButton(
//                   onPressed: () async{
//                     if (_formKey1.currentState!.validate()) {
//                       print("Pressed");
//                       await onPressed;
//                       print("Worked");
//                     }
//                   },
//                   child: Text("Submit"))
//             ],
//           ));
// }
