import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'exercise3/exercise3_1.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: MyApp2(),
    );
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  var isRefresh = false;
  var isThemeLight = true;

  @override
  Widget build(BuildContext context) {
    // theme: isThemeLight ? ThemeData.light() : ThemeData.dark(),
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
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
                    isRefresh: isRefresh,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
