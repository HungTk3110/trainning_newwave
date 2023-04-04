import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/exercise4/exercise4_4.dart';

import 'exercise4_1.dart';
import 'exercise4_2.dart';
import 'exercise4_3.dart';

class Exercise4 extends StatelessWidget {
  const Exercise4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  Exercise4_1()));
            },
            child: const Text("Feature 1"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Exercise4_2()));
            },
            child: const Text("Feature 2"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  Exercise4_3()));
            },
            child: const Text("Feature 3"),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Exercise4_4()));
            },
            child: const Text("Feature 4"),
          ),
        ],
      ),
    );
  }
}
