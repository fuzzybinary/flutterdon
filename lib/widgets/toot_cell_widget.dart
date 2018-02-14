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
          padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: new IntrinsicHeight(
            child: new Row(
              children: <Widget>[
                new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                      height: 10.0,
                      decoration: new BoxDecoration(
                        border: new Border.all()
                      ),
                    ),
                    new Image.network(widget.status.account.avatarStatic,
                      width: 50.0,
                      height: 50.0,
                    ),
                    new Expanded(
                      child: new Container(
                        decoration: new BoxDecoration(border: new Border.all()),
                      )
                    )
                  ]
                ),
                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: _createTextTree(context, widget.status.content)
                      ),
                      new Container(
                        height: 30.0,
                        child: new Row(
                          children: <Widget>[
                            new FlatButton(
                              child: new Text("Reply"),
                              onPressed: () {},
                            ),
                            new FlatButton(
                              child: new Text("RT"),
                              onPressed: () {},
                            ),
                            new FlatButton(
                              child: new Text("Fav"),
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ],
                  )
                )
              ]
            )
          ) 
        )
      );
    }
}