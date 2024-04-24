import 'package:agri_info/App%20Theme/app%20theme.dart';
import 'package:flutter/material.dart';
import 'Search_Screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int tabIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 20,
        shadowColor: Colors.black,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: apptheme.appForegroundColor()),
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                color: apptheme.appForegroundColor(),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/Home').then((_) => setState(() {}));
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
                flex: 1,
                child: Image.asset('Assets/Image/App Logo.png',height: 40,)),
            Expanded(
              flex: 6,
              child:  Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text("Settings",style: TextStyle(fontSize: 25,color: apptheme.appForegroundColor()),),
              ),
            )
          ],
        ),
        backgroundColor: apptheme.appBackgroundColor(1),
      ),
      body : Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top : 10 , left: 15),
            child: Row(
                children: [
                        Image.asset('Assets/Image/palette.png',height: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: TextButton(child:
                          Text("Theme",style: TextStyle(fontSize: 23,color: Colors.black,fontWeight: FontWeight.w500),)
                            ,onPressed: (){
                              apptheme.appThemeChanger();
                              setState(() {});
                            },
                          ),
                        )
                      ],
            ),
          )
        ],
      ),
    bottomNavigationBar:
    Container(
    decoration: BoxDecoration(
    border: Border(top: BorderSide(color : apptheme.appForegroundColor(),width: 2))
    ),
    child :BottomNavigationBar(
    backgroundColor: apptheme.appBackgroundColor(),
    unselectedItemColor: apptheme.appForegroundColor(),
    unselectedIconTheme: IconThemeData(color: apptheme.appForegroundColor()),
    selectedIconTheme: IconThemeData(color: Colors.cyan),
    selectedItemColor: Colors.cyan,
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home",),
    BottomNavigationBarItem(icon:Icon(Icons.search),label: "Search"),
    BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Settings")
    ],
    currentIndex: tabIndex,
    onTap: (setvalue){
    setState(() {
    tabIndex = setvalue;
    print(tabIndex);
    if(tabIndex == 0)
    {
    Navigator.pushReplacementNamed(context,'/Home').then((_) => setState(() {}));
    }
    if(tabIndex == 1)
    {
    // Navigator.pushReplacementNamed(context,'/Search');
    Navigator.pushReplacementNamed(context,'/Search').then((_) => setState(() {}));
    }
    if(tabIndex == 2)
    {
    // Navigator.pushReplacementNamed(context,'/Settings');
    // Navigator.pushReplacementNamed(
    // context,
    // '/Settings').then((_) => setState(() {}));
      setState(() {});
    }
    });
    },
    ),
    )
    );
  }
}

var apptheme = appTheme();

