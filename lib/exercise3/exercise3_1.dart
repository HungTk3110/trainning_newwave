import 'package:flutter/material.dart';
import 'package:training_newwave/exercise3/widget/item_girdview_salad.dart';
import 'package:training_newwave/model/salad_entity.dart';

import 'widget/item_listview_salad.dart';

// ignore: must_be_immutable
class TrainingC3 extends StatefulWidget {
  var isThemeLight = true;

   TrainingC3({
    Key? key,
  }) : super(key: key);

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
      appBar: _appBarWidget(),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            if (isRefresh) {
              isRefresh = false;
            } else {
              isRefresh = true;
            }
          });
          return Future<void>.delayed(
            const Duration(microseconds: 600),
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              _listViewSaladWidget(
                listSalad: saladItems,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort by",
                      style: TextStyle(
                        color: widget.isThemeLight ? Colors.black : Colors.white,
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
              _girdViewSaladWidget(
                listSalad: saladItems,
                isRefresh: isRefresh,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
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
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
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
    );
  }

  Widget _listViewSaladWidget({
    required List<SaladItem> listSalad,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        itemCount: listSalad.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 16,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ItemListViewSalad(
            saladItem: listSalad[index],
          );
        },
      ),
    );
  }

  Widget _girdViewSaladWidget({
    required List<SaladItem> listSalad,
    required bool isRefresh,
  }) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: saladItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        childAspectRatio: 1 / 1.4,
        mainAxisSpacing: 15.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ItemGirdViewSalad(
          saladItem: listSalad[index],
          isRefresh: isRefresh,
        );
      },
    );
  }
}
