import 'package:flutter/material.dart';

import 'login.dart';
import 'splash.dart';
import 'timeline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/login': (context) =>
            const LoginPage(title: 'Select Mastodon Instance'),
        '/timeline': (context) => const TimelinePage(title: 'Timeline')
      },
    );
  }
}
