import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class C4b2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Training Newwave C4 bai 2"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text("Sử dụng Image.network"),
              ),
              Card(
                child: ListTile(
                  title: Text("@airplanes45"),
                  subtitle: Text("Sarah Paul"),
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
                padding: EdgeInsets.all(20),
                child: Text("Sử dụng thư viện cached_network_image"),
              ),
              Card(
                child: ListTile(
                  title: Text("@airplanes45"),
                  subtitle: Text("Sarah Paul"),
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://blog.logrocket.com/wp-content/uploads/2021/04/Building-Flutter-desktop-app-tutorial-examples.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
