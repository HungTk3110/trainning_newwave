import 'package:flutter/material.dart';
import 'package:training_newwave/exercise4/widget/youtobe_player.dart';

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
            children: const [
              Text("Sử dụng thư viện video_player"),
              Video_Player(),
              Text("Sử dụng thư viện youtube_player_flutter"),
              Youtube_Player()
            ],
          ),
        ),
      ),
    );
  }
}
