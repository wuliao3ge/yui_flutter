import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yui_flutter/yui.dart';

void main() {
  const MethodChannel channel = MethodChannel('yui_flutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
//    expect(await YuiFlutter.platformVersion, '42');
  });
}
