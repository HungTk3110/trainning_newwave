import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_newwave/exercise5/screen1.dart';
import 'package:training_newwave/movie_app/movie_with_bloc/movie_home/movie_home_screen.dart';
import 'package:training_newwave/movie_app/movie_with_getx/moive_home_getx.dart';
import 'package:training_newwave/movie_app/movie_with_set_state/moive_home.dart';
import 'package:training_newwave/movie_app/provider/detail_provider.dart';
import 'package:training_newwave/movie_app/provider/home_provider.dart';

import 'exercise3/exercise3_1.dart';
import 'exercise4/exercise4.dart';
import 'movie_app/moive_home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        home: const HomeMyApp(),
      ),
    );
  }
}

class HomeMyApp extends StatefulWidget {
  const HomeMyApp({Key? key}) : super(key: key);

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
                  builder: (context) => const Screen1(),
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
                  'Movie Ui with setState',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieHome(),
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
                  'Movie Ui with provider',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieHomeProvider(),
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
                  'Movie Ui with bloc pattern',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieHomeScreen(),
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
                  'Movie Ui with GetX',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieHomeGetX(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
