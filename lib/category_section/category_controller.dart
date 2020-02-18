import 'package:bato_test/category_section/category_view.dart';
import 'package:bato_test/category_section/category_view.mobile.dart';
import 'package:flutter/material.dart';

class CategoryController extends StatelessWidget {
  const CategoryController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          //desktop View
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 110),
            child: CategorySection(
              //screenWidth: constraints.biggest.width,
            ),
          );
        } else {
          // mobile view of website

          return CategorySectionMobile(
            //screenWidth: constraints.biggest.width,
            //screenHeight: constraints.biggest.height,
          );
        }
      },
    );
  }
}
