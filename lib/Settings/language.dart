import 'package:agri_info/Settings/settingsTheme.dart';
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Applanguage extends StatefulWidget {
  const Applanguage({Key? key}) : super(key: key);

  @override
  State<Applanguage> createState() => _languageState();
}

class _languageState extends State<Applanguage> {

  @override
  void initState()  {
    super.initState();
    determine_language();
  }

  int english = 0;
  int marathi = 0;
  int hindi = 0;
  String toastMsg = "Language Updated Successfully";

  Future<void> determine_language()
  async {
    var preflanguage = await SharedPreferences.getInstance();
    var language = preflanguage.getString('language').toString();
    if(language == "English")
      {
        english = 1;
      setState(() {});
      }
    else if(language == "Hindi")
      {
        hindi = 1;
        toastMsg = "भाषा सफलतापूर्वक बदली गई";
        setState(() {});
      }
    else if(language == "Marathi")
      {
        marathi = 1;
        toastMsg = "भाषा यशस्वीरित्या बदलली";
        setState(() {});}
    else
      {
        english = 1;
        marathi = 0;
        hindi = 0;
        setState(() {});
      }
  }

    @override
  Widget build(BuildContext context) {
      return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return true;
          },
          child: Scaffold(
            backgroundColor: Color.fromRGBO(244, 255, 247, 1.0),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              elevation: 0,
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/settings').then((
                      _) {
                    setState(() {});
                  });
                },),
              iconTheme: IconThemeData(color: Colors.black54, size: 30),
              title: Text("Language", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),),
            ),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  settingsTheme().divider(),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                        onPressed: () {
                          english = 1;
                          marathi = 0;
                          hindi = 0;
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("English", style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),),
                            ),
                            if(english == 1)
                              Image.asset(
                                'Assets/Image/tick_mark.png', height: 30,)
                          ],
                        )
                    ),
                  ),
                  settingsTheme().divider(),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                        onPressed: () {
                          marathi = 1;
                          english = 0;
                          hindi = 0;
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("मराठी", style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),),
                            ),
                            if(marathi == 1)
                              Image.asset(
                                'Assets/Image/tick_mark.png', height: 30,)
                          ],
                        )
                    ),
                  ),
                  settingsTheme().divider(),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                        onPressed: () {
                          marathi = 0;
                          english = 0;
                          hindi = 1;
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("हिंदी", style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),),
                            ),
                            if(hindi == 1)
                              Image.asset(
                                'Assets/Image/tick_mark.png', height: 30,)
                          ],
                        )
                    ),
                  ),
                  settingsTheme().divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
                    child: TextButton(onPressed: () async {
                      var prefLanguage = await SharedPreferences.getInstance();
                      if (english == 1) {
                        prefLanguage.setString("language", "English");
                        print("Hello English");
                      }

                      else if (marathi == 1) {
                        prefLanguage.setString("language", "Marathi");
                        print("Hello Marathi");
                      }

                      else if (hindi == 1) {
                        prefLanguage.setString("language", "Hindi");
                        print("Hello Hindi");
                      }

                      settingsTheme().showToast("$toastMsg");
                    },
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(20, 79, 22, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 5, right: 15, bottom: 5),
                        child: Text("Update", style: TextStyle(
                            color: Colors.white, letterSpacing: 1),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
}

shopTheme shoptheme = new shopTheme();
