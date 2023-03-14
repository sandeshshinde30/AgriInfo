
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../lib/App Theme/app theme.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  int tabIndex = 1;
  String? location;
  int search = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: apptheme.appBackgroundColor(1),
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
                child: Text("Search",style: TextStyle(fontSize: 25,color: apptheme.appForegroundColor()),),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 15,left: 10,right:20),
                     child: TextField(
                       onChanged: (value) =>  location = value.toLowerCase().trim(),
                       style: TextStyle(color: Colors.white),
                       cursorColor: Colors.white,
                       decoration: InputDecoration(
                        hintText: "Search Location Here",
                           hintStyle: TextStyle(color: Colors.white),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20),
                             borderSide: BorderSide(
                               width: 2,
                               color: Colors.cyan,
                             )
                           ),
                           enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20),
                               borderSide: BorderSide(
                                 width: 2,
                                 color: Colors.blue,
                               )
                           )
                         ),
                       ),
                     ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,top: 10),
                    child: SizedBox(
                      height: 55,
                      width: 80,
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {});
                          },
                          child: Image.asset('Assets/Image/search.png',height: 30,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              if(location == "kolhapur")
                apptheme.searchCard(),
              if(location == "kolhapur")
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Today",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                      )
                    ],
                  ),
                ),
              if(location == "kolhapur")
                apptheme.todayWhether(),
              if(location != "kolhapur")
                apptheme.searchNotFound(),

                ],
          ),
        ),
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
    //Navigator.pushReplacementNamed(context,'/Search').then((_) => setState(() {}));
      setState(() {});
    }
    if(tabIndex == 2)
    {
    // Navigator.pushReplacementNamed(context,'/Settings');
    Navigator.pushReplacementNamed(
    context,
    '/Settings').then((_) => setState(() {}));
    }
    });
    },
    ),
      ),
    );
  }
}

var apptheme = appTheme();