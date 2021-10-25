import 'dart:io';

import 'package:music_app/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('images assets test', () {
    expect(true, File(Images.star).existsSync());
  });
}
