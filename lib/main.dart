import 'package:flutter/material.dart';
import 'package:training_newwave/exercise5/screen1.dart';

import 'exercise3/exercise3_1.dart';
import 'exercise4/exercise4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomeMyApp(),
    );
  }
}

class HomeMyApp extends StatefulWidget {
  const HomeMyApp({Key key}) : super(key: key);

  @override
  State<HomeMyApp> createState() => _HomeMyAppState();
}

class _HomeMyAppState extends State<HomeMyApp> {

  var isThemeLight = true;

  @override
  Widget build(BuildContext context) {
    // theme: isThemeLight ? ThemeData.light() : ThemeData.dark(),
    return Scaffold(
      appBar: AppBar(
        title: const Text("training newwave"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Builder(
              builder: (context) {
                return const Text(
                  'Exercise 3',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainingC3(
                    isThemeLight: isThemeLight,
                  ),
                ),
              );
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Builder(
              builder: (context) {
                return const Text(
                  'Exercise 4',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Exercise4(),
                ),
              );
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Builder(
              builder: (context) {
                return const Text(
                  'Exercise 5',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  Screen1(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
