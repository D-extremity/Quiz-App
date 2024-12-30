import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/solution_screen/bloc/video_bloc.dart';
import 'package:quiz_app/utils/font_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoSolutionPage extends StatefulWidget {
  final Map<String, dynamic> solution;
  const VideoSolutionPage({super.key, required this.solution});

  @override
  State<VideoSolutionPage> createState() => _VideoSolutionPageState();
}

class _VideoSolutionPageState extends State<VideoSolutionPage> {
  late VideoPlayerController _controller;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.solution['videoUrl']))
          ..initialize().then((_) {
            setState(() {});
          });
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
          appBar: AppBar(
    title: getText(
        s: "Quizzard",
        size: size.height * 0.024,
        color: Colors.blue.shade900,
        fw: FontWeight.w500),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: Image.asset("assets/logo.png"),
          ),
          backgroundColor: Colors.white,
          body: BlocProvider(
    create: (context) => VideoBloc(),
    child: Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
        VideoProgressIndicator(_controller, allowScrubbing: true),
        _controller.value.isPlaying
            ? GestureDetector(
                child: Icon(
                  Icons.pause,
                  size: size.width * 0.1,
                ),
                onTap: () {
                  _controller.pause();
                  setState(() {});
                })
            : GestureDetector(
                child: Icon(
                  Icons.play_arrow,
                  size: size.width * 0.1,
                ),
                onTap: () {
                  _controller.play();
                  setState(() {});
                }),
        SizedBox(
          height: size.height * 0.1,
        ),
        getText(s: "Download PDF Solution", size: size.height * 0.014),
        widget.solution['pdf'] == "404"
            ? Text("Solution is not provided yet")
            : GestureDetector(
                onTap: () async {
                  await _launchUrl(
                      Uri.parse("${widget.solution['pdf']}"), context);
                },
                child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(children: [
                          Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                          ),
                          getText(
                              s: "${widget.solution['name']}",
                              size: size.height * 0.02)
                        ]),
                      ),
                    )),
              )
      ],
    ),
          ),
        );
  }
}

Future<void> _launchUrl(_url, BuildContext context) async {
  try {
    await launchUrl(_url);
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Some error occurred"+e.toString())));
  }
}
