// Autogenerated from Pigeon (v17.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> FlutterError {
  return FlutterError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum HelpScoutApiBeaconRoute: Int {
  case home = 0
  case ask = 1
  case askMessage = 2
  case askChat = 3
  case answers = 4
  case previousMessages = 5
}

enum HelpScoutApiBeaconFocusMode: Int {
  case neutral = 0
  case selfService = 1
  case askFirst = 2
}

/// Generated class from Pigeon that represents data sent in messages.
struct HelpScoutApiUser {
  var email: String? = nil
  var name: String? = nil
  var company: String? = nil
  var jobTitle: String? = nil
  var avatar: String? = nil
  var attributes: [String?: String?]? = nil

  static func fromList(_ list: [Any?]) -> HelpScoutApiUser? {
    let email: String? = nilOrValue(list[0])
    let name: String? = nilOrValue(list[1])
    let company: String? = nilOrValue(list[2])
    let jobTitle: String? = nilOrValue(list[3])
    let avatar: String? = nilOrValue(list[4])
    let attributes: [String?: String?]? = nilOrValue(list[5])

    return HelpScoutApiUser(
      email: email,
      name: name,
      company: company,
      jobTitle: jobTitle,
      avatar: avatar,
      attributes: attributes
    )
  }
  func toList() -> [Any?] {
    return [
      email,
      name,
      company,
      jobTitle,
      avatar,
      attributes,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct HelpScoutApiFormPrefill {
  var email: String? = nil
  var name: String? = nil
  var subject: String? = nil
  var text: String? = nil
  var customFields: [Int64?: String?]? = nil

  static func fromList(_ list: [Any?]) -> HelpScoutApiFormPrefill? {
    let email: String? = nilOrValue(list[0])
    let name: String? = nilOrValue(list[1])
    let subject: String? = nilOrValue(list[2])
    let text: String? = nilOrValue(list[3])
    let customFields: [Int64?: String?]? = nilOrValue(list[4])

    return HelpScoutApiFormPrefill(
      email: email,
      name: name,
      subject: subject,
      text: text,
      customFields: customFields
    )
  }
  func toList() -> [Any?] {
    return [
      email,
      name,
      subject,
      text,
      customFields,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct HelpScoutApiColor {
  var hexCode: String

  static func fromList(_ list: [Any?]) -> HelpScoutApiColor? {
    let hexCode = list[0] as! String

    return HelpScoutApiColor(
      hexCode: hexCode
    )
  }
  func toList() -> [Any?] {
    return [
      hexCode
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct HelpScoutApiMessagingSettings {
  var contactFormCustomFieldsEnabled: Bool? = nil
  var contactFormShowNameField: Bool? = nil
  var contactFormShowSubjectField: Bool? = nil
  var contactFormAllowAttachments: Bool? = nil
  var showPrefilledCustomFields: Bool? = nil

  static func fromList(_ list: [Any?]) -> HelpScoutApiMessagingSettings? {
    let contactFormCustomFieldsEnabled: Bool? = nilOrValue(list[0])
    let contactFormShowNameField: Bool? = nilOrValue(list[1])
    let contactFormShowSubjectField: Bool? = nilOrValue(list[2])
    let contactFormAllowAttachments: Bool? = nilOrValue(list[3])
    let showPrefilledCustomFields: Bool? = nilOrValue(list[4])

    return HelpScoutApiMessagingSettings(
      contactFormCustomFieldsEnabled: contactFormCustomFieldsEnabled,
      contactFormShowNameField: contactFormShowNameField,
      contactFormShowSubjectField: contactFormShowSubjectField,
      contactFormAllowAttachments: contactFormAllowAttachments,
      showPrefilledCustomFields: showPrefilledCustomFields
    )
  }
  func toList() -> [Any?] {
    return [
      contactFormCustomFieldsEnabled,
      contactFormShowNameField,
      contactFormShowSubjectField,
      contactFormAllowAttachments,
      showPrefilledCustomFields,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct HelpScoutApiBeaconSettings {
  var beaconId: String
  var messagingEnabled: Bool? = nil
  var focusModeOverride: HelpScoutApiBeaconFocusMode? = nil
  var enablePreviousMessages: Bool? = nil
  var docsEnabled: Bool? = nil
  var chatEnabled: Bool? = nil
  var beaconTitle: String? = nil
  var useNavigationBarAppearance: Bool? = nil
  var color: HelpScoutApiColor? = nil
  var tintColorOverride: HelpScoutApiColor? = nil
  var useLocalTranslationOverrides: Bool? = nil
  var messagingSettings: HelpScoutApiMessagingSettings? = nil

  static func fromList(_ list: [Any?]) -> HelpScoutApiBeaconSettings? {
    let beaconId = list[0] as! String
    let messagingEnabled: Bool? = nilOrValue(list[1])
    var focusModeOverride: HelpScoutApiBeaconFocusMode? = nil
    let focusModeOverrideEnumVal: Int? = nilOrValue(list[2])
    if let focusModeOverrideRawValue = focusModeOverrideEnumVal {
      focusModeOverride = HelpScoutApiBeaconFocusMode(rawValue: focusModeOverrideRawValue)!
    }
    let enablePreviousMessages: Bool? = nilOrValue(list[3])
    let docsEnabled: Bool? = nilOrValue(list[4])
    let chatEnabled: Bool? = nilOrValue(list[5])
    let beaconTitle: String? = nilOrValue(list[6])
    let useNavigationBarAppearance: Bool? = nilOrValue(list[7])
    var color: HelpScoutApiColor? = nil
    if let colorList: [Any?] = nilOrValue(list[8]) {
      color = HelpScoutApiColor.fromList(colorList)
    }
    var tintColorOverride: HelpScoutApiColor? = nil
    if let tintColorOverrideList: [Any?] = nilOrValue(list[9]) {
      tintColorOverride = HelpScoutApiColor.fromList(tintColorOverrideList)
    }
    let useLocalTranslationOverrides: Bool? = nilOrValue(list[10])
    var messagingSettings: HelpScoutApiMessagingSettings? = nil
    if let messagingSettingsList: [Any?] = nilOrValue(list[11]) {
      messagingSettings = HelpScoutApiMessagingSettings.fromList(messagingSettingsList)
    }

    return HelpScoutApiBeaconSettings(
      beaconId: beaconId,
      messagingEnabled: messagingEnabled,
      focusModeOverride: focusModeOverride,
      enablePreviousMessages: enablePreviousMessages,
      docsEnabled: docsEnabled,
      chatEnabled: chatEnabled,
      beaconTitle: beaconTitle,
      useNavigationBarAppearance: useNavigationBarAppearance,
      color: color,
      tintColorOverride: tintColorOverride,
      useLocalTranslationOverrides: useLocalTranslationOverrides,
      messagingSettings: messagingSettings
    )
  }
  func toList() -> [Any?] {
    return [
      beaconId,
      messagingEnabled,
      focusModeOverride?.rawValue,
      enablePreviousMessages,
      docsEnabled,
      chatEnabled,
      beaconTitle,
      useNavigationBarAppearance,
      color?.toList(),
      tintColorOverride?.toList(),
      useLocalTranslationOverrides,
      messagingSettings?.toList(),
    ]
  }
}
private class HelpScoutApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return HelpScoutApiBeaconSettings.fromList(self.readValue() as! [Any?])
    case 129:
      return HelpScoutApiColor.fromList(self.readValue() as! [Any?])
    case 130:
      return HelpScoutApiFormPrefill.fromList(self.readValue() as! [Any?])
    case 131:
      return HelpScoutApiMessagingSettings.fromList(self.readValue() as! [Any?])
    case 132:
      return HelpScoutApiUser.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class HelpScoutApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? HelpScoutApiBeaconSettings {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? HelpScoutApiColor {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? HelpScoutApiFormPrefill {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? HelpScoutApiMessagingSettings {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? HelpScoutApiUser {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class HelpScoutApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return HelpScoutApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return HelpScoutApiCodecWriter(data: data)
  }
}

class HelpScoutApiCodec: FlutterStandardMessageCodec {
  static let shared = HelpScoutApiCodec(readerWriter: HelpScoutApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol HelpScoutApi {
  func openBeacon(beaconSettings: HelpScoutApiBeaconSettings) throws
  func navigate(settings: HelpScoutApiBeaconSettings, route: HelpScoutApiBeaconRoute) throws
  func search(settings: HelpScoutApiBeaconSettings, query: String) throws
  func openArticle(settings: HelpScoutApiBeaconSettings, articleId: String) throws
  func dismissBeacon() throws
  func identify(beaconId: String, user: HelpScoutApiUser) throws
  func setSessionAttributes(beaconId: String, attributes: [String?: String?]) throws
  func prefillForm(beaconId: String, prefillData: HelpScoutApiFormPrefill) throws
  func resetFormPrefill(beaconId: String) throws
  func logout(beaconId: String) throws
  func reset(beaconId: String) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class HelpScoutApiSetup {
  /// The codec used by HelpScoutApi.
  static var codec: FlutterStandardMessageCodec { HelpScoutApiCodec.shared }
  /// Sets up an instance of `HelpScoutApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: HelpScoutApi?) {
    let openBeaconChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.openBeacon", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      openBeaconChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconSettingsArg = args[0] as! HelpScoutApiBeaconSettings
        do {
          try api.openBeacon(beaconSettings: beaconSettingsArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      openBeaconChannel.setMessageHandler(nil)
    }
    let navigateChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.navigate", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      navigateChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let settingsArg = args[0] as! HelpScoutApiBeaconSettings
        let routeArg = HelpScoutApiBeaconRoute(rawValue: args[1] as! Int)!
        do {
          try api.navigate(settings: settingsArg, route: routeArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      navigateChannel.setMessageHandler(nil)
    }
    let searchChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.search", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      searchChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let settingsArg = args[0] as! HelpScoutApiBeaconSettings
        let queryArg = args[1] as! String
        do {
          try api.search(settings: settingsArg, query: queryArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      searchChannel.setMessageHandler(nil)
    }
    let openArticleChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.openArticle", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      openArticleChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let settingsArg = args[0] as! HelpScoutApiBeaconSettings
        let articleIdArg = args[1] as! String
        do {
          try api.openArticle(settings: settingsArg, articleId: articleIdArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      openArticleChannel.setMessageHandler(nil)
    }
    let dismissBeaconChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.dismissBeacon", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      dismissBeaconChannel.setMessageHandler { _, reply in
        do {
          try api.dismissBeacon()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      dismissBeaconChannel.setMessageHandler(nil)
    }
    let identifyChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.identify", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      identifyChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        let userArg = args[1] as! HelpScoutApiUser
        do {
          try api.identify(beaconId: beaconIdArg, user: userArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      identifyChannel.setMessageHandler(nil)
    }
    let setSessionAttributesChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.setSessionAttributes", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setSessionAttributesChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        let attributesArg = args[1] as! [String?: String?]
        do {
          try api.setSessionAttributes(beaconId: beaconIdArg, attributes: attributesArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setSessionAttributesChannel.setMessageHandler(nil)
    }
    let prefillFormChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.prefillForm", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      prefillFormChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        let prefillDataArg = args[1] as! HelpScoutApiFormPrefill
        do {
          try api.prefillForm(beaconId: beaconIdArg, prefillData: prefillDataArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      prefillFormChannel.setMessageHandler(nil)
    }
    let resetFormPrefillChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.resetFormPrefill", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      resetFormPrefillChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        do {
          try api.resetFormPrefill(beaconId: beaconIdArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      resetFormPrefillChannel.setMessageHandler(nil)
    }
    let logoutChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.logout", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      logoutChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        do {
          try api.logout(beaconId: beaconIdArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      logoutChannel.setMessageHandler(nil)
    }
    let resetChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.help_scout_sdk.HelpScoutApi.reset", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      resetChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let beaconIdArg = args[0] as! String
        do {
          try api.reset(beaconId: beaconIdArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      resetChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol HelpScoutCallbackApiProtocol {
  func onBeaconOpen(beaconId beaconIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onBeaconClose(beaconId beaconIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class HelpScoutCallbackApi: HelpScoutCallbackApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger) {
    self.binaryMessenger = binaryMessenger
  }
  func onBeaconOpen(beaconId beaconIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.help_scout_sdk.HelpScoutCallbackApi.onBeaconOpen"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage([beaconIdArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onBeaconClose(beaconId beaconIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.help_scout_sdk.HelpScoutCallbackApi.onBeaconClose"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage([beaconIdArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
