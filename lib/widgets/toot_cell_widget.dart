import 'package:flutter/material.dart';

import '../utilities/toot_utilities.dart';
import '../mastodon/models/built_models.dart';

class TootCell extends StatefulWidget {
  TootCell({Key key, this.status}) : super(key: key);

  final Status status;

  @override
  _TootCellState createState() => new _TootCellState();
}

class _TootCellState extends State<TootCell> {
  
  RichText _createTextTree(BuildContext context, String status) {
    return new RichText(
      text: TootUtilities.createTextSpansForTootHTML(context, status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        key: new PageStorageKey<Status>(widget.status),
        decoration: new BoxDecoration(border: new Border.all(
          color: Colors.black,
        )),
        child: new Padding(
          padding: new EdgeInsets.all(10.0), 
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(widget.status.account.avatarStatic,
                width: 50.0,
                height: 50.0),
              new Padding(padding: new EdgeInsets.all(5.0)),
              new Expanded(
                child: _createTextTree(context, widget.status.content)
              )
            ],
          ) 
        )
      );
    }
}