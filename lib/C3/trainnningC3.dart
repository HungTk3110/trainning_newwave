import 'package:flutter/material.dart';

import '../model/Salad_entity.dart';

class TrainingC3 extends StatefulWidget {
  const TrainingC3({super.key});


  @override
  State<StatefulWidget> createState() {
    return HomeSate();
  }
}

class HomeSate extends State<TrainingC3> {
  var isRefresh = false;
  var themeLight = true;

  List<SaladItem> saladItems = [
    SaladItem("Salad with cabbage and shrimp", "John Adams",
        "assets/images/img1.jpg"),
    SaladItem("Italian-style tomato salad", "Thomas Jefferson",
        "assets/images/img2.jpg"),
    SaladItem("Cucumber salad, cherry tomatoes", "James Madison",
        "assets/images/img3.jpg"),
    SaladItem("Corn Salad", "James Monroe", "assets/images/img4.jpg"),
    SaladItem("Avocado Salad", "John Quincy Adams", "assets/images/img5.jpg"),
    SaladItem("Potato Salad", "Martin Van Buren", "assets/images/img6.jpg"),
    SaladItem("Salad of cove beans, shrimp and potatoes", "John Tyler",
        "assets/images/img1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: themeLight ? Colors.white : Colors.black,
          leading: Icon(
            Icons.arrow_back_outlined,
            color: themeLight ? Colors.black : Colors.white,
          ),
          title: Text(
            "Salad",
            style: TextStyle(color: themeLight ? Colors.black : Colors.white),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (themeLight) {
                      themeLight = false;
                    } else {
                      themeLight = true;
                    }
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: themeLight ? Colors.black : Colors.white,
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              if (isRefresh) {
                isRefresh = false;
              } else {
                isRefresh = true;
              }
            });
            return Future<void>.delayed(const Duration(microseconds: 600));
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    itemCount: saladItems.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).padding.left,
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
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 16,
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "Sort by",
                        style: TextStyle(
                          color: themeLight ? Colors.black : Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Most popular",
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 15.0,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.swap_vert),
                            iconSize: 18,
                            color: Colors.pink,
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height * 0.7,
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
                            width: MediaQuery.of(context).size.width / 2 -
                                MediaQuery.of(context).padding.horizontal,
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
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isRefresh ? Colors.yellow : Colors.red,
                                ),
                                child: Icon(
                                    isRefresh
                                        ? Icons.search
                                        : Icons.bookmark_border,
                                    color: Colors.white),
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
