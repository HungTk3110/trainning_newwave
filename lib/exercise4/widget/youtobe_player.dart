import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: camel_case_types
class Youtube_Player extends StatefulWidget {
  const Youtube_Player({Key key}) : super(key: key);

  @override
  State<Youtube_Player> createState() => _Youtube_PlayerState();
}

// ignore: camel_case_types
class _Youtube_PlayerState extends State<Youtube_Player> {
  YoutubePlayerController _ytbPlayerController;

  @override
  void initState() {
    super.initState();

    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=YBRkVCRP1Gw"),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _ytbPlayerController,
      showVideoProgressIndicator: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ytbPlayerController.dispose();
  }
}
