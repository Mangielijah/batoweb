import 'package:bato_test/banner_section/banner_section.desktop.dart';
import 'package:bato_test/banner_section/banner_section.mobile.dart';
import 'package:flutter/material.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          //desktop View
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 110),
            child: BannerSectionDesktop(
              screenWidth: constraints.biggest.width,
            ),
          );
        } else {
          // mobile view of website

          return BannerSectionMobile(
            screenWidth: constraints.biggest.width,
            screenHeight: 616,
          );
        }
      },
    );
  }
}
