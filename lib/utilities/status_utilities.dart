import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class StatusUtilities {
  static TextStyle? _getStyleForTag(String? tag) {
    switch (tag) {
      case 'a':
        return const TextStyle(color: Colors.deepOrange);
      case 'b':
        return const TextStyle(fontWeight: FontWeight.bold);
    }

    return null;
  }

  static InlineSpan? createSpansForTree(
      dom.Node node, dom.Element? linkElement) {
    if (node.nodeType == dom.Node.ELEMENT_NODE) {
      final element = node as dom.Element;
      if (element.classes.contains('invisible')) {
        return null;
      }
      if (element.localName == 'br') {
        return const TextSpan(text: '\n');
      }
      if (element.localName == 'a') {
        linkElement = element;
      }
      var currentSpan = TextSpan(
          children: element.nodes
              .map((element) {
                return createSpansForTree(element, linkElement);
              })
              .whereType<InlineSpan>()
              .toList(),
          style: _getStyleForTag(element.localName));
      if (element.localName == 'p' && element.nextElementSibling != null) {
        currentSpan.children?.add(const TextSpan(text: '\n\n'));
      }
      return currentSpan;
    } else if (node.nodeType == dom.Node.TEXT_NODE) {
      final textNode = node as dom.Text;
      var string = textNode.data;
      if (textNode.parent?.classes.contains('ellipsis') == true) {
        string += '...';
      }
      TapGestureRecognizer? recognizer;
      final link = linkElement?.attributes['href'];
      if (link != null) {
        recognizer = TapGestureRecognizer();
        recognizer.onTap = () {
          print(link);
        };
      }
      return TextSpan(text: string, recognizer: recognizer);
    }

    return null;
  }

  static TextSpan createTextSpansForStatusHTML(
      BuildContext context, String tree) {
    final dom = parseFragment(tree);
    var currentSpan = TextSpan(
        children: dom.children
            .map((element) {
              return createSpansForTree(element, null);
            })
            .whereType<TextSpan>()
            .toList(),
        style: DefaultTextStyle.of(context).style);

    return currentSpan;
  }
}
