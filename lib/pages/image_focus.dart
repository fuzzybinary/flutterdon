import 'package:flutter/material.dart';

import '../mastodon/models.dart';

class ImageFocusPage extends StatefulWidget {
  final List<Attachment> attachments;
  final int initialFocus;

  const ImageFocusPage({
    super.key,
    required this.attachments,
    required this.initialFocus,
  });

  @override
  State<ImageFocusPage> createState() => _ImageFocusPageState();
}

class _ImageFocusPageState extends State<ImageFocusPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: widget.initialFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        controller: pageController,
        itemCount: widget.attachments.length,
        itemBuilder: (context, index) {
          final attachment = widget.attachments[index];
          return SizedBox.expand(
            child: InteractiveViewer(
              child: Hero(
                tag: attachment.id,
                child: Image.network(attachment.url),
              ),
            ),
          );
        },
      ),
    );
  }
}
