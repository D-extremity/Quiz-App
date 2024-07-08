import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/website/bloc/question_upload_bloc.dart';
import 'package:quiz_app/website/storage/upload_question_image.dart';

class QuestionPreview extends StatefulWidget {
  final List<Map<String, String>> quizContent;
  const QuestionPreview({super.key, required this.quizContent});
  @override
  State<QuestionPreview> createState() => _QuestionPreviewState();
}

class _QuestionPreviewState extends State<QuestionPreview> {
  static int questNo = 0;
  @override
  Widget build(BuildContext context) {
    String testImageurl = "";

    Widget? uploadWidget;
    int length = widget.quizContent.length;
    TextEditingController qController = TextEditingController();
    TextEditingController op1 = TextEditingController();
    TextEditingController op2 = TextEditingController();
    TextEditingController op3 = TextEditingController();
    TextEditingController op4 = TextEditingController();
    TextEditingController testSeriestitleController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => QuestionUploadBloc(),
        child: BlocConsumer<QuestionUploadBloc, QuestionUploadState>(
            builder: (context, state) {
          if (state is ImageUploadState) {}
          qController.text = widget.quizContent[questNo]['Q']!;
          Widget imWidget = widget.quizContent[questNo]['img'] != ""
              ? Image(
                  image: NetworkImage(widget.quizContent[questNo]['img']!),
                )
              : const Text("No image attached");
          Widget q = Container(
            color: Colors.grey.shade100,
            child: TextField(
              maxLines: 3,
              controller: qController,
            ),
          );
          op1.text = widget.quizContent[questNo]['A']!;
          Widget a = Container(
            color: Colors.grey.shade50,
            child: TextField(
              maxLines: 3,
              controller: op1,
            ),
          );
          op2.text = widget.quizContent[questNo]['B']!;
          Widget b = Container(
            color: Colors.grey.shade50,
            child: TextField(
              controller: op2,
              maxLines: 3,
            ),
          );
          op3.text = widget.quizContent[questNo]['C']!;
          Widget c = Container(
            color: Colors.grey.shade50,
            child: TextField(
              controller: op3,
              maxLines: 3,
            ),
          );
          op4.text = widget.quizContent[questNo]['D']!;
          Widget d = Container(
            color: Colors.grey.shade50,
            child: TextField(
              controller: op4,
              maxLines: 3,
            ),
          );
          if (state is QuestionUploadInitial) {}
          if (state is NextQuestionPreviewState) {
            if (questNo == length - 1) {
              uploadWidget = Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final Uint8List image = await getImage();
                      testImageurl = await StorageMethods().uploadImage(image);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Saved to cloud and attached")));
                    },
                    child: Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.auto_fix_normal),
                            Text("Attach Test Cover Image"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Title of Test Series"),
                    controller: testSeriestitleController,
                  ),
                  InkWell(
                    onTap: () async {
                      if(testSeriestitleController.text==""){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Test name cannot be empty")));
                        return ;
                      }
                      await UploadTest().uploadTest(
                          testSeriestitleController.text,
                          testImageurl,
                          widget.quizContent,
                          context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Saved to cloud and attached")));
                    },
                    child: Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.auto_fix_normal),
                            Text("Upload Test Series"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              questNo++;
              imWidget = widget.quizContent[questNo]['img'] != ""
                  ? Image(
                      image: NetworkImage(widget.quizContent[questNo]['img']!),
                    )
                  : const Text("No image attached");
              qController.text = widget.quizContent[questNo]['Q']!;

              q = Container(
                color: Colors.grey.shade100,
                child: TextField(
                  maxLines: 3,
                  controller: qController,
                ),
              );
              op1.text = widget.quizContent[questNo]['A']!;
              a = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  maxLines: 3,
                  controller: op1,
                ),
              );
              op2.text = widget.quizContent[questNo]['B']!;
              b = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op2,
                  maxLines: 3,
                ),
              );
              op3.text = widget.quizContent[questNo]['C']!;
              c = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op3,
                  maxLines: 3,
                ),
              );
              op4.text = widget.quizContent[questNo]['D']!;
              d = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op4,
                  maxLines: 3,
                ),
              );
            }
          }
          if (state is PreviousQuestionPreviewState) {
            if (questNo == 0) {
            } else {
              questNo--;
              imWidget = widget.quizContent[questNo]['img'] != ""
                  ? Image(
                      image: NetworkImage(widget.quizContent[questNo]['img']!),
                    )
                  : const Text("No image attached");
              qController.text = widget.quizContent[questNo]['Q']!;
              q = Container(
                color: Colors.grey.shade100,
                child: TextField(
                  maxLines: 3,
                  controller: qController,
                ),
              );
              op1.text = widget.quizContent[questNo]['A']!;
              a = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  maxLines: 3,
                  controller: op1,
                ),
              );
              op2.text = widget.quizContent[questNo]['B']!;
              b = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op2,
                  maxLines: 3,
                ),
              );
              op3.text = widget.quizContent[questNo]['C']!;
              c = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op3,
                  maxLines: 3,
                ),
              );
              op4.text = widget.quizContent[questNo]['D']!;
              d = Container(
                color: Colors.grey.shade50,
                child: TextField(
                  controller: op4,
                  maxLines: 3,
                ),
              );
            }
          }
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    color: Colors.white,
                    height: 720,
                    width: 360,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Question No. ${questNo + 1}"),
                          q,
                          const SizedBox(
                            height: 40,
                          ),
                          a,
                          const SizedBox(
                            height: 20,
                          ),
                          b,
                          const SizedBox(
                            height: 20,
                          ),
                          c,
                          const SizedBox(
                            height: 20,
                          ),
                          d,
                          const SizedBox(
                            height: 20,
                          ),
                          imWidget,
                        ],
                      ),
                    )),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<QuestionUploadBloc>()
                                .add(PreviousQuestionPreviewEvent());
                          },
                          icon: const Icon(Icons.arrow_back_rounded)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<QuestionUploadBloc>()
                                .add(NextQuestionPreviewEvent());
                          },
                          icon: const Icon(Icons.arrow_forward))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      widget.quizContent[questNo] = {
                        'Q': qController.text,
                        'A': op1.text,
                        'B': op2.text,
                        'C': op3.text,
                        'D': op4.text,
                        'ans': widget.quizContent[questNo]['ans']!,
                        'img': widget.quizContent[questNo]['img']!,
                      };
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Saved")));
                    },
                    child: Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.auto_fix_normal),
                            Text("Save"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final Uint8List image = await getImage();
                      String url = await StorageMethods().uploadImage(image);
                      widget.quizContent[questNo] = {
                        'Q': qController.text,
                        'A': op1.text,
                        'B': op2.text,
                        'C': op3.text,
                        'D': op4.text,
                        'ans': widget.quizContent[questNo]['ans']!,
                        'img': url,
                      };

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Saved to cloud and attached")));
                    },
                    child: Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.auto_fix_normal),
                            Text("Attach Image"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 720,
                width: 360,
                child: Container(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0), child: uploadWidget),
                ),
              )
            ],
          );
        }, listener: (context, state) {
          if (state is PreviousQuestionPreviewState) {
            if (questNo == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This is first question")));
            }
          }
          if (state is NextQuestionPreviewState) {
            if (questNo == length - 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This is last question")));
            }
          }
          if (state is ImageUploadState) {}
        }),
      ),
    ));
  }
}
