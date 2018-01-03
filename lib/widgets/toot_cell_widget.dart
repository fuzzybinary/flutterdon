import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../mastodon/mastodon.dart';
import '../mastodon/simple_html_parser.dart';

class TootCell extends StatefulWidget {
  TootCell({Key key, this.status}) : super(key: key);

  final Status status;

  @override
  _TootCellState createState() => new _TootCellState();
}

class _TootCellState extends State<TootCell> {
  TextStyle _getStyleForTag(TagInfo info) {
    switch(info.tag) {
      case 'a':
        return new TextStyle(color: Colors.deepOrange);
      case 'b':
        return new TextStyle(fontWeight: FontWeight.bold);
    }

    return null;
  }
  
  TextSpan _parseTree(BuildContext context, String tree) {
    final escape = new HtmlUnescape();
    final spanStack = new List<TextSpan>();
    var currentSpan = new TextSpan(
      children: [],
      style: DefaultTextStyle.of(context).style
    );
    bool inInvisibleSpan = false;
    bool isLink = false;
    String currentLink;
    bool needElipsis = false;
    parseSimplHtml(tree, (type, info) {
      switch(type) {
        case NodeType.Open:
          if(info.tag == 'p' && currentSpan.children.length > 0) {
            currentSpan.children.add(new TextSpan(text: '\n\n'));
          } else if (info.tag == 'span' && info.attributes != null) {
            if(info.attributes['class'].contains('invisible')) {
              inInvisibleSpan = true;
              return;
            }
            if(info.attributes['class'].contains('ellipsis')) {
              needElipsis = true;
            }
          }

          if (info.tag == 'br') {
            TextSpan brspan = new TextSpan(text: '\n');
            currentSpan.children.add(brspan); 
          } else {
            var style = _getStyleForTag(info);
            spanStack.add(currentSpan);
            if(info.tag == 'a') {
              isLink = true;
              currentLink = info.attributes['href'];
            }
            
            currentSpan = new TextSpan(children: [], 
              style: style, 
            ); 
          }
          break;
        case NodeType.Close:
          if(inInvisibleSpan || info.tag == 'br') {
            inInvisibleSpan = false;
            return;
          }
          isLink = false;
          final holder = currentSpan;
          currentSpan = spanStack.removeLast();
          currentSpan.children.add(holder);
          break;
        case NodeType.Text:
          if(!inInvisibleSpan) {
            var text = escape.convert(info.tag);
            if(needElipsis) {
              text += '...';
              needElipsis = false;
            }
            TapGestureRecognizer recognizer;
            if(isLink) {
              recognizer = new TapGestureRecognizer();
              recognizer.onTap = () {
                print(currentLink);
              };
            } 
            currentSpan.children.add(new TextSpan(text: text, recognizer: recognizer));
          }
          break;
      }
    });

    assert(spanStack.length == 0);
    return currentSpan;
  }

  RichText _createTextTree(BuildContext context, String status) {
    
    return new RichText(
      text: _parseTree(context, status),
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