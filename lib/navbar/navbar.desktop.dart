import 'package:bato_test/widgets/searchBar.dart';
import 'package:flutter/material.dart';

class NavBarDesktop extends StatelessWidget {
  final double width;
  const NavBarDesktop(this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
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
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              SizedBox(
                width: 30,
              ),
              SearchBar(((this.width * 1) / 3) + 50)
            ],
          ),
          Row(
            children: <Widget>[
            ],
          )
        ],
      ),
    );
  }
}
