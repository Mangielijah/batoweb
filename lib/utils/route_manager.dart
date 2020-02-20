// import 'package:bato/ui/screens/create_account.dart';
// import 'package:bato/ui/screens/favorites.dart';
// import 'package:bato/ui/screens/listing_posted.dart';
// import 'package:bato/ui/screens/login.dart';
// import 'package:bato/ui/screens/main.dart';
// import 'package:bato/ui/screens/messages.dart';
import 'package:bato_test/screens/category.view.dart';
import 'package:bato_test/screens/home.view.dart';
import 'package:bato_test/screens/listing.view.dart';
import 'package:bato_test/utils/route_name.dart';
// import 'package:bato/ui/widgets/profile_settings.dart';
// import 'package:bato/ui/screens/search.dart';
// import 'package:bato/ui/screens/search_user.dart';
// import 'package:bato/ui/screens/view_item.dart';
import 'package:flutter/material.dart';
import 'package:bato_test/utils/string_extension.dart';

///Manage Routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Getting the argument passed when Navigator.pushNamed() is called
    var routingData = settings.name.getRoutingData;
    switch (routingData.route) {
      case HomeRoute:
        return MaterialPageRoute(builder: (context) => Home());
      case ListingViewRoute:
        if (routingData['listingId'] is String) {
          return MaterialPageRoute(
              builder: (context) => ListingView(
                  listingId: routingData['listingId'],
                  posterId: routingData['posterId'],
                  subCategory: routingData['subCategory'],));
        }
        return _errorPage();
      case CategoryViewRoute:
        if (routingData['mainCategory'] is String) {
          return MaterialPageRoute(
            builder: (context) => CategoryView(
              mainCategory: routingData['mainCategory'],
              subCategory: routingData['subCategory'],
            ),
          );
        }
        return _errorPage();
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Container(),
            ));
  }
}
