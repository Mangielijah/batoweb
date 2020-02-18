import 'package:bato_test/utils/categories.dart';
import 'package:bato_test/utils/listings_manager.dart';
import 'package:flutter/material.dart';

class CategorySectionMobile extends StatelessWidget {
  const CategorySectionMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Container(
        height: 215,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.75,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Text(
                  "Explore Bato",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              _buildCategories(context)
            ],
          ),
        ),
      ),
    );
  }

  _buildCategories(BuildContext context) => Padding(
        padding: EdgeInsets.zero,
        child: Container(height: 140, child: buildCategoryIcons(context)),
      );

  Widget buildCategoryIcons(BuildContext context) {
    List<Category> categories = getCategories();

    return Container(
      child: new ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 25),
        children: categories.map((i) {
          return new Container(
            margin: EdgeInsets.only(right: 24),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RawMaterialButton(
                  onPressed: () => navigateToCategoryView(context, mainCategory: i.categoryName),
                  child: i.categoryIcon,
                  shape: new CircleBorder(),
                  elevation: 0,
                  fillColor: Colors.grey[100],
                  padding: const EdgeInsets.all(15.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 1.0),
                    child: Text(
                      i.categoryName,
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData iconData;

  const CategoryIcon({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: 50,
      color: Colors.lightBlue[400],
    );
  }
}