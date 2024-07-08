import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/pages/quizscreen/bloc/quiz_bloc.dart';
import 'package:quiz_app/pages/quizscreen/data/quizdata.dart';
import 'package:quiz_app/pages/quizscreen/ui/resultpage.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizscreenPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final int length;
  const QuizscreenPage(
      {super.key, required this.questions, required this.length});

  static int i = 0;
  @override
  State<QuizscreenPage> createState() => _QuizscreenPageState();
}

class _QuizscreenPageState extends State<QuizscreenPage> {
  @override
  void dispose() {
    super.dispose();
    QuizscreenPage.i = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<String> answers = widget.questions
        .map((map) => map['ans'].toString().substring(8, 9))
        .toList();
    for (int i = 0; i < answers.length; i++) {}
    String selectedOption = "F";
    List<String> submitted = List.generate(widget.length + 1, (_) => "F");
    int result = 0;
    Widget image = widget.questions[QuizscreenPage.i]["img"] == ""
        ? const Text(" ")
        : Image(
            image: NetworkImage(widget.questions[QuizscreenPage.i]["img"]),
            fit: BoxFit.contain,
          );
    Widget option1 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(
          s: "${widget.questions[QuizscreenPage.i]["A"]}",
          size: size.height * 0.008),
    );

    Widget option2 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(
          s: "${widget.questions[QuizscreenPage.i]["B"]}",
          size: size.height * 0.008),
    );
    Widget option3 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(
          s: "${widget.questions[QuizscreenPage.i]["C"]}",
          size: size.height * 0.008),
    );
    Widget option4 = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: getText(
          s: "${widget.questions[QuizscreenPage.i]["D"]}",
          size: size.height * 0.008),
    );
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: BlocConsumer<QuizBloc, QuizState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is QuizSubmittedState) {
            QuizscreenPage.i = 0;
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (context) => ResultPage(
                      result: result,
                      size: size,
                    )));
          }
          if (state is NextQuizState) {
            if (QuizscreenPage.i < widget.length) {
              if (selectedOption == "") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Answer this question to move further")));
                return;
              }
              submitted.insert(QuizscreenPage.i, selectedOption);
              selectedOption = "";

              QuizscreenPage.i++;
              image = widget.questions[QuizscreenPage.i]["img"] == ""
                  ? const Text(" ")
                  : Image(
                      image: NetworkImage(
                          widget.questions[QuizscreenPage.i]["img"]));
              option1 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${widget.questions[QuizscreenPage.i]["A"]}",
                    size: size.height * 0.008),
              );

              option2 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${widget.questions[QuizscreenPage.i]["B"]}",
                    size: size.height * 0.008),
              );
              option3 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${widget.questions[QuizscreenPage.i]["C"]}",
                    size: size.height * 0.008),
              );
              option4 = Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey,
                child: getText(
                    s: "${widget.questions[QuizscreenPage.i]["D"]}",
                    size: size.height * 0.008),
              );
            }
          }

          if (state is S1QuizState) {
            image = widget.questions[QuizscreenPage.i]["img"] == ""
                ? const Text(" ")
                : Image(
                    image: NetworkImage(
                        widget.questions[QuizscreenPage.i]["img"]));
            option1 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "A" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${widget.questions[QuizscreenPage.i]["A"]}",
                  size: size.height * 0.008),
            );

            option2 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "B" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${widget.questions[QuizscreenPage.i]["B"]}",
                  size: size.height * 0.008),
            );
            option3 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "C" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${widget.questions[QuizscreenPage.i]["C"]}",
                  size: size.height * 0.008),
            );
            option4 = Container(
              padding: const EdgeInsets.all(8),
              color: selectedOption == "D" ? Colors.blue : Colors.grey,
              child: getText(
                  s: "${widget.questions[QuizscreenPage.i]["D"]}",
                  size: size.height * 0.008),
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
                      duration: const Duration(minutes: 30),
                      separatorType: SeparatorType.title,
                      slideDirection: SlideDirection.up,
                      onDone: () {
                        result = getMarks(submitted, answers);

                        context.read<QuizBloc>().add(QuizSubmittedEvent());
                      }),
                  InkWell(
                      onTap: () {
                        result = getMarks(submitted, answers);

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
                        s: "${QuizscreenPage.i + 1}/${widget.length + 1}",
                        size: size.height * 0.012),
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
                          s: "${widget.questions[QuizscreenPage.i]["Q"]}",
                          size: size.height * 0.008),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: size.height * 0.05,
                        child: image),
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
                                selectedOption = "A";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "B";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option2),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "C";
                                context.read<QuizBloc>().add(S1QuizEvent());
                              },
                              child: option3),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                              onTap: () {
                                selectedOption = "D";
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
