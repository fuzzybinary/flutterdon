import 'package:flutter/material.dart';

import '../mastodon/mastodon.dart';

class TootCell extends StatefulWidget {
  TootCell({Key key, this.status}) : super(key: key);

  final Status status;

  @override
  _TootCellState createState() => new _TootCellState();
}

class _TootCellState extends State<TootCell> {
  

  @override
  Widget build(BuildContext context) {
    return new Container(
        key: new PageStorageKey<Status>(widget.status),
        decoration: new BoxDecoration(border: new Border.all(
          color: Colors.black,
        )),
        child: new Text(widget.status.content)
      );
  }
}