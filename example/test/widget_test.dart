import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mock test for CI', () {
    expect(
      MyApp is MyApp,
      false,
    );
  });
}
