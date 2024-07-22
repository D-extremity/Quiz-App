import 'package:flutter/material.dart';
import 'package:quiz_app/website/storage/upload_question_image.dart';

class SolutionUploadPage extends StatelessWidget {
  const SolutionUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    String thumbnailUrl = "404";
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: title,
          ),
          const SizedBox(
            height: 30,
            child: Text(
                "To prevent extra data storage, Type 'Title' of your video\nThen upload 'Thumbnail' of your solution and then just upload video,\nTask will get AUTOMATED and Solution will get live on your application "),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                final image = await getImage();
                thumbnailUrl = await StorageMethods().uploadImage(image);
              },
              child: const Text("Upload Thumbnail")),
          ElevatedButton(
              onPressed: () async {
                if (title.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Upload title first")));
                  return;
                }
                if (thumbnailUrl == "404") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Upload Thumbnail first....")));
                  return;
                }
                try {
                  final video = await getVideo();
                  String videoUrl = await StorageMethods()
                      .uploadVideoSolution(video, context);

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("few Seconds More")));
                  await UploadTest()
                      .uploadSolution(title.text, videoUrl, context,thumbnailUrl);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Error Occurred, message of error is : ${e.toString()}")));
                }
              },
              child: const Text("Upload solution")),
        ],
      ),
    );
  }
}
