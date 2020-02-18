import 'package:bato_test/navbar/navbar.desktop.dart';
import 'package:bato_test/navbar/navbar.mobile.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          //desktop View
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 110),
            child: NavBarDesktop(constraints.biggest.width),
          );
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          // Tablet View

          return NavBarDesktop(constraints.biggest.width);
        } else {
          // mobile view of website

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: NavBarMobile(constraints.biggest.width - 20),
          );
        }
      },
    );
  }
}
