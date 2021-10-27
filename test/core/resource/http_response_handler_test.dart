import 'dart:html';

import 'package:music_app/core/resource/resource.dart';
import 'package:test/test.dart';

main() {
  group('Recoures Classes Testing', () {
    test('Success Recouce Should Hold success Data', () {
      SuccessResource successResource = SuccessResource(0);

      expect(successResource.data, 0);
    });
    test('Failed resource Should Hold error Data and message', () {
      FailedResource failedResource = const FailedResource(
          HttpStatus.internalServerError,
          message: 'Internal Server Error');

      expect(failedResource.data, HttpStatus.internalServerError);
      expect(failedResource.message, 'Internal Server Error');
    });
  });
}
