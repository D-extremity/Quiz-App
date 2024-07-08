import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/bloc/auth_bloc_bloc.dart';
import 'package:quiz_app/pages/homepage.dart';
import 'package:quiz_app/pages/login_page.dart';
import 'package:quiz_app/pages/quizscreen/bloc/quiz_bloc.dart';
import 'package:quiz_app/pages/signup.dart';
import 'package:quiz_app/utils/globals.dart';
import 'package:quiz_app/website/home_web.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBlocBloc>(
            create: (_) => AuthBlocBloc(),
          ),
          BlocProvider<QuizBloc>(
            create: (_) => QuizBloc(),
          ),
        ],
        child: (kIsWeb)
            ? const WebsiteHomePage()
            : StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const HomePage();
                  }
                  if (snapshot.hasError) {
                    return const LoginPage();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text("Internet Seems to be slow")
                          ],
                        ),
                      ),
                    );
                  }
                  return const Signup();
                  // return WebsiteHomePage();
                }),
      ),
    );
  }
}
