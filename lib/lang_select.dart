import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';



class LanguageSelectionPage extends StatelessWidget {

  var language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your language',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedIconButton(
                  icon: Icons.language,
                  label: 'English',
                  onPressed: () {
                    setLanguage("English");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  iconData: Icons.language,
                ),
                RoundedIconButton(
                  icon: Icons.language,
                  label: 'मराठी',
                  onPressed: () {
                    setLanguage("Marathi");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  iconData: Icons.language,
                ),
                RoundedIconButton(
                  icon: Icons.language,
                  label: 'हिंदी',
                  onPressed: () {
                    setLanguage("Hindi");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  iconData: Icons.language,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future setLanguage(String lang) async
{
  var prefLanguage = await SharedPreferences.getInstance();
  prefLanguage.setString("language","$lang");
}


class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final IconData iconData;

  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: 120.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 48.0),
            SizedBox(height: 8.0),
            Text(label),
          ],
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}

class EnglishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English'),
      ),
      body: Center(
        child: Text('English Page'),
      ),
    );
  }
}

class MarathiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marathi'),
      ),
      body: Center(
        child: Text('Marathi Page'),
      ),
    );
  }
}

class HindiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi'),
      ),
      body: Center(
        child: Text('Hindi Page'),
      ),
    );
  }
}