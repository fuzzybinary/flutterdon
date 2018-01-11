import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class TootUtilities {

  static TextStyle _getStyleForTag(String tag) {
    switch(tag) {
      case 'a':
        return new TextStyle(color: Colors.deepOrange);
      case 'b':
        return new TextStyle(fontWeight: FontWeight.bold);
    }

    return null;
  }

  static TextSpan createSpansForTree(dom.Node node, dom.Element linkElement) {
    if(node.nodeType == dom.Node.ELEMENT_NODE) {
      final element = node as dom.Element;
      if(element.classes.contains('invisible')) {
        return null;
      }
      if(element.localName == 'br') {
        return new TextSpan(text: '\n');
      }
      if(element.localName == 'a') {
        linkElement = element;
      }
      var currentSpan = new TextSpan(
        children: element.nodes.map((element) {
          return createSpansForTree(element, linkElement);
        }).where((value) => value != null).toList(),
        style: _getStyleForTag(element.localName)
      );
      if(element.localName == 'p' && element.nextElementSibling != null) {
        currentSpan.children.add(new TextSpan(text: '\n\n'));
      }
      return currentSpan;
    } else if(node.nodeType == dom.Node.TEXT_NODE) {
      final textNode = node as dom.Text;
      var string = textNode.data;
      if(textNode.parent.classes.contains('ellipsis')) {
        string += '...';
      }
      TapGestureRecognizer recognizer;
      if(linkElement != null) {
        final link = linkElement.attributes['href'];
        recognizer = new TapGestureRecognizer();
        recognizer.onTap = () {
          print(link);
        };
      }
      return new TextSpan(
        text: string,
        recognizer: recognizer
      );
    }

    return null;
  }

  static TextSpan createTextSpansForTootHTML(BuildContext context, String tree) {
    final dom = parseFragment(tree);
    var currentSpan = new TextSpan(
      children: dom.children.map((element) {
        return createSpansForTree(element, null);
      }).where((value) => value != null).toList(),
      style: DefaultTextStyle.of(context).style
    );
    
    return currentSpan;
  }
}