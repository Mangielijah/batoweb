// import 'package:bato/ui/screens/create_account.dart';
// import 'package:bato/ui/screens/favorites.dart';
// import 'package:bato/ui/screens/listing_posted.dart';
// import 'package:bato/ui/screens/login.dart';
// import 'package:bato/ui/screens/main.dart';
// import 'package:bato/ui/screens/messages.dart';
import 'package:bato_test/screens/home.view.dart';
import 'package:bato_test/screens/listing.view.dart';
// import 'package:bato/ui/widgets/profile_settings.dart';
// import 'package:bato/ui/screens/search.dart';
// import 'package:bato/ui/screens/search_user.dart';
// import 'package:bato/ui/screens/view_item.dart';
import 'package:flutter/material.dart';

///Manage Routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    //Getting the argument passed when Navigator.pushNamed() is called
    final args = settings.arguments;
    switch(settings.name){
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      case "/viewListing":
        if(args is String){
          return MaterialPageRoute(builder: (context) => ListingView(listingId: args));
        }
        return _errorPage();
      default:
        return _errorPage();
    }
  }
  static Route<dynamic> _errorPage(){
    return MaterialPageRoute(
      builder: (context) => 
      Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Container(),
      )
    );
  }
}
