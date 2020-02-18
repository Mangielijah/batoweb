import 'package:bato_test/utils/categories.dart';
import 'package:bato_test/utils/listings_manager.dart';
import 'package:flutter/material.dart';

class NavBarMenuMobile extends StatefulWidget {
  final width;
  const NavBarMenuMobile({Key key, this.width}) : super(key: key);

  @override
  _NavBarMenuMobileState createState() => _NavBarMenuMobileState();
}

class _NavBarMenuMobileState extends State<NavBarMenuMobile> {
  List<Category> allCategories;

  @override
  void initState() {
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
          return MenuItem(category.categoryName, subCategories: category.subCategories,);
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
  const MenuItem(this.text, {this.subCategories});
  final String text;
  final List<Category> subCategories;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToCategoryView(context, mainCategory: this.text,),
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(text, style: TextStyle(fontSize: 18.0),),
      ),
    );
  }
}