import 'package:flutter/material.dart';

import '../mastodon/models.dart';
import '../utilities/status_utilities.dart';
import 'attachment_grid.dart';
import 'poster_avatar.dart';

class StatusCell extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Status status;

  Status? parentBoost;

  StatusCell({
    super.key,
    required Status status,
    this.isFirst = true,
    this.isLast = true,
  })  : status = (status.reblog != null ? status.reblog! : status),
        parentBoost = (status.reblog != null ? status : null);

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
    final themeData = Theme.of(context);
    return SizedBox(
      height: 40.0,
      child: Theme(
        data: themeData.copyWith(
          iconTheme: const IconThemeData(size: 22),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.reply),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dimmedTextStyle = TextStyle(
      color: theme.textTheme.bodyLarge!.color!.withAlpha(80),
    );

    final since = DateTime.now().difference(status.createdAt);

    return Container(
      key: PageStorageKey<Status>(status),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (parentBoost != null)
              Container(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  '🔁 ${parentBoost?.account.nonEmptyDisplayName} boosted',
                  style: dimmedTextStyle,
                ),
              ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                        child: Container(
                          decoration: !isFirst
                              ? BoxDecoration(border: Border.all())
                              : null,
                        ),
                      ),
                      PosterAvatar(
                        status: status,
                        parentReblog: parentBoost,
                      ),
                      Expanded(
                        child: Container(
                          decoration: !isLast
                              ? BoxDecoration(border: Border.all())
                              : null,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                status.account.displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '@${status.account.acct}',
                                  style: dimmedTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(since.agoString(), style: dimmedTextStyle)
                            ],
                          ),
                          _statusContent(context),
                          if (status.mediaAttachments.isNotEmpty)
                            AttachmentGrid(
                              attachments: status.mediaAttachments,
                            ),
                          _actionBar(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension AccountDisplayName on Account {
  String get nonEmptyDisplayName {
    if (displayName.isNotEmpty) {
      return displayName;
    }
    return username;
  }
}

extension DurationString on Duration {
  String agoString() {
    if (inDays > 0) {
      return '${inDays}d';
    } else if (inHours > 0) {
      return '${inHours}h';
    }

    return '${inMinutes}m';
  }
}
