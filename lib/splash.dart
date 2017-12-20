import 'package:flutter/material.dart';

import 'dart:async';

import 'mastodon/mastodon.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();

    _checkExistingInstance();
  }

  Future _checkExistingInstance() async {
    final mim = MastodonInstanceManager.instance();
    final instanceList = await mim.getRegisteredInstances();
    if(instanceList == null) {
      _gotoLogin();
    } else {
      // For now, only care about the first instance:
      final instanceName = instanceList.first;
      final client = new MastodonApi(instanceName);
      try {
        await client.login();
        _gotoTimeline();
      } catch(Exeception ) {
        _gotoLogin();
      }
    }
  }

  void _gotoLogin() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  void _gotoTimeline() {
    Navigator.of(context).pushReplacementNamed("/timeline");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child:  new CircularProgressIndicator() 
      )
    );
  }
}