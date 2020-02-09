import 'package:flutter/material.dart';

class NavBarMenuDesktop extends StatelessWidget {
  const NavBarMenuDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MenuItem("Cars & Property"),
          MenuItem("Fashion"), 
          MenuItem("Home & Living"),
          MenuItem("Mobiles & Electronics"),
          MenuItem("Hobbies & Games"),
          MenuItem("Jobs & Services"),
          MenuItem("Others")
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 18.0),);
  }
}