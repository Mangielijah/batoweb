import 'package:bato_test/widgets/searchBar.dart';
import 'package:flutter/material.dart';

class NavBarMobile extends StatelessWidget {
  final double width;
  const NavBarMobile(this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo_only.png"))),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "Bato",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                width: 15,
              ),
              SearchBar(((this.width * 3) / 4) - 60)
            ],
          ),
        ],
      ),
    );
  }
}
