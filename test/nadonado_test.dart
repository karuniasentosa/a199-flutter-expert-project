import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should not return null when parsing empty string', (){
    final String json = '''
    {"first_air_date" : ""}
    ''';
    final decoded = jsonDecode(json);
    expect(decoded['first_air_date'], '');
  });
}