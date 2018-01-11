import 'dart:async';

import 'package:flutter/material.dart';

import 'mastodon/mastodon.dart';
import 'toot_details.dart';

import 'widgets/toot_cell_widget.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimelinePageState createState() => new _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Status> _statusList;

  @override
  void initState() {
    super.initState();

    _loadTimeline();
  }
  
  void _logout() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  Future _loadTimeline() async {
    final mim = MastodonInstanceManager.instance();
    _statusList = await mim.currentApi.getTimeline();
    
    setState(() => {
      
    });
  }

  void _handleTap(Status status) {
    final theme = DefaultTextStyle.of(context).style;
    Navigator.push(context, new MaterialPageRoute(builder: (_) {
      return new TootDetailsPage(toot: status);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final theme = DefaultTextStyle.of(context).style;
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
      body: _buildBody()
    );
  }

  _buildBody() {
    if(_statusList == null ) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return new ListView.builder(
      itemBuilder: (BuildContext buildContext, int index) {
        return new GestureDetector(
          onTap: () { _handleTap(_statusList[index]); },
          child: new TootCell(status: _statusList[index]),
        );
      },
      itemCount: _statusList.length,
    );
  }
}