import 'package:flutter/material.dart';
import 'package:training_newwave/exercise4/widget/youtobe_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'widget/video_player.dart';

// ignore: camel_case_types
class Exercise4_4 extends StatefulWidget {
  const Exercise4_4({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoAppState();
  }
}

class _VideoAppState extends State<Exercise4_4> {

  VideoPlayerController _controller;
  YoutubePlayerController _ytbPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=YBRkVCRP1Gw"),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Training Newwave C4 bai 4"),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Text("Sử dụng thư viện video_player"),
              Video_Player(
                controller: _controller,
              ),
              const Text("Sử ding thư viện youtube_player_flutter"),
              Youtube_Player(
                ytbPlayerController: _ytbPlayerController,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _ytbPlayerController.dispose();
  }
}
