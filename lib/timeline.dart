import 'package:flutter/material.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimelinePageState createState() => new _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  void _logout() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Logout"),
            textColor: Colors.white,
            onPressed: _logout,
          )
        ],
      ),
      body: new Center(
        child: new Text("Hi! Welcome to FlutterDon!"),
      )
    );
  }
}