import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_newwave/exercise5/screen1.dart';
import 'package:training_newwave/movie_app/movie_with_bloc/movie_home/movie_home_screen.dart';
import 'package:training_newwave/movie_app/movie_with_getx/movie_home/moive_home_screen.dart';
import 'package:training_newwave/movie_app/movie_with_provider/movie_detail/movie_detail_provider.dart';
import 'package:training_newwave/movie_app/movie_with_provider/movie_home/movie_home_provider.dart';
import 'package:training_newwave/movie_app/movie_with_provider/movie_home/moive_home_provider_screen.dart';
import 'package:training_newwave/movie_app/movie_with_set_state/movie_home.dart';
import 'package:training_newwave/note_app/note_home/notes_home_screen.dart';
import 'package:training_newwave/note_app_firebase_storage/note_home_firebase/notes_home_firebase_screen.dart';
import 'package:training_newwave/note_app_isar/isar/isar_helper.dart';
import 'package:training_newwave/note_app_isar/note_home_isar/notes_home_isar_screen.dart';

import 'exercise3/exercise3_1.dart';
import 'exercise4/exercise4.dart';

Future<void> main() async {
  final IsarHelper isarHelper = IsarHelper.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await isarHelper.init();
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  builder: (context) => TrainingC3(),
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
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Builder(
              builder: (context) {
                return const Text(
                  'NotesApp',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteHomeScreen(),
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
                  'NotesApp With Firebase',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteHomeFirebaseScreen(),
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
                  'NotesApp With Isar',
                  style: TextStyle(fontSize: 28),
                );
              },
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteHomeIsarScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
