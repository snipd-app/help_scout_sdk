import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'help_scout_sdk_method_channel.dart';

abstract class HelpScoutSdkPlatform extends PlatformInterface {
  /// Constructs a HelpScoutSdkPlatform.
  HelpScoutSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static HelpScoutSdkPlatform _instance = MethodChannelHelpScoutSdk();

  /// The default instance of [HelpScoutSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelHelpScoutSdk].
  static HelpScoutSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HelpScoutSdkPlatform] when
  /// they register themselves.
  static set instance(HelpScoutSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
