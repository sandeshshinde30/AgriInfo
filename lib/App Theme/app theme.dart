
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:agri_info/main.dart';

class appTheme{

  var color1 = [0,0,0]; // black
  var color2 = [255,255,255]; // white

  void appThemeChanger()
  {
    var color = color1;
    color1 = color2;
    color2 = color;
    print("theme Changed");
  }

  Color appBackgroundColor([double opacity = 1])
  {
    return Color.fromRGBO(color1[0], color1[1],color1[2],opacity);
  }

  Color appForegroundColor([double opacity = 1])
  {
    return Color.fromRGBO(color2[0],color2[1],color2[2],opacity);
  }

  Drawer appDrawer()
  {
    return Drawer(
      backgroundColor: appBackgroundColor(),
      child: ListView(
        children: [
          DrawerHeader(
              child:
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyanAccent,Colors.cyan,Colors.blue],
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: Image.asset('Assets/Image/App Logo.png',height: 80,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 30),
                          child: Text("WEARTH",style: TextStyle(color:appForegroundColor(),fontSize: 30),),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Weather of Earth",style: TextStyle(color:appForegroundColor(),fontSize: 20),),
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
          ListTile(
            leading: Icon(Icons.wind_power,color: appForegroundColor(),),
            title: Text("Wind Speed",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.water_drop,color: appForegroundColor(),),
            title: Text("Humidity",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.water_drop,color: appForegroundColor(),),
            title: Text("Soil Moisture",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.device_thermostat,color: appForegroundColor(),),
            title: Text("Dew Point",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.compress,color: appForegroundColor(),),
            title: Text("Pressure",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.visibility,color: appForegroundColor(),),
            title: Text("Visibility",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.sunny,color: appForegroundColor(),),
            title: Text("UV Rays",style: TextStyle(color:appForegroundColor()),),
          ),
          ListTile(
            leading: Icon(Icons.air,color: appForegroundColor(),),
            title: Text("Air Quality",style: TextStyle(color:appForegroundColor()),),
          ),
        ],
      ),
    );
  }

  AppBar appAppbar()
  {
    return AppBar(
      // elevation: 40,
      // shadowColor: Colors.blue,
      titleSpacing: 0,
      iconTheme: IconThemeData(color: appForegroundColor()),
      title: Row(
        children: <Widget>[
          Image.asset('Assets/Image/App Logo.png',height: 40,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Wearth",style: TextStyle(fontSize: 25,color: appForegroundColor()),),
          )
        ],
      ),
      backgroundColor: appBackgroundColor(),
    );
  }

  Padding searchCard()
  {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
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
                            child: Text("kolhapur",style: TextStyle(color: appForegroundColor(),fontSize: 30),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Center(
                            child: Text(DateFormat.MMMMEEEEd().format(DateTime.now()),style: TextStyle(color: appForegroundColor(),fontSize: 13),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5),
                          child: Center(
                              child: Text( DateFormat("hh:mm").format(DateTime.now()),style: TextStyle(color: appForegroundColor(),fontSize: 20,letterSpacing: 1),)
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
                              child: Text("Clear",style: TextStyle(color: appForegroundColor(),fontSize: 20),)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25,bottom: 20),
                          child: Center(
                              child: Text("21°",style: TextStyle(color: appForegroundColor(),fontSize: 60),)
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
                            Image.asset('Assets/Image/Wind Speed.png',color:appForegroundColor(),height: 30,),
                            Text("13 Km/h",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                            Text("Wind",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                          ],
                        )
                    ),
                    Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('Assets/Image/humidity.png',color:appForegroundColor(),height: 30,),
                          Text("24°",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                          Text("Humidity",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('Assets/Image/ultraviolet.png',color:appForegroundColor(),height: 30,),
                          Text("Low",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                          Text("UV Rays",style: TextStyle(fontSize: 13,color: appForegroundColor()),),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container searchNotFound()
  {
    return Container(
      padding: EdgeInsets.only(top:250),
      child: Center(child:
      Text("No Result Found",style: TextStyle(color: Colors.white,fontSize: 20),)
      ),
    );
  }

  Container todayWhether()
  {
    return Container(
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
                        color: appForegroundColor(),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("07:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
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
                        color: appForegroundColor(),
                        width: 0.1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("08:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
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
                        color: appForegroundColor(),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("09:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
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
                        color: appForegroundColor(),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("10:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
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
                        color: appForegroundColor(),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("11:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
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
                        color: appForegroundColor(),
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("24°",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                    Image.asset('Assets/Image/02n.png',height: 40,),
                    Text("12:00",style: TextStyle(color: appForegroundColor(),fontSize: 15),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Padding ImgSlide([img1 = 'Assets/Image/01d.png',img2 = 'Assets/Image/01n.png',img3 = 'Assets/Image/02d.png'])
  {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ImageSlideshow(
        /// Width of the [ImageSlideshow].
        width: double.infinity,


        /// Height of the [ImageSlideshow].
        height: 200,

        /// The page to show when first creating the [ImageSlideshow].
        initialPage: 0,

        /// The color to paint the indicator.
        indicatorColor: Colors.blue,

        /// The color to paint behind th indicator.
        indicatorBackgroundColor: Colors.grey,

        /// Auto scroll interval.
        /// Do not auto scroll with null or 0.
        autoPlayInterval: 3000,

        /// Loops back to first slide.
        isLoop: true,

        /// The widgets to display in the [ImageSlideshow].
        /// Add the sample image file into the images folder
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromRGBO(23, 200, 255, 0.9),Color.fromRGBO(200,50, 246, 0.8)]
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Kolhapur",style: TextStyle(fontSize: 14,color: appForegroundColor(),fontStyle: FontStyle.italic),),
                      Text("VISIBILITY",style: TextStyle(fontSize: 25,color: appForegroundColor()),),
                      Image.asset('Assets/Image/visibility.png',height: 50,color: Colors.white,),
                      Text("10 KM",style: TextStyle(fontSize: 22,color: appForegroundColor()),),
                    ],
                  )
                ),

              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.fromRGBO(23, 200, 255, 0.9),Color.fromRGBO(200,50, 246, 0.8)]
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10,left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Kolhapur",style: TextStyle(fontSize: 14,color: appForegroundColor(),fontStyle: FontStyle.italic),),
                        Text("DEW POINT",style: TextStyle(fontSize: 25,color: appForegroundColor()),),
                        Image.asset('Assets/Image/dew-point.png',height: 50,color: Colors.white,),
                        Text("14°",style: TextStyle(fontSize: 22,color: appForegroundColor()),),
                      ],
                    )
                ),

              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.fromRGBO(23, 200, 255, 0.9),Color.fromRGBO(200,50, 246, 0.8)]
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10,left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Kolhapur",style: TextStyle(fontSize: 14,color: appForegroundColor(),fontStyle: FontStyle.italic),),
                        Text("PRESSURE",style: TextStyle(fontSize: 25,color: appForegroundColor()),),
                        Image.asset('Assets/Image/barometer.png',height: 50,color: Colors.white,),
                        Text("1007 mb",style: TextStyle(fontSize: 22,color: appForegroundColor()),),
                      ],
                    )
                ),

              ],
            ),
          )
        ],


      ),
    );
  }
}