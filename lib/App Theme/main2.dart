import 'dart:async';
// import '../../Backup/Setting_Screen.dart';
import 'package:flutter/material.dart';
import 'package:agri_info/App%20Theme/app%20theme.dart';
// import '../../Backup/Search_Screen.dart';
import 'package:intl/intl.dart';
// import '../../Assets/whether_components.dart';


void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (BuildContextcontext) => Loader(),
        '/Home' : (BuildContextcontext) => Wheather_Forecasting(),
        // '/Search' : (context) => Search(),
        // '/Settings' : (context) => Settings(),
    },
    )
  );
}

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => Wheather_Forecasting()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Center(
              child:Container(
                color: apptheme.appBackgroundColor(),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('Assets/Image/AppIcon.jpeg',height: 100,),
                        ]
                    ),

                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('Assets/Gif/App Loader.gif',width: 70)]
                      ),
                  ],
                )
                ),
              ),
    );
  }
}

var apptheme = appTheme();


class Wheather_Forecasting extends StatefulWidget {
  const Wheather_Forecasting({Key? key}) : super(key: key);
  @override
  State<Wheather_Forecasting> createState() => _Wheather_ForecastingState();
}

class _Wheather_ForecastingState extends State<Wheather_Forecasting> {

  int tabIndex = 0;
  String? hey;
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: Scaffold(
            backgroundColor: apptheme.appBackgroundColor(),
            appBar: AppBar(
              leading: Icon(Icons.arrow_back),
              backgroundColor: apptheme.appBackgroundColor(),
              elevation: 40,
              shadowColor: Colors.blue,
              titleSpacing: 0,
              iconTheme: IconThemeData(color: apptheme.appForegroundColor()),
              title: Row(
                children: <Widget>[
                  // Image.asset('Assets/Image/App Logo.png',height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Weather Forecasting",style: TextStyle(fontSize: 25,color: apptheme.appForegroundColor()),),
                  )
                ],
              ),
            ),
            body:
            RefreshIndicator(
              onRefresh: (){
                return Future.delayed(
                    Duration(seconds: 1),
                (){
                      setState(() {});
                });
              },
              child: SingleChildScrollView(
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
                    apptheme.todayWhether(),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Tomorrow",style: TextStyle(color: apptheme.appForegroundColor(),fontSize: 15),),
                          )
                        ],
                      ),
                    ),
                    apptheme.todayWhether(),
                    Container(
                      child: apptheme.ImgSlide(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

