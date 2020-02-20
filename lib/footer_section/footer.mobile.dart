import 'package:flutter/material.dart';

class FooterMobile extends StatelessWidget {
  //final double width;
  const FooterMobile();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            height: 72,
            width: 72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"))),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "2020 \u00a9 OmeVision \u{1f60e}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
