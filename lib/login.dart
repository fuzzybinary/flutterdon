import 'package:flutter/material.dart';

import 'dart:async';

import 'mastodon/mastodon.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEditingController = new TextEditingController();
  var _loading = false;
  String _exceptionMessage;

  void _performLogin() {
    _login();
    
    setState(() {
      _loading = true;
    });
  }

  Future _login() async {
    var mastodonClient = new MastodonApi(_textEditingController.text);
    try {
      await mastodonClient.login();
      Navigator.of(context).pushReplacementNamed("/timeline");
    } catch(exception) {
      setState(() {
        _loading = false;
        _exceptionMessage = exception.toString();
      });
    }
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
              _exceptionMessage == null ? new Container() : 
                new Text(_exceptionMessage,
                  style: new TextStyle(color: Colors.red)
                ) 
            ],
          ),
        ),
      )
    );
  }
}