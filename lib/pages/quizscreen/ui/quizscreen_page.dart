import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/pages/quizscreen/bloc/quiz_bloc.dart';
import 'package:quiz_app/pages/quizscreen/data/quizdata.dart';
import 'package:quiz_app/pages/quizscreen/ui/resultpage.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizscreenPage extends StatelessWidget {
  const QuizscreenPage({super.key});
  static int length = questions.length - 1;
  static int i = 0;
  @override
  Widget build(BuildContext context) {
    String? selectedOption;
    List<String?> submitted = List.generate(length + 1, (_) => null);
    int result = 0;

    Widget option1 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(s: "${questions[i]["o1"]}", size: size.height * 0.008),
    );

    Widget option2 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(s: "${questions[i]["o2"]}", size: size.height * 0.008),
    );
    Widget option3 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(s: "${questions[i]["o3"]}", size: size.height * 0.008),
    );
    Widget option4 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(s: "${questions[i]["o4"]}", size: size.height * 0.008),
    );
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: BlocConsumer<QuizBloc, QuizState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is QuizSubmittedState) {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (context) => ResultPage(
                      result: result,
                      size: size,
                    )));
          }
          if (state is NextQuizState) {
            if (i < length) {
              if (selectedOption == "") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Answer this question to move further")));
                return;
              }
              submitted.insert(i, "${questions[i][selectedOption]}");
              selectedOption = "";

              i++;
              option1 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${questions[i]["o1"]}", size: size.height * 0.008),
              );

              option2 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${questions[i]["o2"]}", size: size.height * 0.008),
              );
              option3 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${questions[i]["o3"]}", size: size.height * 0.008),
              );
              option4 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${questions[i]["o4"]}", size: size.height * 0.008),
              );
            }
          }

          if (state is S1QuizState) {
            option1 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "o1" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${questions[i]["o1"]}", size: size.height * 0.008),
            );

            option2 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "o2" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${questions[i]["o2"]}", size: size.height * 0.008),
            );
            option3 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "o3" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${questions[i]["o3"]}", size: size.height * 0.008),
            );
            option4 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "o4" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${questions[i]["o4"]}", size: size.height * 0.008),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(children: [
                  SlideCountdownSeparated(
                      duration: const Duration(minutes: 2),
                      separatorType: SeparatorType.title,
                      slideDirection: SlideDirection.up,
                      onDone: () {
                        result = getMarks(submitted);

                        context.read<QuizBloc>().add(QuizSubmittedEvent());
                      }),
                  InkWell(
                      onTap: () {
                        result = getMarks(submitted);

                        context.read<QuizBloc>().add(QuizSubmittedEvent());
                      },
                      child: const Text(
                        "Finish Text",
                        style: TextStyle(color: Colors.blue),
                      ))
                ]),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.list,
                      size: size.height * 0.016,
                    ),
                    getText(
                        s: "${i + 1}/${length + 1}", size: size.height * 0.012),
                    InkWell(
                        onTap: () {
                          context.read<QuizBloc>().add(NextQuizEvent());
                        },
                        child: Icon(Icons.arrow_forward_sharp,
                            size: size.height * 0.016))
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey,
                      child: getText(
                          s: "${questions[i]["q"]}", size: size.height * 0.008),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                      child: const Text(
                          "Select the correct option from given below :"),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          InkWell(
                              onTap: () {
                                selectedOption = "o1";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "o2";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option2),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "o3";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option3),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "o4";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
