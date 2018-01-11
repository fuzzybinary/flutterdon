import 'package:flutter/material.dart';

import 'utilities/toot_utilities.dart';
import 'mastodon/mastodon.dart';

class TootDetailsPage  extends StatelessWidget {
  final Status toot;

  TootDetailsPage({Key key, this.toot}) : super(key: key) {
    
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("test")),
      body: new ListView.builder(
        itemBuilder: (context, index) {
          return new Container(
            //child: new Text(widget.toot.content)
            child: new RichText(
              text: TootUtilities.createTextSpansForTootHTML(context, toot.content),
            )
          );
        },
        itemCount: 1,
      )
    ); 
  }
}