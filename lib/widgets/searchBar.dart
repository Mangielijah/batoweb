import 'package:flutter/material.dart';

///builds search bar
///
class SearchBar extends StatelessWidget {
  final double width;
  const SearchBar(this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 9,
                child: TextField(
                  onTap: () {}, //=>Navigator.of(context).pushNamed("/search") ,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    prefix: SizedBox(width: 16),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                    hintText: "Search Bato",
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: Colors.grey[500]),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[500], width: 1.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                  ),
                  autocorrect: false,
                )),
            /*Expanded(
            flex:3,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    color: Colors.grey[700],
                    size: 32,
                  ),
                  Icon(
                    Icons.comment,
                    color: Colors.grey[700],
                    size: 28,
                  ),
                ],
              ),
            ),
          )*/
          ],
        ),
      ),
    );
  }
}
