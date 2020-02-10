import 'package:flutter/material.dart';

titleRow(BuildContext context, String titleText, {dynamic iconData}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
         iconData,
          size: 24,
          color: Theme.of(context).accentColor,
        ) ,
        SizedBox(
          width: 5,
        ),
        Text(
          titleText,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}