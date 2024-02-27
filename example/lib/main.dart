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
        'bcb7f307-fb2d-4944-8de2-358caea0c7b1',
        color: Colors.red,
        beaconTitle: 'The new title',
      ),
    );

    beacon.identify(
      HelpScoutUser(
        jobTitle: 'Support Hero',
        name: 'John Doe',
        email: 'john.doe@example.com',
        attributes: {
          'user-id': 'the_user_id',
        },
      ),
    );

    beacon.setSessionAttributes(
      {'platform': 'iOS'},
    );

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
                  beacon.navigate(BeaconRoute.home);
                },
                child: Text('Open beacon'),
              ),
              ElevatedButton(
                onPressed: () {
                  beacon.navigate(BeaconRoute.ask);
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
