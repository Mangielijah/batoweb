import 'package:bato_test/banner_section/banner_section.controller.dart';
import 'package:bato_test/category_section/category_view.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:bato_test/widgets/hot_deals.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NavBar(),
          Divider(
            thickness: 0.85,
            height: 1.0,
          ),
          NavBarMenu(),
          Divider(
            thickness: 0.85,
            height: 1.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 107,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: BannerSection()),
                  Flexible(child: CategorySection()),
                  Flexible(child: HotDealsScreen())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//height: MediaQuery.of(context).size.height - 107,
