import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_newwave/configs/app_constant.dart';

// ignore: camel_case_types
class Exercise4_2 extends StatelessWidget {
  const Exercise4_2({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Training Newwave C4 bai 2"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text("Sử dụng Image.network"),
              ),
              Card(
                child: ListTile(
                  title: const Text("@airplanes45"),
                  subtitle: const Text("Sarah Paul"),
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        AppConstant.imageExercise4_2,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text("Sử ding thư viện cached_network_image"),
              ),
              Card(
                child: ListTile(
                  title: const Text("@airplanes45"),
                  subtitle: const Text("Sarah Paul"),
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: AppConstant.imageExercise4_2Cache,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
