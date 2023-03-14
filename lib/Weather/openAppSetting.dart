
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class openAppSetting extends StatefulWidget {
  const openAppSetting({Key? key}) : super(key: key);

  @override
  State<openAppSetting> createState() => _openAppSettingState();
}

class _openAppSettingState extends State<openAppSetting> {

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
              content: Text("Location Permission not Granted."),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                      Navigator.popAndPushNamed(context, '/home');
                    },
                    child: Text("Grant")),
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
