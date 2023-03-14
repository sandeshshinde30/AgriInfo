import "package:flutter/material.dart";
import 'package:agri_info/App%20Theme/app%20theme.dart';
import '../Backup/Search_Screen.dart';
import '../Backup/Setting_Screen.dart';
import 'package:agri_info/main.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
import 'package:agri_info/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int tabIndex = 0;
  var tabPages = [Search(),Settings()];

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: Scaffold(
              backgroundColor: apptheme.appBackgroundColor(1),
              appBar: AppBar(
                elevation: 40,
                shadowColor: Colors.blue,
                titleSpacing: 0,
                iconTheme: IconThemeData(color: apptheme.appForegroundColor()),
                title: Row(
                  children: <Widget>[
                    Image.asset('Assets/Image/App Logo.png',height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Wearth",style: TextStyle(fontSize: 25,color: apptheme.appForegroundColor()),),
                    )
                  ],
                ),
                backgroundColor: apptheme.appBackgroundColor(),
              ),
              drawer: apptheme.appDrawer(),
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
                   // print(tabIndex);
                   // if(tabIndex == 0)
                   //   {
                   //     Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                   //   }
                   // if(tabIndex == 1)
                   //   {
                   //     Navigator.push(context,MaterialPageRoute(builder: (context) => Search()));
                   //   }
                   // if(tabIndex == 2)
                   //   {
                   //     Navigator.push(context,MaterialPageRoute(builder: (context) => Settings()));
                   //   }
                 });
                },
            ),
              ),
              body:
              SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color.fromRGBO(23, 200, 255, 0.9),Color.fromRGBO(200,50, 246, 0.8)],
                                  )
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Center(
                                                child: Text("kolhapur",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 30),)
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                                              child: Center(
                                                child: Text(DateFormat.MMMMEEEEd().format(DateTime.now()),style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 13),),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:5),
                                              child: Center(
                                                  child: Text( DateFormat("hh:mm").format(DateTime.now()),style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 20,letterSpacing: 1),)
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:5),
                                              child: Center(
                                                  child: Image.asset('Assets/Image/02n.png',height: 100,)
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Center(
                                                  child: Text("Clear",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 20),)
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:25,bottom: 20),
                                              child: Center(
                                                  child: Text("21°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 60),)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                                    Image.asset('Assets/Image/Wind Speed.png',color:apptheme.appForegroundColor(),height: 30,),
                                                    Text("13 Km/h",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                                    Text("Wind",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                                  ],
                                                )
                                              ),
                                        Container(
                                          height: 70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset('Assets/Image/humidity.png',color:apptheme.appForegroundColor(),height: 30,),
                                              Text("24°",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                              Text("Humidity",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset('Assets/Image/ultraviolet.png',color:apptheme.appForegroundColor(),height: 30,),
                                              Text("Low",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                              Text("UV Rays",style: TextStyle(fontSize: 13,color: apptheme.appForegroundColor()),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: apptheme.appForegroundColor(),
                                          width: 0.5
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("07:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                          ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Color.fromRGBO(23, 200, 255, 0.9),Color.fromRGBO(200,50, 246, 0.8)]
                                        ),
                                          border: Border.all(
                                              color: apptheme.appForegroundColor(),
                                              width: 0.1
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("08:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apptheme.appForegroundColor(),
                                              width: 0.5
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("09:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apptheme.appForegroundColor(),
                                              width: 0.5
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("10:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apptheme.appForegroundColor(),
                                              width: 0.5
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("11:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 120,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: apptheme.appForegroundColor(),
                                              width: 0.5
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("24°",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                              Image.asset('Assets/Image/02n.png',height: 40,),
                                              Text("12:00",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                                            ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      ),
                    ),
                  ),
      );
  }
}

var apptheme = appTheme();

