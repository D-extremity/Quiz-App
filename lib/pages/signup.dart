// import 'package:flutter_bloc/flutter_bloc.dart';
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import "package:flutter/cupertino.dart";
// import "package:flutter/material.dart";
// import "package:quiz_app/bloc/bloc/auth_bloc_bloc.dart";
// import "package:quiz_app/pages/homepage.dart";
// import "package:quiz_app/pages/login_page.dart";
// import "package:quiz_app/pages/newuserdetailspage.dart";
// import "package:quiz_app/utils/font_style.dart";

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController _getEmail = TextEditingController();
//   final TextEditingController _getName = TextEditingController();
//   final TextEditingController _getPass = TextEditingController();

//   @override
//   void dispose() {
//     _getPass.dispose();
//     _getName.dispose();
//     _getEmail.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//             body: Container(
//       // padding: EdgeInsets.symmetric(vertical: 30),
//       width: double.infinity,
//       color: Colors.black,
//       child: BlocProvider(
//         create: (context) => AuthBlocBloc(),
//         child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
//             listenWhen: (previous, current) => true,
//             listener: (BuildContext context, AuthBlocState state) {
//               if (state is AuthBlocEmailVerifiedState) {
//                 // Navigator.of(context).push(CupertinoPageRoute(
//                 //     builder: (context) => NewUserDetailPage()));
//               }
//               if (state is AuthBlocEmailNotVerifiedState) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text(
//                         "Verification mail has been sent to ${_getEmail.text}")));
//               }
//               if (state is AuthBlocInitialLoginState) {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) => LoginPage()));
//               }
//             },
//             builder: (context, state) {
//               if (state is AuthBlocEmptyFieldsEvent) {
//                 return emptyFieldScreen();
//               }
//               return signUp(context, size);
//             }),
//       ),
//     )));
//   }

