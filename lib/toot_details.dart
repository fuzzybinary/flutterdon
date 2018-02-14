import 'dart:async';

import 'package:flutter/material.dart';

import 'mastodon/mastodon.dart';
import 'mastodon/models/built_models.dart';

import 'widgets/toot_cell_widget.dart';

class TootDetailsPage extends StatelessWidget {
  final Status toot;

  TootDetailsPage({Key key, this.toot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('toot')),
      body: new _InnterTootDetailsPage(toot: toot)
    );
  }
}

class _InnterTootDetailsPage  extends StatefulWidget {
  final Status toot;

  _InnterTootDetailsPage({Key key, this.toot}) : super(key: key);
  
  @override
  _TootDetailsState createState() => new _TootDetailsState();
}

class _TootDetailsState extends State<_InnterTootDetailsPage> {  
  int rootIndex = 0;
  bool loading = false;
  Context tootContext;
  
  Future<Null> _loadContext() async {
    setState(() {
      loading = true;
    });

    try {
      tootContext = await MastodonInstanceManager.instance().currentApi.getContext(widget.toot);
    } catch(e) {

      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text("Error loading toot: $e"),
        )
      );
    }

    setState(() {
      loading = false;
    }); 
  }

  @override
  void initState() {
    super.initState();

    _loadContext();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: _buildItem,
      itemCount: tootContext == null ? 1 : tootContext.ancestors.length + tootContext.descendants.length + 1,
    ); 
  }

  Widget _buildItem(BuildContext context, int index) {
    Status status = widget.toot;
    if(tootContext != null) {
      if(index < tootContext.ancestors.length) {
        status = tootContext.ancestors[index];
      } else { 
        index -= (tootContext.ancestors.length + 1);
        if(index >= 0 && index < tootContext.descendants.length) {
          status = tootContext.descendants[index];
        }
      }
    }

    return new TootCell( status: status);
  }
}