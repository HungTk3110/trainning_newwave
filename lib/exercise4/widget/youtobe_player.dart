import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: camel_case_types, must_be_immutable
class Youtube_Player extends StatefulWidget {
  YoutubePlayerController ytbPlayerController;

  Youtube_Player({
    Key? key,
    required this.ytbPlayerController,
  }) : super(key: key);

  @override
  State<Youtube_Player> createState() => _Youtube_PlayerState();
}

// ignore: camel_case_types
class _Youtube_PlayerState extends State<Youtube_Player> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: widget.ytbPlayerController,
      showVideoProgressIndicator: true,
    );
  }
}
