
import 'help_scout_sdk_platform_interface.dart';

class HelpScoutSdk {
  Future<String?> getPlatformVersion() {
    return HelpScoutSdkPlatform.instance.getPlatformVersion();
  }
}
