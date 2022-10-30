import 'package:flutter/material.dart';

import '../mastodon/models.dart';
import '../utilities/toot_utilities.dart';

class TootCell extends StatefulWidget {
  const TootCell({super.key, required this.status});

  final Status status;

  @override
  _TootCellState createState() => _TootCellState();
}

class _TootCellState extends State<TootCell> {
  RichText _createTextTree(BuildContext context, String status) {
    return RichText(
      text: TootUtilities.createTextSpansForTootHTML(context, status),
    );
  }

  Widget _actionBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: _createTextTree(context, widget.status.content)),
        SizedBox(
          height: 30.0,
          child: Row(
            children: <Widget>[
              TextButton(
                child: const Text('Reply'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('RT'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Fav'),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey<Status>(widget.status),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 10.0,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                  Image.network(
                    widget.status.account.avatarStatic,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                    ),
                  )
                ],
              ),
              Expanded(child: _actionBar())
            ],
          ),
        ),
      ),
    );
  }
}
