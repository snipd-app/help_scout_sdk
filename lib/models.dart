import 'dart:ui';

import 'implementation/help_scout_sdk_api.g.dart';

final class BeaconFormPrefill {
  BeaconFormPrefill({
    this.email,
    this.name,
    this.subject,
    this.text,
    this.customFields,
  });

  final String? email;
  final String? name;
  final String? subject;
  final String? text;
  final Map<int, String>? customFields;
}

enum BeaconFocusMode {
  neutral,
  selfService,
  askFirst;
}

enum BeaconRoute { home, ask, askMessage, askChat, answers, previousMessages }

final class BeaconMessagingSettings {
  BeaconMessagingSettings({
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

final class BeaconSettings {
  BeaconSettings(
    this.beaconId, {
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
  final BeaconFocusMode? focusModeOverride;
  final bool? enablePreviousMessages;
  final bool? docsEnabled;
  final bool? chatEnabled;
  final String? beaconTitle;
  final bool? useNavigationBarAppearance;
  final Color? color;
  final Color? tintColorOverride;
  final bool? useLocalTranslationOverrides;
  final BeaconMessagingSettings? messagingSettings;
}

final class HelpScoutUser {
  HelpScoutUser({
    this.email,
    this.name,
    this.company,
    this.jobTitle,
    this.avatar,
    this.attributes,
  });

  final String? email;
  final String? name;
  final String? company;
  final String? jobTitle;
  final Uri? avatar;
  final Map<String, String>? attributes;
}

extension BeaconSettingsConverter on BeaconSettings {
  HelpScoutApiBeaconSettings convertToApi() {
    return HelpScoutApiBeaconSettings(
        beaconId: beaconId,
        color:
            color == null ? null : HelpScoutApiColor(hexCode: color!.toHex()),
        tintColorOverride: tintColorOverride == null
            ? null
            : HelpScoutApiColor(hexCode: tintColorOverride!.toHex()),
        beaconTitle: beaconTitle,
        chatEnabled: chatEnabled,
        docsEnabled: docsEnabled,
        enablePreviousMessages: enablePreviousMessages,
        focusModeOverride: switch (focusModeOverride) {
          null => null,
          BeaconFocusMode.neutral => HelpScoutApiBeaconFocusMode.neutral,
          BeaconFocusMode.askFirst => HelpScoutApiBeaconFocusMode.askFirst,
          BeaconFocusMode.selfService =>
            HelpScoutApiBeaconFocusMode.selfService,
        },
        messagingEnabled: messagingEnabled,
        useLocalTranslationOverrides: useLocalTranslationOverrides,
        useNavigationBarAppearance: useNavigationBarAppearance,
        messagingSettings: messagingSettings == null
            ? null
            : HelpScoutApiMessagingSettings(
                contactFormAllowAttachments:
                    messagingSettings!.contactFormAllowAttachments,
                contactFormCustomFieldsEnabled:
                    messagingSettings!.contactFormCustomFieldsEnabled,
                contactFormShowNameField:
                    messagingSettings!.contactFormShowNameField,
                contactFormShowSubjectField:
                    messagingSettings!.contactFormShowSubjectField,
                showPrefilledCustomFields:
                    messagingSettings!.showPrefilledCustomFields));
  }
}

extension on Color {
  String toHex() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
