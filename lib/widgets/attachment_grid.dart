import 'package:flutter/material.dart';

import '../mastodon/models.dart';
import '../pages/image_focus.dart';

class AttachmentGrid extends StatelessWidget {
  final List<Attachment> attachments;

  const AttachmentGrid({super.key, required this.attachments});

  void _onAttachmentTapped(BuildContext context, int index) {
    final attachment = attachments[index];
    switch (attachment.type) {
      case AttachmentType.unknown:
        // TODO: Handle this case.
        break;
      case AttachmentType.image:
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ImageFocusPage(
              attachments: attachments,
              initialFocus: index,
            );
          },
        ));
        break;
      case AttachmentType.gifv:
        // TODO: Handle this case.
        break;
      case AttachmentType.video:
        // TODO: Handle this case.
        break;
      case AttachmentType.audio:
        // TODO: Handle this case.
        break;
    }
  }

  Widget _imageAttachment(
      BuildContext context, Attachment attachment, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () => _onAttachmentTapped(context, index),
        child: Hero(
          tag: attachment.id,
          child: Image(
            image: NetworkImage(attachment.previewUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final first = attachments.first;
    Widget child;
    switch (attachments.length) {
      case 1:
        child = _imageAttachment(context, first, 0);
        break;
      case 2:
        child = Row(
          children: [
            for (int i = 0; i < attachments.length; ++i)
              Container(
                padding: const EdgeInsets.all(2),
                child: _imageAttachment(
                  context,
                  attachments[i],
                  i,
                ),
              )
          ],
        );
        break;
      case 3:
      case 4:
        child = Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < 2; ++i)
                    Expanded(
                        child: _imageAttachment(context, attachments[i], i)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 2; i < attachments.length; ++i)
                    Expanded(
                        child: _imageAttachment(context, attachments[i], i)),
                ],
              ),
            )
          ],
        );
        break;
      default:
        child = Container();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 200,
        maxWidth: 360,
      ),
      child: child,
    );
  }
}
