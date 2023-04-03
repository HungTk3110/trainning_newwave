import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class C4b2 extends StatelessWidget {

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
                        "https://blog.logrocket.com/wp-content/uploads/2021/04/Building-Flutter-desktop-app-tutorial-examples.png",
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
                        imageUrl: "https://blog.logrocket.com/wp-content/uploads/2021/04/Building-Flutter-desktop-app-tutorial-examples.png",
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
