import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:quiz_app/website/questions_preview.dart';
import 'package:quiz_app/website/solutionuploadpage.dart';

class WebsiteHomePage extends StatelessWidget {
  const WebsiteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: getText(
            s: "Rahein Education Portal",
            size: MediaQuery.of(context).size.width * 0.01),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  hoverColor: Colors.blue,
                  onTap: () async {},
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Card(
                          color: Colors.blue.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                getText(
                                    s: "Upload quiz via .xml file",
                                    size: MediaQuery.of(context).size.height *
                                        0.02),
                                const Icon(Icons.upload)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  hoverColor: Colors.blue,
                  onTap: () async {
                    Future<bool> isFilePicked = pickFile();
                    if (await isFilePicked) {
                      await uploadQuiz(content);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) =>
                              QuestionPreview(quizContent: questions)));
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Some Error Occurred")));
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Card(
                          color: Colors.blue.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                getText(
                                    s: "Upload quiz via .txt file",
                                    size: MediaQuery.of(context).size.height *
                                        0.02),
                                const Icon(Icons.upload)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SolutionUploadPage()));
              },
              child: SizedBox(
                width: size.width * 0.25,
                child: Column(
                  children: [
                    Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            getText(
                                s: "Upload Quiz Solution",
                                size:
                                    MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
              hoverColor: Colors.blue,
              onTap: () {},
              child: SizedBox(
                width: size.width * 0.25,
                child: Column(
                  children: [
                    Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            getText(
                                s: "Stats of test series",
                                size:
                                    MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

late final String content;
Future<bool> pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      final String fileContent =
          file.bytes != null ? String.fromCharCodes(file.bytes!) : 'No content';
      content = fileContent;
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

List<Map<String, String>> questions = [];
Future<bool> uploadQuiz(String content) async {
  try {
    List<String> tempQuestion = content.split("\n");
    for (int i = 0; i < tempQuestion.length; i += 7) {
      questions.add({
        'Q': tempQuestion[0 + i],
        'A': tempQuestion[1 + i],
        'B': tempQuestion[2 + i],
        'C': tempQuestion[3 + i],
        'D': tempQuestion[4 + i],
        'ans': tempQuestion[5 + i],
        'img': "",
      });
    }
    return true;
  } catch (e) {
    return false;
  }
}
