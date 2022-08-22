import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ao_flutter_oauth2/ao_flutter_oauth2.dart';

void main() {
  const MethodChannel channel = MethodChannel('ao_flutter_oauth2');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AoFlutterOauth2.platformVersion, '42');
  });
}