//   Widget signUp(BuildContext context, Size size) {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: size.height * 0.06,
//         ),
//         Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               getText(
//                   s: "Welcome!",
//                   size: size.height * 0.08,
//                   fw: fb,
//                   color: Colors.white),
//               getText(
//                   s: "Join quizzrad and invite friends",
//                   size: size.height * 0.028,
//                   color: Colors.white),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.01,
//         ),
//         Expanded(
//             child: Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25), topRight: Radius.circular(25))),
//           child: Padding(
//             padding: EdgeInsets.all(size.height * 0.03),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: size.height * 0.022,
//                   ),
//                   getText(s: "Email", size: size.height * 0.02),
//                   TextFormField(
//                     controller: _getEmail,
//                     decoration: InputDecoration(
//                         hintText: ("Enter your Email"),
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 1, color: Colors.grey),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(2)))),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.022,
//                   ),
//                   getText(s: "Name", size: size.height * 0.02),
//                   TextFormField(
//                     controller: _getName,
//                     decoration: InputDecoration(
//                         hintText: ("Enter your name"),
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 1, color: Colors.grey),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(2)))),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.022,
//                   ),
//                   getText(s: "Password", size: size.height * 0.02),
//                   TextFormField(
//                     controller: _getPass,
//                     decoration: InputDecoration(
//                         hintText: ("Enter your Password"),
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 1, color: Colors.grey),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(2)))),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             shape: LinearBorder(),
//                             backgroundColor: Colors.black,
//                             minimumSize:
//                                 Size(size.width * 0.8, size.height * 0.06)),
//                         onPressed: () {
//                           if (_getEmail.text.isNotEmpty &&
//                               _getName.text.isNotEmpty &&
//                               _getPass.text.isNotEmpty) {
//                             if (_getPass.text.length < 8) {
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                   content: Text(
//                                       "Password length should be more than 8")));
//                               return;
//                             }
//                             // Navigator.of(context).push(CupertinoPageRoute(
//                             //     builder: (context) => NewUserDetailPage()));
//                             context
//                                 .read<AuthBlocBloc>()
//                                 .add(AuthBlocEmailVerifiedEvent());
//                             return;
//                           }
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Some fields are empty")));
//                         },
//                         child: Text(
//                           "Sign up",
//                           style: TextStyle(color: Colors.white),
//                         )),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.015,
//                   ),
//                   Center(child: getText(s: "or", size: size.width * 0.05)),
//                   Padding(
//                     padding: EdgeInsets.all(size.height * 0.015),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(CupertinoPageRoute(
//                           builder: (context) => HomePage(),
//                         ));
//                       },
//                       child: Center(
//                           child: Container(
//                         width: size.width * 0.7,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                             ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(25))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Image.asset(
//                               "assets/g.png",
//                               height: size.height * 0.065,
//                               width: size.width * 0.065,
//                             ),
//                             getText(
//                                 s: "Sign up with Google",
//                                 size: size.height * 0.03)
//                           ],
//                         ),
//                       )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Center(
//                     child: InkWell(
//                       onTap: () {
//                         // print(AuthBlocBloc().state);
//                         // context
//                         //     .read<AuthBlocBloc>()
//                         //     .add(AuthBlocInitialLoginEvent());
//                         Navigator.of(context).push(CupertinoPageRoute(
//                             builder: (context) => LoginPage()));
//                       },
//                       child: getText(
//                           s: "Already have an Account? Click Here",
//                           size: size.width * 0.05,
//                           color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ))
//       ],
//     );
//   }

//   Widget emptyFieldScreen() {
//     return Container(
//       // padding: EdgeInsets.symmetric(vertical: 30),
//       width: double.infinity,
//       color: Colors.black,
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: size.height * 0.06,
//           ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 getText(
//                     s: "Welcome!",
//                     size: size.height * 0.08,
//                     fw: fb,
//                     color: Colors.white),
//                 getText(
//                     s: "Join quizzrad and invite friends",
//                     size: size.height * 0.028,
//                     color: Colors.white),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.01,
//           ),
//           Expanded(
//               child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25))),
//             child: Padding(
//               padding: EdgeInsets.all(size.height * 0.03),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: size.height * 0.022,
//                     ),
//                     getText(s: "Email", size: size.height * 0.02),
//                     TextFormField(
//                       controller: _getEmail,
//                       decoration: InputDecoration(
//                           hintText: ("Enter your Email"),
//                           border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 1, color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(2)))),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.022,
//                     ),
//                     getText(s: "Name", size: size.height * 0.02),
//                     TextFormField(
//                       controller: _getName,
//                       decoration: InputDecoration(
//                           hintText: ("Enter your name"),
//                           border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 1, color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(2)))),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.022,
//                     ),
//                     getText(s: "Password", size: size.height * 0.02),
//                     TextFormField(
//                       controller: _getPass,
//                       decoration: InputDecoration(
//                           hintText: ("Enter your Password"),
//                           border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(width: 1, color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(2)))),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.01,
//                     ),
//                     SizedBox(
//                       height: size.height * 0.01,
//                     ),
//                     Center(
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: LinearBorder(),
//                               backgroundColor: Colors.black,
//                               minimumSize:
//                                   Size(size.width * 0.8, size.height * 0.06)),
//                           onPressed: () {
//                             // Navigator.of(context).push(CupertinoPageRoute(
//                             //     builder: (context) => NewUserDetailPage()));
//                           },
//                           child: Text(
//                             "Sign up",
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.015,
//                     ),
//                     Center(child: getText(s: "or", size: size.width * 0.05)),
//                     Padding(
//                       padding: EdgeInsets.all(size.height * 0.015),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(CupertinoPageRoute(
//                             builder: (context) => HomePage(),
//                           ));
//                         },
//                         child: Center(
//                             child: Container(
//                           width: size.width * 0.7,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1,
//                               ),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(25))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Image.asset(
//                                 "assets/g.png",
//                                 height: size.height * 0.065,
//                                 width: size.width * 0.065,
//                               ),
//                               getText(
//                                   s: "Sign up with Google",
//                                   size: size.height * 0.03)
//                             ],
//                           ),
//                         )),
//                       ),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(CupertinoPageRoute(
//                               builder: (context) => LoginPage()));
//                         },
//                         child: getText(
//                             s: "Already have an account? Click Here",
//                             size: size.width * 0.05,
//                             color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }
