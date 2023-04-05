import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types, must_be_immutable
class Video_Player extends StatefulWidget {
  VideoPlayerController controller;
  Video_Player({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  State<Video_Player> createState() => _Video_PlayerState();
}

// ignore: camel_case_types
class _Video_PlayerState extends State<Video_Player> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              )
            : Container(),
        Positioned(
          left: 170,
          bottom: 80,
          child: FloatingActionButton(
            onPressed: () {
              setState(
                () {
                  widget.controller.value.isPlaying
                      ? widget.controller.pause()
                      : widget.controller.play();
                },
              );
            },
            child: Icon(
              widget.controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}
