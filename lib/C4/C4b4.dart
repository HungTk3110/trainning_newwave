import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late YoutubePlayerController _ytbPlayerController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=YBRkVCRP1Gw") as String,
      flags: YoutubePlayerFlags(
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
            title: Text("Training Newwave C4 bai 4"),
          ),
          body: Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Sử dụng thư viện video_player"),
                  Stack(
                    children: [
                      _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : Container(),
                      Positioned(
                        left: 170,
                        bottom: 80,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("Sử dụng thư viện youtube_player_flutter"),
                  YoutubePlayer(
                    controller: _ytbPlayerController!,
                    showVideoProgressIndicator: true,
                  ),
                ],
              )),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _ytbPlayerController.dispose();
  }
}
