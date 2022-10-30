import 'package:flutter/material.dart';

import '../mastodon/models.dart';
import '../utilities/status_utilities.dart';
import 'poster_avatar.dart';

class StatusCell extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Status status;

  const StatusCell({
    super.key,
    required this.status,
    this.isFirst = true,
    this.isLast = true,
  });

  RichText _createTextTree(BuildContext context, String status) {
    return RichText(
      text: StatusUtilities.createTextSpansForStatusHTML(context, status),
    );
  }

  Widget _statusContent(BuildContext context) {
    var content = status.reblog?.content ?? status.content;

    return _createTextTree(context, content);
  }

  Widget _actionBar(BuildContext context) {
    return SizedBox(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: PageStorageKey<Status>(status),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 10.0,
                    decoration:
                        !isFirst ? BoxDecoration(border: Border.all()) : null,
                  ),
                  PosterAvatar(status: status),
                  Expanded(
                    child: Container(
                      decoration:
                          !isLast ? BoxDecoration(border: Border.all()) : null,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: _statusContent(context),
                    ),
                    _actionBar(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
