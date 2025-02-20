import 'package:bato_test/navbar/navbar_menu.desktop.dart';
import 'package:bato_test/navbar/navbar_menu.mobile.dart';
import 'package:flutter/material.dart';

class NavBarMenu extends StatelessWidget {
  const NavBarMenu({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > 800){
          //desktop View
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 110),
            child: NavBarMenuDesktop(width: constraints.maxWidth - 240),
          );
        }
        else {
          // mobile view of website
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
            child: NavBarMenuMobile(width: constraints.maxWidth - 30,),
          );
        }
      },
    );
  }
}