
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class openLocationSetting extends StatefulWidget {
  const openLocationSetting({Key? key}) : super(key: key);

  @override
  State<openLocationSetting> createState() => _openLocationSettingState();
}

class _openLocationSettingState extends State<openLocationSetting> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Scaffold(
          body: Center(
            child: AlertDialog(
              shadowColor: Colors.blue,
              title: Text("Location"),
              content: Text("Location Service not Enabled."),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                      Navigator.popAndPushNamed(context, '/home');
                    },
                    child: Text("Enable")),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.popAndPushNamed(context, '/home');
                    },
                    child: Text("Back"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
