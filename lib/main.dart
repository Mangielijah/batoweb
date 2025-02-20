import 'package:bato_test/theme.dart';
import 'package:bato_test/utils/locator.dart';
import 'package:bato_test/utils/navigation_service.dart';
import 'package:bato_test/utils/route_manager.dart';
import 'package:bato_test/utils/route_name.dart';
import 'package:bato_test/widgets/layout_template.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  if (WebFirebase.apps.isEmpty) {
    WebFirebase.initializeApp(
        apiKey: "AIzaSyDY4PKj2xVNoEMkHhS8RWC7fCJwRW7Md3M",
        authDomain: "bato-fc824.firebaseapp.com",
        databaseURL: "https://bato-fc824.firebaseio.com",
        projectId: "bato-fc824",
        storageBucket: "bato-fc824.appspot.com",
        messagingSenderId: "406301059990",
        appId: "1:406301059990:web:138c4936c0a9a51898cbb7");
  }
  runApp(Bato());
}

class Bato extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: HomeRoute,
      builder: (BuildContext context, Widget child) => LayoutTemplate(child: child),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

