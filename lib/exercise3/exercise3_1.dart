import 'package:flutter/material.dart';
import 'package:training_newwave/model/salad_entity.dart';

// ignore: must_be_immutable
class TrainingC3 extends StatefulWidget {

  var isThemeLight = true;

  TrainingC3({Key key, this.isThemeLight}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TrainingC3State();
  }
}

class TrainingC3State extends State<TrainingC3> {
  var isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.isThemeLight ? Colors.white : Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: widget.isThemeLight ? Colors.black : Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Salad",
          style: TextStyle(
            color: widget.isThemeLight ? Colors.black : Colors.white,
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (widget.isThemeLight) {
                    widget.isThemeLight = false;
                  } else {
                    widget.isThemeLight = true;
                  }
                });
              },
              icon: Icon(
                Icons.search,
                color: widget.isThemeLight ? Colors.black : Colors.white,
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
          padding: const EdgeInsets.only(bottom: 20),
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  itemCount: saladItems.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 16,
                    );
                  },
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
                        color:
                            widget.isThemeLight ? Colors.black : Colors.white,
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
                child: GridView.builder(
                  itemCount: saladItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1 / 1.3,
                    mainAxisSpacing: 15.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 -
                              MediaQuery.of(context).padding.horizontal,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(
                                saladItems[index].assetImage,
                              ),
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
                                width:
                                    MediaQuery.of(context).size.width / 2 - 40,
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
                              isRefresh ? Icons.search : Icons.bookmark_border,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
