import 'dart:ui';

import 'package:help_scout_sdk/models.dart';

import 'implementation/help_scout_sdk.dart';

export 'package:help_scout_sdk/models.dart' hide BeaconSettingsConverter;

/// [HelpScoutSdk] implements the Help Scout Mobile SDK
/// documented here: https://developer.helpscout.com/beacon-2/
abstract interface class HelpScoutSdk {
  static HelpScoutSdk? _instance;

  static HelpScoutSdk get instance {
    _instance ??= HelpScoutSdkImpl();
    return _instance!;
  }

  Beacon createBeacon(BeaconSettings settings);
}

abstract interface class Beacon {
  BeaconSettings get settings;

  String get id;

  Future<void> open();
  Future<void> dismiss();
  Future<void> navigate(BeaconRoute route);
  Future<void> search(String query);
  Future<void> identify(HelpScoutUser user);
  Future<void> setSessionAttributes(Map<String, String> attributes);
  Future<void> logout();
  Future<void> reset();

  Future<void> openArticle(String articleId);

  Future<void> prefillForm(BeaconFormPrefill prefill);
  Future<void> clearForm();

  void addOnBeaconCloseListener(VoidCallback listener);
  void removeOnBeaconCloseListener(VoidCallback listener);
  void addOnBeaconOpenListener(VoidCallback listener);
  void removeOnBeaconOpenListener(VoidCallback listener);
}
