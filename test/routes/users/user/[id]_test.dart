import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../routes/users/user/[id].dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  const id = '1';
  group('GET /', () {
    test('responds with a 200 and "User $id.".', () async{
      final context = _MockRequestContext();
      const id = '1';
      final response = await route.onRequest(context,id);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(equals('User $id.')),
      );
    });
  });
}
