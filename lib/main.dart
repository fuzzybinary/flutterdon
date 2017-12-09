import 'package:flutter/material.dart';

import 'dart:async';

import 'mastodon/mastodon.dart';

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
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController = new TextEditingController();
  var _loading = false;

  void _performLogin() {
    _login();
    
    setState(() {
      _loading = true;
    });
  }

  Future _login() async {
    var mastodonClient = new MastodonApi(_textEditingController.text);
    await mastodonClient.register();
    await mastodonClient.login();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Mastodon Instance:',
              ),
              new TextField(
                controller: _textEditingController,
                autofocus: true,
                autocorrect: false,
                decoration: new InputDecoration(
                  hintText: "ex: mastodon.social"
                ),
              ),
              new FlatButton(
                onPressed: _performLogin,
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: new Text("Login"),
              ),
              _loading ? new CircularProgressIndicator() : new Container(),

            ],
          ),
        ),
      )
    );
  }
}
