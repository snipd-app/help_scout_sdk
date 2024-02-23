import 'package:pigeon/pigeon.dart';

enum HelpScoutApiBeaconRoute {
  home,
  ask,
  askMessage,
  askChat,
  answers,
  previousMessages
}

class HelpScoutApiUser {
  HelpScoutApiUser({
    required this.email,
    required this.name,
    required this.company,
    required this.jobTitle,
    required this.avatar,
    required this.attributes,
  });

  final String? email;
  final String? name;
  final String? company;
  final String? jobTitle;
  final String? avatar;
  final Map<String?, String?>? attributes;
}

class HelpScoutApiFormPrefill {
  HelpScoutApiFormPrefill({
    required this.email,
    required this.name,
    required this.subject,
    required this.text,
    required this.customFields,
  });

  final String? email;
  final String? name;
  final String? subject;
  final String? text;
  final Map<int?, String?>? customFields;
}

class HelpScoutApiColor {
  HelpScoutApiColor(this.hexCode);

  final String hexCode;
}

class HelpScoutApiMessagingSettings {
  HelpScoutApiMessagingSettings({
    this.contactFormCustomFieldsEnabled,
    this.contactFormShowNameField,
    this.contactFormShowSubjectField,
    this.contactFormAllowAttachments,
    this.showPrefilledCustomFields,
  });

  final bool? contactFormCustomFieldsEnabled;
  final bool? contactFormShowNameField;
  final bool? contactFormShowSubjectField;
  final bool? contactFormAllowAttachments;
  final bool? showPrefilledCustomFields;
}

enum HelpScoutApiBeaconFocusMode {
  neutral,
  selfService,
  askFirst;
}

class HelpScoutApiBeaconSettings {
  HelpScoutApiBeaconSettings({
    required this.beaconId,
    this.messagingEnabled,
    this.focusModeOverride,
    this.enablePreviousMessages,
    this.docsEnabled,
    this.chatEnabled,
    this.beaconTitle,
    this.useNavigationBarAppearance,
    this.color,
    this.tintColorOverride,
    this.useLocalTranslationOverrides,
    this.messagingSettings,
  });

  final String beaconId;
  final bool? messagingEnabled;
  final HelpScoutApiBeaconFocusMode? focusModeOverride;
  final bool? enablePreviousMessages;
  final bool? docsEnabled;
  final bool? chatEnabled;
  final String? beaconTitle;
  final bool? useNavigationBarAppearance;
  final HelpScoutApiColor? color;
  final HelpScoutApiColor? tintColorOverride;
  final bool? useLocalTranslationOverrides;
  final HelpScoutApiMessagingSettings? messagingSettings;
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/implementation/help_scout_sdk_api.g.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com.example.help_scout_sdk/HelpScoutApi.g.kt',
  swiftOut: 'ios/Classes/HelpScoutApi.g.swift',
))
@HostApi()
abstract class HelpScoutApi {
  void openBeacon(HelpScoutApiBeaconSettings beaconSettings);

  void dismissBeacon();

  void identify(HelpScoutApiUser user);

  void setSessionAttributes(Map<String?, String?> attributes);

  void prefillForm(String beaconId, HelpScoutApiFormPrefill prefillData);

  void resetAllFormPrefills();

  void navigate(
      HelpScoutApiBeaconSettings settings, HelpScoutApiBeaconRoute route);

  void search(HelpScoutApiBeaconSettings settings, String query);

  void openArticle(HelpScoutApiBeaconSettings settings, String articleId);

  void logout();

  void reset();
}

@FlutterApi()
abstract class HelpScoutCallbackApi {
  void onBeaconInitialOpen(String beaconId);
  void onBeaconOpen(String beaconId);
  void onBeaconInitialClose(String beaconId);
  void onBeaconClose(String beaconId);
}
