import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'help_scout_sdk_platform_interface.dart';

/// An implementation of [HelpScoutSdkPlatform] that uses method channels.
class MethodChannelHelpScoutSdk extends HelpScoutSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('help_scout_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
