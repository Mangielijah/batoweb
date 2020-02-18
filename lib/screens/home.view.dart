import 'package:bato_test/banner_section/banner_section.controller.dart';
import 'package:bato_test/category_section/category_controller.dart';
import 'package:bato_test/hot_deals/hot_deals_controller.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          body: Container(
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
            SizedBox(height: 4.0,),
            Container(
              height: MediaQuery.of(context).size.height - 112,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    BannerSection(),
                    CategoryController(),
                    HotDealsController()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//height: MediaQuery.of(context).size.height - 107,
