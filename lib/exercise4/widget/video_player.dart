import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types
class Video_Player extends StatefulWidget {
  const Video_Player({Key key}) : super(key: key);

  @override
  State<Video_Player> createState() => _Video_PlayerState();
}

// ignore: camel_case_types
class _Video_PlayerState extends State<Video_Player> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              setState(
                () {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                },
              );
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
