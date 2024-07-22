import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/backend/userprofile.dart';
import 'package:quiz_app/pages/homepage.dart';

class Authorization {
  final BuildContext context;
  final String name;
  final String phoneNumber;
  final int? bornYear;
  final String? gender;
  final String? highestQualification;
  Authorization(this.context,
      {required this.name,
      required this.phoneNumber,
      required this.bornYear,
      required this.gender,
      required this.highestQualification});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signUpwithPhoneNumber() async {
    final TextEditingController otp = TextEditingController();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Verifying Number..."),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ));
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sending OTP"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ));
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (context) => OTPPage(otpController: otp,onPressed: () async {
                    try {
                      // print(verificationId +
                      //     " " +
                      //     resendToken.toString() +
                      //     " " +
                      //     otp.text);
                      // if (verificationId != otp.text.trim()) {
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text("Invalid code"),
                      //     duration: Duration(seconds: 2),
                      //   ));
                      //   return;
                      // }
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otp.text.trim());
                      UserCredential useruid =
                          await _auth.signInWithCredential(credential);
                      await UploadProfile().uploadProfile(
                          name,
                          phoneNumber,
                          bornYear.toString(),
                          highestQualification!,
                          gender!,
                          useruid.user!.uid,
                          context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Successfully Signed In"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(
                              )));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Some error occurred: Try after sometime"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      log(e.toString());
                    }
                  })));
        }),
        codeAutoRetrievalTimeout: (String idk) {});
  }
}

// void showOTPDialog(
//     {required TextEditingController controller,
//     required BuildContext context,
//     required VoidCallback onPressed}) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height / 2.5,
//           child: AlertDialog(
//             title: const Text("Enter OTP"),
//             content: Column(
//               children: [
//                 TextField(
//                   controller: controller,
//                 )
//               ],
//             ),
//             actions: [
//               TextButton(onPressed: onPressed, child: const Text("Submit"))
//             ],
//           ),
//         );
//       });
// }

class OTPPage extends StatelessWidget {
  final VoidCallback onPressed;
  final  TextEditingController otpController;

  const OTPPage({super.key, required this.onPressed, required this.otpController});

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
