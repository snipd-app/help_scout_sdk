import 'package:flutter_test/flutter_test.dart';
import 'package:help_scout_sdk/help_scout_sdk.dart';
import 'package:help_scout_sdk/help_scout_sdk_platform_interface.dart';
import 'package:help_scout_sdk/help_scout_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHelpScoutSdkPlatform
    with MockPlatformInterfaceMixin
    implements HelpScoutSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HelpScoutSdkPlatform initialPlatform = HelpScoutSdkPlatform.instance;

  test('$MethodChannelHelpScoutSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHelpScoutSdk>());
  });

  test('getPlatformVersion', () async {
    HelpScoutSdk helpScoutSdkPlugin = HelpScoutSdk();
    MockHelpScoutSdkPlatform fakePlatform = MockHelpScoutSdkPlatform();
    HelpScoutSdkPlatform.instance = fakePlatform;

    expect(await helpScoutSdkPlugin.getPlatformVersion(), '42');
  });
}
