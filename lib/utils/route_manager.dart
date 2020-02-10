// import 'package:bato/ui/screens/create_account.dart';
// import 'package:bato/ui/screens/favorites.dart';
// import 'package:bato/ui/screens/listing_posted.dart';
// import 'package:bato/ui/screens/login.dart';
// import 'package:bato/ui/screens/main.dart';
// import 'package:bato/ui/screens/messages.dart';
import 'package:bato_test/screens/not_found.dart';
import 'package:bato_test/screens/home.view.dart';
import 'package:bato_test/screens/listing.view.dart';
// import 'package:bato/ui/widgets/profile_settings.dart';
// import 'package:bato/ui/screens/search.dart';
// import 'package:bato/ui/screens/search_user.dart';
// import 'package:bato/ui/screens/view_item.dart';
import 'package:flutter/material.dart';

///Manage Routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Home());
        break;
      /*case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case "/createAccount":
        return MaterialPageRoute(builder: (_) => CreateAccountScreen());
        break;
      case "/profileSettings":
        return MaterialPageRoute(builder: (_) => ProfileSettingsScreen());
        break;
      case "/search":
        return MaterialPageRoute(builder: (_) => SearchScreen());
        break;
      case "/searchUser":
        return MaterialPageRoute(builder: (_) => SearchUserScreen());
        break;
      case "/favorites":
        return MaterialPageRoute(builder: (_) => FavoritesScreen());
        break;
      case "/messages":
        return MaterialPageRoute(builder: (_) => MessagesScreen());
        break;case "/listingPosted":
        return MaterialPageRoute(builder: (_) => ListingPostedScreen());
        break;*/
      case "/viewListing":
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ListingView(
                    listingId: args,
                  ));
        }
        break;
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }
}
