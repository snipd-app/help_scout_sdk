import 'package:flutter/material.dart';
import 'package:help_scout_sdk/help_scout_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _helpScoutSdkPlugin = HelpScoutSdk.instance;
  late final Beacon beacon;

  @override
  void initState() {
    super.initState();
    beacon = _helpScoutSdkPlugin.createBeacon(
      BeaconSettings(
        'add6972f-5286-444b-93b2-3c40d3de11e2',
        chatEnabled: true,
        messagingEnabled: true,
        docsEnabled: false,
        enablePreviousMessages: true,
      ),
    );

    // beacon.identify(
    //   HelpScoutUser(
    //     jobTitle: 'Support Hero',
    //     name: 'John Doe',
    //     email: 'john.doe@example.com',
    //     attributes: {
    //       'user-id': 'the_user_id',
    //     },
    //   ),
    // );
    //
    // beacon.setSessionAttributes(
    //   {'platform': 'iOS'},
    // );

    // beacon.prefillForm(BeaconFormPrefill(subject: 'This is a caca subject'));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  beacon.open();
                },
                child: Text('Open beacon'),
              ),
              ElevatedButton(
                onPressed: () {
                  beacon.navigate(BeaconRoute.askChat);
                },
                child: Text('Open ask message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
