//
//  HelpScoutApi.swift
//  help_scout_sdk
//
//  Created by Mikel Corcuera on 23.02.2024.
//

import Foundation
import Beacon
import Flutter

extension FlutterError: Error {}

class HelpScoutApiImpl : NSObject, HelpScoutApi  {
  init(callbackApi: HelpScoutCallbackApi) {
    self.callbackApi = callbackApi
  }
  
  private var callbackApi: HelpScoutCallbackApi
  private var formPrefills: [String: HelpScoutApiFormPrefill] = [:]
  private var userSessionAttributes: [String: String] = [:]

  
  func openBeacon(beaconSettings: HelpScoutApiBeaconSettings) throws {
    let settings = convertBeaconSettings(beaconSettings)
    HSBeacon.open(settings)
  }
  
  func dismissBeacon() throws {
    HSBeacon.dismiss()
  }
  
  func reset() throws {
    HSBeacon.reset()
  }
  
  func navigate(settings: HelpScoutApiBeaconSettings, route: HelpScoutApiBeaconRoute) throws {
    let settings = convertBeaconSettings(settings)
    let route = switch route {
    case .answers: BeaconRoute.answers
    case .home:
      BeaconRoute.home
    case .ask:
      BeaconRoute.ask
    case .askMessage:
      BeaconRoute.askMessage
    case .askChat:
      BeaconRoute.askChat
    case .previousMessages:
      BeaconRoute.previousMessages
    }
    HSBeacon.navigate(route, settings: settings)
  }
  
  func search(settings: HelpScoutApiBeaconSettings, query: String) throws {
    let settings = convertBeaconSettings(settings)
    HSBeacon.search(query, beaconSettings: settings)
    
  }
  
  func openArticle(settings: HelpScoutApiBeaconSettings, articleId: String) throws {
    let settings = convertBeaconSettings(settings)
    HSBeacon.openArticle(articleId, beaconSettings: settings)
  }
  
  func prefillForm(beaconId: String, prefillData: HelpScoutApiFormPrefill) throws {
    formPrefills[beaconId] = prefillData
  }
  
  func resetAllFormPrefills() throws {
    HSBeacon.reset()
    formPrefills = [:]
  }
  
  func identify(user: HelpScoutApiUser) throws {
    let beaconUser = HSBeaconUser()
    beaconUser.email = user.email
    beaconUser.name = user.name
    beaconUser.company = user.company
    beaconUser.jobTitle = user.jobTitle
    if let avatar = user.avatar {
      beaconUser.avatar = URL(string: avatar)
    }
    if let attributes = user.attributes {
      for (key, value) in attributes {
        if let key = key, let value = value {
          beaconUser.addAttribute(withKey: key, value: value)
        }
      }
    }
    
    HSBeacon.identify(beaconUser)
  }
  
  func setSessionAttributes(attributes: [String? : String?]) throws {
    for (key, value) in attributes {
      if let key = key, let value = value {
        userSessionAttributes[key] = value;
      }
    }
  }
  
  
  
  func logout() throws {
    HSBeacon.logout()
  }
  
