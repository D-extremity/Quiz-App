import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/bloc/bloc/auth_bloc_bloc.dart';
import 'package:quiz_app/pages/homepage.dart';
import 'package:quiz_app/pages/login_page.dart';
import 'package:quiz_app/utils/font_style.dart';

class NewUserDetailPage extends StatefulWidget {
  const NewUserDetailPage({super.key});

  @override
  State<NewUserDetailPage> createState() => _NewUserDetailPageState();
}

class _NewUserDetailPageState extends State<NewUserDetailPage> {
  String _gender = "Male";
  String _highestQualification = "Graduation";
  int _year = 2005;

  @override
  Widget build(BuildContext context) {
    Size sizee = MediaQuery.of(context).size;
    final List<int> years =
        List<int>.generate(60, (int index) => 1990 + index, growable: true);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => AuthBlocBloc(),
            child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
              listenWhen: (previous, current) => true,
              listener: (context, state) {
                if (state is AuthBlocAgeBelow15State) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Age should be greater than 15 years")));
                }
              },
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizee.height * 0.06,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Lottie.asset(
                            "assets/hamster.json",
                            height: size.height * 0.046,
                          )),
                      getText(
                          s: "Waiting for you to complete profile",
                          size: size.height * 0.006),
                      SizedBox(
                        height: sizee.height * 0.01,
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: EdgeInsets.all(sizee.height * 0.03),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getText(
                                    s: "Born Year", size: sizee.height * 0.02),
                                DropdownButton<int>(
                                  hint: getText(
                                      s: "Born Year",
                                      size: sizee.height * 0.02),
                                  value: _year,
                                  items: years.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text("$item"),
                                    );
                                  }).toList(),
                                  onChanged: (int? value) {
                                    setState(() {
                                      _year = value ?? _year;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller:
                                      TextEditingController(text: "$_year"),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.01,
                                ),
                                DropdownButton(
                                  hint: getText(
                                      s: "Gender", size: sizee.height * 0.02),
                                  value: _gender,
                                  items: <String>[
                                    "Male",
                                    "Female",
                                    "Others",
                                    "Not want to reveal"
                                  ].map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _gender = value ?? _gender;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller:
                                      TextEditingController(text: _gender),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.01,
                                ),
                                DropdownButton(
                                  hint: getText(
                                      s: "Highest Qualification",
                                      size: sizee.height * 0.02),
                                  value: _highestQualification,
                                  items: <String>[
                                    "Graduation",
                                    "Higher Secondary Education",
                                    "Diploma",
                                    "Engineering",
                                    "Higher Primary Education"
                                  ].map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _highestQualification =
                                          value ?? _highestQualification;
                                    });
                                  },
                                ),
                                TextFormField(
                                  controller: TextEditingController(
                                      text: _highestQualification),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.022,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const LinearBorder(),
                                          backgroundColor: Colors.black,
                                          minimumSize: Size(sizee.width * 0.8,
                                              sizee.height * 0.06)),
                                      onPressed: () {
                                        if (_year > 2010) {
                                          context
                                              .read<AuthBlocBloc>()
                                              .add(AuthBlocAgeBelow15Event());
                                         
                                        } else {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        }
                                      },
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.015,
                                ),
                                Center(
                                    child: getText(
                                        s: "or", size: sizee.width * 0.05)),
                                Padding(
                                  padding: EdgeInsets.all(sizee.height * 0.015),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(CupertinoPageRoute(
                                        builder: (context) => const HomePage(),
                                      ));
                                    },
                                    child: Center(
                                        child: Container(
                                      width: sizee.width * 0.7,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/g.png",
                                            height: sizee.height * 0.065,
                                            width: sizee.width * 0.065,
                                          ),
                                          getText(
                                              s: "Sign up with Google",
                                              size: sizee.height * 0.03)
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: sizee.height * 0.02,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Line 244")));
                                
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: getText(
                                        s: "Create new account? Click Here",
                                        size: sizee.width * 0.05,
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
              },
            ),
          ),
        ),
      ),
    );
  }
}