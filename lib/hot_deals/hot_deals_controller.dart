import 'package:bato_test/hot_deals/hot_deals.dart';
import 'package:bato_test/hot_deals/hot_deals.mobile.dart';
import 'package:flutter/material.dart';

class HotDealsController extends StatelessWidget {
  const HotDealsController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          //desktop View
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 110),
            child: HotDealsScreen(
              //screenWidth: constraints.biggest.width,
            ),
          );
        } else {
          // mobile view of website

          return HotDealsScreenMobile(
            //screenWidth: constraints.biggest.width,
            //screenHeight: constraints.biggest.height,
          );
        }
      },
    );
  }
}