  private func convertBeaconSettings(_ beaconSettings: HelpScoutApiBeaconSettings) -> HSBeaconSettings {
    let settings = HSBeaconSettings(beaconId: beaconSettings.beaconId)
    
    if let messagingEnabled = beaconSettings.messagingEnabled {
      settings.messagingEnabled = messagingEnabled
    }
    
    if let focusModeOverride = beaconSettings.focusModeOverride {
      settings.focusModeOverride = switch(focusModeOverride) {
      case .neutral:
        HSBeaconFocusMode.neutral
      case .selfService:
        HSBeaconFocusMode.selfService
      case .askFirst:
        HSBeaconFocusMode.askFirst
      }
    }
    
    if let enablePreviousMessages = beaconSettings.enablePreviousMessages {
      settings.enablePreviousMessages = enablePreviousMessages
    }
    
    if let docsEnabled = beaconSettings.docsEnabled {
      settings.docsEnabled = docsEnabled
    }
    
    if let chatEnabled = beaconSettings.chatEnabled {
      settings.chatEnabled = chatEnabled
    }
    
    if let beaconTitle = beaconSettings.beaconTitle {
      settings.beaconTitle = beaconTitle
    }
    
    if let useNavigationBarAppearance = beaconSettings.useNavigationBarAppearance {
      settings.useNavigationBarAppearance = useNavigationBarAppearance
    }
    
    if let color = beaconSettings.color, let uiColor = UIColor(hex: color.hexCode) {
      settings.color = uiColor
    }
    
    if let tintColor = beaconSettings.tintColorOverride, let uiTintColor = UIColor(hex: tintColor.hexCode) {
      settings.tintColorOverride = uiTintColor
    }
    
    if let useLocalTranslationOverrides = beaconSettings.useLocalTranslationOverrides {
      settings.useLocalTranslationOverrides = useLocalTranslationOverrides
    }
    
    if let messagingSettings = beaconSettings.messagingSettings {
      if let contactFormCustomFieldsEnabled = messagingSettings.contactFormCustomFieldsEnabled {
        settings.messagingSettings.contactFormCustomFieldsEnabled = contactFormCustomFieldsEnabled
      }
      
      if let contactFormShowNameField = messagingSettings.contactFormShowNameField {
        settings.messagingSettings.contactFormShowNameField = contactFormShowNameField
      }
      
      if let contactFormShowSubjectField = messagingSettings.contactFormShowSubjectField {
        settings.messagingSettings.contactFormShowSubjectField = contactFormShowSubjectField
      }
      
      if let contactFormAllowAttachments = messagingSettings.contactFormAllowAttachments {
        settings.messagingSettings.contactFormAllowAttachments = contactFormAllowAttachments
      }
      
      if let showPrefilledCustomFields = messagingSettings.showPrefilledCustomFields {
        settings.messagingSettings.showPrefilledCustomFields = showPrefilledCustomFields
      }
    }
    
    settings.delegate = self
    return settings
  }
}

extension HelpScoutApiImpl : HSBeaconDelegate {
  func prefill(_ form: HSBeaconContactForm) {
    let beaconId = form.beaconID
    if let prefill = formPrefills[beaconId] {
      form.name = prefill.name
      if let email = prefill.email {
        form.email = email
      }
      form.subject = prefill.subject
      form.text = prefill.text
      
      if let customFields = prefill.customFields {
        for (id, value) in customFields {
          if let id = id, let value = value {
            form.addCustomFieldValue(value, forId: Int32(id))
          }
        }
      }
    }
  }
  
  func sessionAttributes() -> [String : String] {
    return userSessionAttributes
  }
  
  func onBeaconOpen(_ beaconSettings: HSBeaconSettings) {
    callbackApi.onBeaconOpen(beaconId: beaconSettings.beaconId, completion: {_ in })
  }
  
  func onBeaconInitialOpen(_ beaconSettings: HSBeaconSettings) {
      callbackApi.onBeaconInitialOpen(beaconId: beaconSettings.beaconId, completion: {_ in })
  }
  
  func onBeaconClose(_ beaconSettings: HSBeaconSettings) {
    callbackApi.onBeaconClose(beaconId: beaconSettings.beaconId, completion: {_ in })
  }
  
  func onBeaconInitialClose(_ beaconSettings: HSBeaconSettings) {
    callbackApi.onBeaconInitialClose(beaconId: beaconSettings.beaconId, completion: {_ in })
  }
}

extension UIColor {
  public convenience init?(hex: String) {
    let r, g, b, a: CGFloat
    print("Converting color \(hex)")
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      if hexColor.count != 6 && hexColor.count != 8 {
        return nil
      }
      var hexNumber: UInt64 = 0
      if Scanner(string: hexColor).scanHexInt64(&hexNumber) {
        if hexColor.count == 8 {
          a = CGFloat(hexNumber & 0x000000ff) / 255
          hexNumber = hexNumber >> 16
        } else {
          a = 1
        }
        
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
        
        self.init(red: r, green: g, blue: b, alpha: a)
        return
      }
      
    }
    
    return nil
  }
}

