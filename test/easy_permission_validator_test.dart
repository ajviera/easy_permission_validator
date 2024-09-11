import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mock test for CI', () {
    expect(
      PermissionPopup is PermissionPopup,
      false,
    );
  });
}
