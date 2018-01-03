import 'package:test/test.dart';

import '../lib/mastodon/simple_html_parser.dart';

typedef ParserCallback(NodeType, TypeInfo);

void main() {
  test('parses simple tag', () {
    bool called = false;
    parseSimplHtml('<a>', (type, info) {
      expect(type, equals(NodeType.Open));
      expect(info.tag, 'a');
      called = true;
    });
    expect(called, isTrue);
  });
  test('parses text node', () {
    bool called = false;
    parseSimplHtml('simple text', (type, info) {
      expect(type, equals(NodeType.Text));
      expect(info.tag, 'simple text');
      called = true;
    });
    expect(called, isTrue);
  });
  test('parses simple open and close node', () {
    final expectations = <ParserCallback>[
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('a'));
      },
      (type, info) {
        expect(type, equals(NodeType.Close));
        expect(info.tag, equals('a'));
      }
    ];
    int calls = 0;
    parseSimplHtml("<a></a>", (type, info) {
      expectations[calls](type, info);
      calls++;
    });
    expect(calls, equals(expectations.length));
  });
  test('parses simple open and close with text', () {
    final expectations = <ParserCallback>[
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('a'));
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals('simple text'));
      },
      (type, info) {
        expect(type, equals(NodeType.Close));
        expect(info.tag, equals('a'));
      }
    ];
    int calls = 0;
    parseSimplHtml("<a>simple text</a>", (type, info) {
      expectations[calls](type, info);
      calls++;
    });
    expect(calls, equals(expectations.length));
  });
  test('parses simple open tag with attribute', () {
    bool called = false;
    parseSimplHtml('<a attr="value">', (type, info) {
      expect(type, equals(NodeType.Open));
      expect(info.attributes.length, equals(1));
      expect(info.attributes['attr'], equals('value'));
      called = true;
    });
    expect(called, isTrue);
  });
  test('support unquoted attributes', () {
    bool called = false;
    parseSimplHtml('<a attr=value>', (type, info) {
      expect(type, equals(NodeType.Open));
      expect(info.attributes.length, equals(1));
      expect(info.attributes['attr'], equals('value'));
      called = true;
    });
    expect(called, isTrue);
  });
  test('support multiple attribute values', () {
    bool called = false;
    parseSimplHtml('<a attr_1="value" attr_2="second value">', (type, info) {
      expect(type, equals(NodeType.Open));
      expect(info.attributes.length, equals(2));
      expect(info.attributes['attr_1'], equals('value'));
      expect(info.attributes['attr_2'], equals('second value'));
      called = true;
    });
    expect(called, isTrue);
  });
  test('multiple nested tags with attributes', () {
    final expectations = <ParserCallback>[
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('a'));
        expect(info.attributes['attr_1'], equals('value'));
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals('Start text with '));
      },
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('b'));
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals('bold'));
      },
      (type, info) {
        expect(type, equals(NodeType.Close));
        expect(info.tag, equals('b'));
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals(' text.'));
      },
      (type, info) {
        expect(type, equals(NodeType.Close));
        expect(info.tag, equals('a'));
      }
    ];
    int calls = 0;
    parseSimplHtml('<a attr_1="value">Start text with <b>bold</b> text.</a>', (type, info) {
      expectations[calls](type, info);
      calls++;
    });
    expect(calls, equals(expectations.length));
  });
  test('handles self closing nodes', () {
    final expectations = <ParserCallback>[
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('a'));
        expect(info.attributes['attr_1'], equals('value'));
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals('Start text'));
      },
      (type, info) {
        expect(type, equals(NodeType.Open));
        expect(info.tag, equals('br'));
        expect(info.isSelfClosing, isTrue);
      },
      (type, info) {
        expect(type, equals(NodeType.Text));
        expect(info.tag, equals(' a break.'));
      },
      (type, info) {
        expect(type, equals(NodeType.Close));
        expect(info.tag, equals('a'));
      }
    ];
    int calls = 0;
    parseSimplHtml('<a attr_1="value">Start text<br /> a break.</a>', (type, info) {
      expectations[calls](type, info);
      calls++;
    });
    expect(calls, equals(expectations.length));
  });
}