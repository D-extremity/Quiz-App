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
    Widget option1 = option(
        getText(
            s: "${widget.questions[QuizscreenPage.i]["A"]}",
            size: size.height * 0.008),
        Colors.grey.shade100);

    Widget option2 = option(
        getText(
            s: "${widget.questions[QuizscreenPage.i]["B"]}",
            size: size.height * 0.008),
        Colors.grey.shade100);
    Widget option3 = option(
        getText(
            s: "${widget.questions[QuizscreenPage.i]["C"]}",
            size: size.height * 0.008),
        Colors.grey.shade100);
    Widget option4 = option(
        getText(
            s: "${widget.questions[QuizscreenPage.i]["D"]}",
            size: size.height * 0.008),
        Colors.grey.shade100);
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: BlocConsumer<QuizBloc, QuizState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is QuizSubmittedState) {
            QuizscreenPage.i = 0;
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
                builder: (context) => ResultPage(
                      totalQ: widget.length,
                      result: result,
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
              option1 = option(
                  getText(
                      s: "${widget.questions[QuizscreenPage.i]["A"]}",
                      size: size.height * 0.008),
                  Colors.grey.shade100);

              option2 = option(
                  getText(
                      s: "${widget.questions[QuizscreenPage.i]["B"]}",
                      size: size.height * 0.008),
                  Colors.grey.shade100);
              option3 = option(
                  getText(
                      s: "${widget.questions[QuizscreenPage.i]["C"]}",
                      size: size.height * 0.008),
                  Colors.grey.shade100);
              option4 = option(
                  getText(
                      s: "${widget.questions[QuizscreenPage.i]["D"]}",
                      size: size.height * 0.008),
                  Colors.grey.shade100);
            }
          }

          if (state is S1QuizState) {
            image = widget.questions[QuizscreenPage.i]["img"] == ""
                ? const Text(" ")
                : Image(
                    image: NetworkImage(
                        widget.questions[QuizscreenPage.i]["img"]));
            option1 = option(
              getText(
                  s: "${widget.questions[QuizscreenPage.i]["A"]}",
                  size: size.height * 0.008),
              selectedOption == "A" ? Colors.blue : Colors.grey,
            );

            option2 = option(
              getText(
                  s: "${widget.questions[QuizscreenPage.i]["B"]}",
                  size: size.height * 0.008),
              selectedOption == "B" ? Colors.blue : Colors.grey,
            );
            option3 = option(
              getText(
                  s: "${widget.questions[QuizscreenPage.i]["C"]}",
                  size: size.height * 0.008),
              selectedOption == "C" ? Colors.blue : Colors.grey,
            );
            option4 = option(
              getText(
                  s: "${widget.questions[QuizscreenPage.i]["D"]}",
                  size: size.height * 0.008),
              selectedOption == "D" ? Colors.blue : Colors.grey,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: getText(
                    s: "Rahein Education",
                    size: size.height * 0.018,
                    color: Colors.blue.shade900,
                    fw: FontWeight.w500),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: Image.asset("assets/logo.png"),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                        s: "${QuizscreenPage.i + 1}/${widget.length + 1}",
                        size: size.height * 0.012),
                    //! below widget is not required but to make ui better it is used
                    //! when user presses left arrow then also answer gets store to list
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: LinearBorder()),
                      onPressed: () {
                        submitted.insert(QuizscreenPage.i, selectedOption);
                      },
                      child: Text("Save",
                          style: TextStyle(
                              color: Colors.blue.shade600,
                              fontSize: size.height * 0.012)),
                    ),

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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SlideCountdownSeparated(
                              duration: const Duration(minutes: 30),
                              separatorType: SeparatorType.title,
                              slideDirection: SlideDirection.up,
                              onDone: () {
                                result = getMarks(submitted, answers);

                                context
                                    .read<QuizBloc>()
                                    .add(QuizSubmittedEvent());
                              }),
                          InkWell(
                              onTap: () {
                                result = getMarks(submitted, answers);

                                context
                                    .read<QuizBloc>()
                                    .add(QuizSubmittedEvent());
                              },
                              child: Text(
                                "Finish Test",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: size.height * 0.012),
                              ))
                        ]),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    question(getText(
                        s: "${widget.questions[QuizscreenPage.i]["Q"]}",
                        size: size.height * 0.008,
                        fw: FontWeight.w500)),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    image is Text
                        ? image
                        : SizedBox(
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

Widget option(Widget child, Color color) => Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: color,
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ));

Widget question(Widget child) => Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ));
