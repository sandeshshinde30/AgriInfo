import 'dart:async';
import 'dart:io';
import 'package:agri_info/Weather/weatherAPI.dart';
import 'package:flutter/material.dart';
import 'package:agri_info/homepage.dart';
import 'package:agri_info/Weather/Weather%20Forecasting.dart';
import 'package:agri_info/BioPesticides.dart';
import 'package:agri_info/login.dart';
import 'package:agri_info/regis.dart';
import 'package:agri_info/search.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Weather/openAppSetting.dart';
import 'Weather/openLocationSetting.dart';

void main()
{
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (BuildContextcontext) => Loader(),
          '/home' : (BuildContextcontext) => Root_Page(),
          '/weather_forecast' : (BuildContext) => Wheather_Forecasting(),
          '/weather_forecast_loader' : (BuildContext) => WeatherLoader(),
          '/biopesticides' : (BuildContext) => Biopesticide(),
          '/login' : (BuildContext) => lgn(),
          '/register' : (BuildContext context)=>regis(),
          '/openLocationSettings' : (BuildContext context)=>openLocationSetting(),
          '/openAppSettings' : (BuildContext context)=>openAppSetting(),
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

  String? location;

  void getLocation() async
  {
    final Position position = await determinePosition(context);
    if(position!= null)
    {
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      location = place.subLocality.toString() + " " + place.locality.toString();
      print("Location : ");
      print(location);

      var preflocation = await SharedPreferences.getInstance();
      preflocation.setString('userLocation', location.toString());

    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:2),
            ()=>Navigator.pushReplacementNamed(context, '/home'));
    // getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:Container(
            color: Colors.white,
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

class Root_Page extends StatefulWidget {

  @override
  State<Root_Page> createState() => _Root_PageState();
}

class _Root_PageState extends State<Root_Page> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    home(),

    MyApp(),

    Biopesticide(),

    lgn(),
  ];

  @override
  Widget build(BuildContext context) {
    /// ****************** Getting user loation from loder ****************** ///
    var location = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.green.shade300,
            child: ListView(
              children: [
                DrawerHeader(
                    child: Text("Menu", style: TextStyle(color: Colors.white, fontSize:40), ),
                  decoration: BoxDecoration(
                    // color: Colors.deepPurple,
                    image: DecorationImage(
                      image: AssetImage("assets/img/dodge.jpg"),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home_filled,color: Colors.green,size: 20,),
                  title: Text("Home Page"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.search,color: Colors.yellow,size: 20),
                  title: Text("Search"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.download,color: Colors.orange,size: 20),
                  title: Text("DOWNLOAD",),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.favorite,color: Colors.red,size: 20),
                  title: Text("LIKED",),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.account_circle,color: Colors.blue,size: 20),
                  title: Text("My Account",),
                  onTap: (){},
                ),
                ],
              ),
            ),


      appBar: AppBar(
        backgroundColor: Color.fromRGBO(139, 227, 143, 1),
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset('Assets/Image/AppIcon.jpeg',height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("AgriInfo", style: TextStyle(color: Colors.white),),
            )
          ],
        )

        ),

        
        body: _pages[_selectedIndex],
        
         bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(255,255,255,1),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            iconSize: 25,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home,),label:""),
              BottomNavigationBarItem(icon: Icon(Icons.search),label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.login),label: ""),
            ],
        )

      );

  }
}

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Timer(Duration(seconds:2),
            ()=>Navigator.pushReplacementNamed(context, '/home'));
    // await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Timer(Duration(seconds:2),
              ()=>Navigator.pushReplacementNamed(context, '/home'));
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // await Geolocator.openAppSettings();
    Timer(Duration(seconds:2),
            ()=>Navigator.pushReplacementNamed(context, '/home'));
    return Future.error("Location Service permenentaly denied");
  }

  Timer(Duration(seconds:2),
          ()=>Navigator.pushReplacementNamed(context, '/home'));

  return await Geolocator.getCurrentPosition();
}

