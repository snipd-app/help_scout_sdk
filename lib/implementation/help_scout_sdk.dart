import 'dart:ui';

import 'package:help_scout_sdk/help_scout_sdk.dart';
import 'package:help_scout_sdk/implementation/help_scout_sdk_api.g.dart';
import 'package:help_scout_sdk/models.dart';

final class HelpScoutSdkImpl implements HelpScoutSdk, HelpScoutCallbackApi {
  HelpScoutSdkImpl() {
    HelpScoutCallbackApi.setup(this);
  }

  final _nativeApi = HelpScoutApi();

  @override
  Beacon createBeacon(BeaconSettings settings) {
    return _BeaconImpl._(settings: settings, sdk: this);
  }

  @override
  void onBeaconClose(String beaconId) {
    for (final listener in _onBeaconCloseListeners[beaconId] ?? []) {
      listener();
    }
  }

  @override
  void onBeaconOpen(String beaconId) {
    for (final listener in _onBeaconOpenListeners[beaconId] ?? []) {
      listener();
    }
  }

  final Map<String, List<VoidCallback>> _onBeaconCloseListeners = {};
  final Map<String, List<VoidCallback>> _onBeaconOpenListeners = {};

  void addOnBeaconCloseListener(String beaconId, VoidCallback listener) {
    _onBeaconCloseListeners[beaconId] ??= [];
    _onBeaconCloseListeners[beaconId]!.add(listener);
  }

  void removeOnBeaconCloseListener(String beaconId, VoidCallback listener) {
    _onBeaconCloseListeners[beaconId] ??= [];
    _onBeaconCloseListeners[beaconId]!.remove(listener);
  }

  void addOnBeaconOpenListener(String beaconId, VoidCallback listener) {
    _onBeaconOpenListeners[beaconId] ??= [];
    _onBeaconOpenListeners[beaconId]!.add(listener);
  }

  void removeOnBeaconOpenListener(String beaconId, VoidCallback listener) {
    _onBeaconOpenListeners[beaconId] ??= [];
    _onBeaconOpenListeners[beaconId]!.remove(listener);
  }
}

final class _BeaconImpl implements Beacon {
  _BeaconImpl._({
    required this.settings,
    required HelpScoutSdkImpl sdk,
  }) : _sdk = sdk;

  @override
  final BeaconSettings settings;

  @override
  String get id => settings.beaconId;

  final HelpScoutSdkImpl _sdk;
  HelpScoutApi get _nativeApi => _sdk._nativeApi;
  late final _beaconApiSettings = settings.convertToApi();

  @override
  Future<void> open() async {
    await _nativeApi.openBeacon(_beaconApiSettings);
  }

  @override
  Future<void> dismiss() async {
    await _nativeApi.dismissBeacon();
  }

  @override
  Future<void> identify(HelpScoutUser user) async {
    await _nativeApi.identify(
        id,
        HelpScoutApiUser(
          name: user.name,
          avatar: user.avatar?.toString(),
          company: user.company,
          email: user.email,
          jobTitle: user.jobTitle,
          attributes: user.attributes,
        ));
  }

  @override
  Future<void> logout() async {
    await _nativeApi.logout(id);
  }

  @override
  Future<void> reset() async {
    await _nativeApi.reset(id);
  }

  @override
  Future<void> setSessionAttributes(Map<String, String> attributes) async {
    await _nativeApi.setSessionAttributes(id, attributes);
  }

  @override
  Future<void> navigate(BeaconRoute route) async {
    await _nativeApi.navigate(
        _beaconApiSettings,
        switch (route) {
          BeaconRoute.answers => HelpScoutApiBeaconRoute.answers,
          BeaconRoute.ask => HelpScoutApiBeaconRoute.ask,
          BeaconRoute.askChat => HelpScoutApiBeaconRoute.askChat,
          BeaconRoute.askMessage => HelpScoutApiBeaconRoute.askMessage,
          BeaconRoute.home => HelpScoutApiBeaconRoute.home,
          BeaconRoute.previousMessages =>
            HelpScoutApiBeaconRoute.previousMessages,
        });
  }

  @override
  Future<void> search(String query) async {
    await _nativeApi.search(_beaconApiSettings, query);
  }

  @override
  Future<void> openArticle(String articleId) async {
    await _nativeApi.openArticle(_beaconApiSettings, articleId);
  }

  @override
  Future<void> prefillForm(BeaconFormPrefill prefill) async {
    await _nativeApi.prefillForm(
      id,
      HelpScoutApiFormPrefill(
        name: prefill.name,
        email: prefill.email,
        subject: prefill.subject,
        text: prefill.text,
        customFields: prefill.customFields,
      ),
    );
  }

  @override
  Future<void> clearForm() async {
    await _nativeApi.resetFormPrefill(id);
  }

  @override
  void addOnBeaconCloseListener(VoidCallback listener) =>
      _sdk.addOnBeaconCloseListener(id, listener);
  @override
  void removeOnBeaconCloseListener(VoidCallback listener) =>
      _sdk.removeOnBeaconCloseListener(id, listener);
  @override
  void addOnBeaconOpenListener(VoidCallback listener) =>
      _sdk.addOnBeaconOpenListener(id, listener);
  @override
  void removeOnBeaconOpenListener(VoidCallback listener) =>
      _sdk.removeOnBeaconOpenListener(id, listener);
}
