import 'package:bato_test/utils/categories.dart';
import 'package:flutter/material.dart';

class NavBarMenuDesktop extends StatefulWidget {
  final width;
  const NavBarMenuDesktop({Key key, this.width}) : super(key: key);

  @override
  _NavBarMenuDesktopState createState() => _NavBarMenuDesktopState();
}

class _NavBarMenuDesktopState extends State<NavBarMenuDesktop> {
  List<Category> allCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCategories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints.expand(height: 25),
      child: (allCategories == null) ? Text("Loading Categories...") : ListView(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: false,
        children: allCategories.map((category){
          return MenuItem(category.categoryName);
        }).skip(1).toList()
      ),
    );
  }
}

/*
<Widget>[
          MenuItem("Cars & Property"),
          MenuItem("Fashion"), 
          MenuItem("Home & Living"),
          MenuItem("Mobiles & Electronics"),
          MenuItem("Hobbies & Games"),
          MenuItem("Jobs & Services"),
          MenuItem("Others")
        ],
*/

class MenuItem extends StatelessWidget {
  const MenuItem(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(text, style: TextStyle(fontSize: 18.0),),
    );
  }
}