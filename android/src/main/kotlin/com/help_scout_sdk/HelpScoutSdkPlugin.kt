package com.help_scout_sdk

import HelpScoutCallbackApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

/** HelpScoutSdkPlugin */
class HelpScoutSdkPlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var helpScoutApiImpl: HelpScoutApiImpl? = null
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    helpScoutApiImpl = HelpScoutApiImpl(flutterPluginBinding.applicationContext, HelpScoutCallbackApi(flutterPluginBinding.binaryMessenger))
    HelpScoutApi.setUp(flutterPluginBinding.binaryMessenger, helpScoutApiImpl)
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    helpScoutApiImpl?.onDetachedFromActivity()
    helpScoutApiImpl = null
    HelpScoutApi.setUp(binding.binaryMessenger, null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    helpScoutApiImpl?.onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    helpScoutApiImpl?.onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    helpScoutApiImpl?.onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    helpScoutApiImpl?.onDetachedFromActivity()
  }

}
