import Flutter
import Beacon
import UIKit

public class HelpScoutSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger : FlutterBinaryMessenger = registrar.messenger()
    let callbackApi = HelpScoutCallbackApi.init(binaryMessenger: messenger);
    let api = HelpScoutApiImpl.init(callbackApi: callbackApi)
    HelpScoutApiSetup.setUp(binaryMessenger: messenger, api: api);
  }
}
