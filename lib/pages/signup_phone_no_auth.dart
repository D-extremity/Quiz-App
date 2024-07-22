import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:quiz_app/pages/newuserdetailspage.dart";
import "package:quiz_app/pages/phone_login.dart";
import "package:quiz_app/utils/font_style.dart";

class PhoneSignInPage extends StatefulWidget {
  const PhoneSignInPage({super.key});

  @override
  State<PhoneSignInPage> createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  final TextEditingController _getName = TextEditingController();
  final TextEditingController _getPhoneNumber = TextEditingController();

  @override
  void dispose() {
    _getPhoneNumber.dispose();
    _getName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Container(
      // padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      color: Colors.black,
      child: signUp(context,size))));
  }

  Widget signUp(BuildContext context, Size size) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.06,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              getText(
                  s: "Welcome!",
                  size: size.height * 0.08,
                  fw: fb,
                  color: Colors.white),
              getText(
                  s: "Join quizzrad and invite friends",
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
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
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
                  getText(s: "Name", size: size.height * 0.02),
                  TextFormField(
                    controller: _getName,
                    decoration: const InputDecoration(
                        hintText: ("Enter your name"),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: size.height * 0.022,
                  ),
                  getText(s: "Phone Number", size: size.height * 0.02),
                  TextFormField(
                    controller: _getPhoneNumber,
                    decoration: const InputDecoration(
                        hintText: ("Enter your Phone Number"),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const LinearBorder(),
                            backgroundColor: Colors.black,
                            minimumSize:
                                Size(size.width * 0.8, size.height * 0.06)),
                        onPressed: () {
                          if (
                              _getName.text.isNotEmpty &&
                              _getPhoneNumber.text.isNotEmpty) {
                            if (_getPhoneNumber.text.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      "Invalid Phone Number")));
                              return;
                            }

                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => NewUserDetailPage(name: _getName.text, phoneNumber: _getPhoneNumber.text,)));
                            
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Some fields are empty")));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(
                            builder: (context) => const PhoneSignUpPage()));
                      },
                      child: getText(
                          s: "Already have an Account? Click Here",
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
    );
  }
}
