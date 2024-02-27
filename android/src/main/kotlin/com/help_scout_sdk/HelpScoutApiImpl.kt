package com.help_scout_sdk

import HelpScoutApi
import HelpScoutApiBeaconRoute
import HelpScoutApiBeaconSettings
import HelpScoutApiFormPrefill
import HelpScoutApiUser
import HelpScoutCallbackApi
import android.app.Application
import com.helpscout.beacon.Beacon
import com.helpscout.beacon.internal.core.model.ContactFormConfigApi
import com.helpscout.beacon.model.BeaconConfigOverrides
import com.helpscout.beacon.model.FocusMode
import com.helpscout.beacon.ui.BeaconActivity
import android.content.Context
import android.content.Intent
import com.helpscout.beacon.model.BeaconScreens
import com.helpscout.beacon.model.PreFilledForm
import com.helpscout.beacon.ui.BeaconEventLifecycleHandler
import com.helpscout.beacon.ui.BeaconOnClosedListener
import com.helpscout.beacon.ui.BeaconOnOpenedListener
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class HelpScoutApiImpl(private val applicationContext: Context, private val callbackApi: HelpScoutCallbackApi) :


    HelpScoutApi {
    private val eventLifecycleHandler = BeaconEventLifecycleHandler(
        object : BeaconOnOpenedListener {
            override fun onOpened() {
                if (currentBeaconId != null) {
                    callbackApi.onBeaconOpen(currentBeaconId!!) {}
                }
            }
        },
        object : BeaconOnClosedListener {
            override fun onClosed() {
                if (currentBeaconId != null) {
                    callbackApi.onBeaconClose(currentBeaconId!!) {}
                }
            }
        }
    )

    private var application: Application? = null
    private var currentBeaconId: String? =  null

    fun onAttachedToActivity(binding: ActivityPluginBinding) {
        application = binding.activity.application
        application?.registerActivityLifecycleCallbacks(eventLifecycleHandler)
    }

    fun onDetachedFromActivity() {
        application?.unregisterActivityLifecycleCallbacks(eventLifecycleHandler)
    }

    override fun openBeacon(beaconSettings: HelpScoutApiBeaconSettings) {
        configureBeacon(beaconSettings)
        BeaconActivity.open(applicationContext)
    }

    override fun dismissBeacon() {
    }

    override fun identify(beaconId: String, user: HelpScoutApiUser) {
        initBeacon(beaconId)
        Beacon.identify(user.email ?: "", user.name, user.company, user.jobTitle, user.avatar)
        if (user.attributes != null) {
            for ((key, value) in user.attributes) {
                if (key != null && value != null) {
                    Beacon.addAttributeWithKey(key, value)
                }
            }
        }
    }

    override fun setSessionAttributes(beaconId: String, attributes: Map<String?, String?>) {
        initBeacon(beaconId)
        Beacon.setSessionAttributes(attributes)
    }

    override fun prefillForm(beaconId: String, prefillData: HelpScoutApiFormPrefill) {
        val customFieldValues = mutableMapOf<Int, String>()

        if (prefillData.customFields != null) {
            for ((key, value) in prefillData.customFields) {
                if (key != null && value != null) {
                    customFieldValues[key.toInt()] = value
                }
            }
        }

        Beacon.addPreFilledForm(
            PreFilledForm(
                name = prefillData.name ?: "",
                subject = prefillData.subject ?: "",
                message = prefillData.text ?: "",
                email = prefillData.email ?: "",
                customFieldValues = customFieldValues
            )
        )
    }

    override fun resetFormPrefill(beaconId: String) {
        initBeacon(beaconId)
        Beacon.prefilledFormReset()
    }

    override fun navigate(settings: HelpScoutApiBeaconSettings, route: HelpScoutApiBeaconRoute) {
        configureBeacon(settings)
        BeaconActivity.open(
            applicationContext, when (route) {
                HelpScoutApiBeaconRoute.HOME -> BeaconScreens.DEFAULT
                HelpScoutApiBeaconRoute.ASK -> BeaconScreens.ASK
                HelpScoutApiBeaconRoute.ASK_MESSAGE -> BeaconScreens.CONTACT_FORM_SCREEN
                HelpScoutApiBeaconRoute.ASK_CHAT -> BeaconScreens.CHAT
                HelpScoutApiBeaconRoute.ANSWERS -> BeaconScreens.DEFAULT
                HelpScoutApiBeaconRoute.PREVIOUS_MESSAGES -> BeaconScreens.PREVIOUS_MESSAGES
            }, arrayListOf()
        )
    }

    override fun search(settings: HelpScoutApiBeaconSettings, query: String) {
        configureBeacon(settings)
        BeaconActivity.open(applicationContext, BeaconScreens.SEARCH_SCREEN, arrayListOf(query))
    }

    override fun openArticle(settings: HelpScoutApiBeaconSettings, articleId: String) {
        configureBeacon(settings)
        BeaconActivity.open(
            applicationContext,
            BeaconScreens.ARTICLE_SCREEN,
            arrayListOf(articleId)
        )
    }

    override fun logout(beaconId: String) {
        initBeacon(beaconId)
        Beacon.logout()
    }

    override fun reset(beaconId: String) {
        initBeacon(beaconId)
        Beacon.contactFormReset()
    }

    private fun initBeacon(beaconId: String) {
        Beacon.Builder()
            .withBeaconId(beaconId)
            .withLogsEnabled(true)
            .build()
    }

    private fun configureBeacon(beaconSettings: HelpScoutApiBeaconSettings) {
        initBeacon(beaconSettings.beaconId)
        Beacon.setConfigOverrides(
            BeaconConfigOverrides(
                docsEnabled = beaconSettings.docsEnabled,
                messagingEnabled = beaconSettings.messagingEnabled,
                chatEnabled = beaconSettings.messagingEnabled,
                color = beaconSettings.color?.hexCode,
                enablePreviousMessages = beaconSettings.enablePreviousMessages ?: true,
                focusMode = when (beaconSettings.focusModeOverride) {
                    null -> null
                    HelpScoutApiBeaconFocusMode.NEUTRAL -> FocusMode.NEUTRAL
                    HelpScoutApiBeaconFocusMode.ASK_FIRST -> FocusMode.ASK_FIRST
                    HelpScoutApiBeaconFocusMode.SELF_SERVICE -> FocusMode.SELF_SERVICE
                },
                contactForm = ContactFormConfigApi(
                    allowAttachments = beaconSettings.messagingSettings?.contactFormAllowAttachments
                        ?: true,
                    customFieldsEnabled = beaconSettings.messagingSettings?.contactFormCustomFieldsEnabled
                        ?: true,
                    showName = beaconSettings.messagingSettings?.contactFormShowNameField ?: true,
                    showSubject = beaconSettings.messagingSettings?.contactFormShowSubjectField
                        ?: true
                )
            ),
        )
    }
}