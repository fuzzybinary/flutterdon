import 'package:flutter/material.dart';

import 'splash.dart';
import 'login.dart';
import 'timeline.dart';

void main() {
  runApp(new MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SplashPage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        "/login": (context) => new LoginPage(title: "Select Mastodon Instance"),
        "/timeline": (context) => new TimelinePage(title: "Timeline")
      },
    );
  }
}
