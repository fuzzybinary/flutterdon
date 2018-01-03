import 'package:meta/meta.dart';

enum NodeType {
  Open,
  Close,
  Text
}

@immutable
class TagInfo {
  final String tag;
  final Map<String, String> attributes;
  final bool isSelfClosing;

  const TagInfo(this.tag, [this.attributes, this.isSelfClosing = false]);
}

bool _isNotChar(String text, int index, List<String> chars) {
  if(index >= text.length)
    return false;
  
  for(final c in chars) {
    if(c == text[index]) {
      return false;
    }
  }
  return true;
}

bool _isChar(String text, int index, List<String> chars) {
  if(index >= text.length) {
    return false;
  }

  for(final c in chars) {
    if(c == text[index]) {
      return true;
    }
  }

  return false;
}

void parseSimplHtml(String text, Function(NodeType, TagInfo) callback) {
  var currentIndex = 0;
  while(currentIndex < text.length) {
    StringBuffer textBuffer = new StringBuffer();
    while(_isNotChar(text, currentIndex, ['<'])) {
      textBuffer.write(text[currentIndex]);
      currentIndex++;
    }

    if(textBuffer.length > 0) {
      callback(NodeType.Text, new TagInfo(textBuffer.toString()));
    }

    if(_isChar(text, currentIndex, ['<'])) {
      currentIndex++;
      bool isCloseTag = false;
      if(text[currentIndex] == '/') {
        currentIndex++;
        isCloseTag = true;
      }

      final tag = new StringBuffer();
      while(_isNotChar(text, currentIndex, [' ', '>']))  {
        tag.write(text[currentIndex]);
        currentIndex++;
      }

      if(_isChar(text, currentIndex, ['>',])) {
        callback(isCloseTag ? NodeType.Close : NodeType.Open, new TagInfo(tag.toString()));
        currentIndex++;
      } else {
        currentIndex++;

        bool isSelfClosing = false;
        if(_isChar(text, currentIndex, ['/'])) {
          currentIndex++;
          isSelfClosing = true;
        }
        final attributes = new Map<String, String>();
        while(_isNotChar(text, currentIndex, ['>', '/'])) {
          if(_isChar(text, currentIndex, ['/'])) {
            isSelfClosing = true;
            currentIndex++;
            while(_isNotChar(text, currentIndex, ['>'])) {
              currentIndex++;
            }
            // Don't scan any more attributes
            break;
          }
          final attributeBuilder = new StringBuffer();
          while(_isNotChar(text, currentIndex, [' ', '='])) {
            attributeBuilder.write(text[currentIndex]);
            currentIndex++;
          }
          while(_isChar(text, currentIndex, [' '])) {
            currentIndex++;
          }
          if(_isChar(text, currentIndex, ['='])) {
            currentIndex++;
            final valueBuilder = new StringBuffer();
            if(_isChar(text, currentIndex, ['"'])) {
              currentIndex++;
              while(_isNotChar(text, currentIndex, ['"'])) {
                valueBuilder.write(text[currentIndex]);
                currentIndex++;
              }
              currentIndex++;
            } else {
              while(_isNotChar(text, currentIndex, [' ', '>'])) {
                valueBuilder.write(text[currentIndex]);
                currentIndex++;
              }
            }
            
            attributes[attributeBuilder.toString()] = valueBuilder.toString();
          }
          while(_isChar(text, currentIndex, [' '])) {
            currentIndex++;
          }
        }
        currentIndex++; // eat >
        callback(NodeType.Open, new TagInfo(tag.toString(), attributes, isSelfClosing));
      }
    }
  }
}
