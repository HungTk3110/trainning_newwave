import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class trainingC3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeSate();
  }
}

class HomeSate extends State<trainingC3>{

   var  isRefresh = false;

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
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              isRefresh = true;
            });
            isRefresh = true;
            return Future<void>.delayed(const Duration(seconds: 3));
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
                            width: MediaQuery.of(context).size.width -MediaQuery.of(context).padding.left,
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
                    }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 16,);
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
                            width: MediaQuery.of(context).size.width / 2 - MediaQuery.of(context).padding.horizontal,
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                   color:  isRefresh : C,
                                ),
                                child: const Icon(Icons.bookmark_border ,color: Colors.white,),
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
