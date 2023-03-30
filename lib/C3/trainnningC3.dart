import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class trainingC3 extends StatelessWidget {

  List<SaladItem> saladItems = [
    SaladItem("Salad with cabbage and shrimp", "John Adams",
        "assets/images/img1.jpg"),
    SaladItem("Italian-style tomato salad", "Thomas Jefferson",
        "assets/images/img1.jpg"),
    SaladItem("Cucumber salad, cherry tomatoes", "James Madison",
        "assets/images/img1.jpg"),
    SaladItem("Corn Salad", "James Monroe", "assets/images/img1.jpg"),
    SaladItem("Avocado Salad", "John Quincy Adams", "assets/images/img1.jpg"),
    SaladItem("Potato Salad", "Martin Van Buren", "assets/images/img1.jpg"),
    SaladItem("Salad of cove beans, shrimp and potatoes", "John Tyler",
        "assets/images/img1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          title: const Text(
            "Salad",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0 , 10.0 , 20.0 , 0),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/img1.jpg'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        child: const Text(
                          "Sort by",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              "Most popular",
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: const Icon(Icons.swap_vert),
                              iconSize: 18,
                              color: Colors.pink,
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: saladItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 1 / 1.5,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(saladItems[index].assetImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      40,
                                  child: Text(
                                    saladItems[index].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    saladItems[index].subtitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Icon(Icons.bookmark_border ,color: Colors.white,),
                              ))
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SaladItem {
  String title;
  String subtitle;
  String assetImage;

  SaladItem(this.title, this.subtitle, this.assetImage);
}
