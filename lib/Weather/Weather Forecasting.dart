import 'dart:async';
import 'package:agri_info/Weather/weatherAPI.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weatherTheme.dart';


/// ********************************* Weather Forecasting module loader ********************************

class WeatherLoader extends StatefulWidget {
  const WeatherLoader({Key? key}) : super(key: key);

  @override
  State<WeatherLoader> createState() => _WeatherLoaderState();
}

class _WeatherLoaderState extends State<WeatherLoader> {

  void getApiData() async
  {
    var pref = await SharedPreferences.getInstance();
    /// If user denied location permission then default location will be Mumbai
    var location = pref.getString('userLocation') ?? "Mumbai";

    weatherAPI objAPI = weatherAPI(location: location);
    await objAPI.getAPIData();
  }

  @override
  void initState() {
    super.initState();
    getLocation(context);
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
    // Center(
      //   child:Container(
      //       color: WeatherTheme.backgroundColor(),
      //       child: Image.asset('Assets/Gif/Loading.gif',height: 100,)
      //           ),
      //       )
    );
  }
}


/// ********************************* Weather Forecasting module main body ********************************


class Wheather_Forecasting extends StatefulWidget {
  const Wheather_Forecasting({Key? key}) : super(key: key);
  @override
  State<Wheather_Forecasting> createState() => _Wheather_ForecastingState();
}

class _Wheather_ForecastingState extends State<Wheather_Forecasting> {

  @override
  void initState() {
    getPreferanceData();
    super.initState();
  }

  List<String> twoHourTime = ['00:00 AM','02:00 AM','04:00 AM','06:00 AM','08:00 AM','10:00 AM','12:00 PM','14:00 PM','16:00 PM','18:00 PM','20:00 PM','22:00 PM',];

  /// ********* Weather API Data ********** ///

  var Location = "no location";
  var Temperature = "no temperature";
  var Condition = "no condition";
  var WindSpeed = "no wind speed";
  var Humidity = "no Humidity";
  var UVRays = 0.0;
  var Pressure = "no Pressure";
  var Visibility = "no Visibility";
  var Dewpoint = "no Dewpoint";
  var ForecastHour = [];
  var ForecastCondition = [];
  var ForecastMaxTempC6 = [];
  var ForecastMinTempC6 = [];
  var Sunrise = "no sunrise";
  var Sunset = "no sunset";
  var IsRain = 100;

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, '/home');
        return true;
      },
      child: Scaffold(
            backgroundColor: WeatherTheme.backgroundColor(),
            appBar: AppBar(
              backgroundColor: WeatherTheme.backgroundColor(),
              elevation: 10,
              shadowColor: WeatherTheme.foregroundColor(),
              titleSpacing: 0,
              iconTheme: IconThemeData(color: WeatherTheme.backgroundColor()),
              leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.popAndPushNamed(context, '/home'); },),

              title:Text("Weather Forecasting",style: TextStyle(fontSize: 20,color: WeatherTheme.foregroundColor())),

              actions: [
                IconButton(
                    onPressed: (){
                      WeatherTheme.swapColor();
                      setState(() {});
                    },
                    icon: Icon(Icons.sunny,color: WeatherTheme.foregroundColor(),weight: 20,size: 30)
                )
              ],
            ),

            body: RefreshIndicator(
              onRefresh: (){
                return Future.delayed(
                  Duration(seconds: 1),
                      (){
                    getPreferanceData();
                    setState(() {});
                  });},
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Container(
                       height: 250,
                       width: MediaQuery.of(context).size.width,
                       // color: WeatherTheme.foregroundColor()12,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(top: 30,left: 15),
                             child:
                             Column(
                               children: [
                                 if(Location != "no")
                                   Text(Location.trimLeft(),style: TextStyle(color: WeatherTheme.foregroundColor(),fontSize: 30,),),
                                 if(Location == "no")
                                   Text("Could not load data, Try again",style: TextStyle(color: Colors.red,fontSize: 20,),),
                             ],)
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 15,top: 8),
                             child: Text(DateFormat("MMMM dd, yyyy").format(DateTime.now()).toString(),style: TextStyle(color: WeatherTheme.foregroundColor(0.7),fontSize: 12),),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 30),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 Image.asset(IconChanger(Condition).toString()),
                                 Container(
                                   height: 80,
                                   width: 1,
                                   color: WeatherTheme.foregroundColor(),
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: [
                                     Text(Temperature,style: TextStyle(color:WeatherTheme.foregroundColor(),fontSize: 70),),
                                     Padding(
                                       padding: const EdgeInsets.only(bottom: 15),
                                       child: Text(Condition,style: TextStyle(color:WeatherTheme.foregroundColor(0.5),fontSize: 15),),
                                     ),
                                   ],
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                      Container(
                        height: 100,
                        // color: WeatherTheme.foregroundColor()12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              WeatherTheme.container3("Assets/Image/Weather/wind speed.png",WindSpeed+" km/h"),
                              WeatherTheme.container3("Assets/Image/Weather/humidity.png", Humidity + "%"),
                              WeatherTheme.container3("Assets/Image/Weather/ultraviolet.png",uvIndex(UVRays).toString())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 15),
                        child: Container(
                          height: 20,
                          child: Text("Today",style: TextStyle(color:WeatherTheme.foregroundColor(),fontSize: 16),),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                           for(int i = 0;i<12;i++)
                             WeatherTheme.todayHour(twoHourTime[i].toString(),hourIconChanger(ForecastCondition[i]).toString(),ForecastHour[i]+"°"),
                          ],
                        ),
                      ),
                     SizedBox(
                       height: 20,
                     ),
                      Container(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color : Color.fromRGBO(216,215,228, 0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top : 15,left: 15),
                                  child: Text("Next Days",style: TextStyle(color:WeatherTheme.foregroundColor(),fontSize: 16)),
                                ),
                                for(int i = 1;i<7;i++)
                                WeatherTheme.next6Days(i,ForecastMaxTempC6[i],ForecastMinTempC6[i]),

                              ],
                        ),
                      ),
                      Container(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color : Color.fromRGBO(216,215,228, 0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top : 15,left: 15),
                              child: Text("Other Information",style: TextStyle(color:WeatherTheme.foregroundColor(),fontSize: 16)),
                            ),
                              WeatherTheme.otherInfo("Visibility","Assets/Image/Weather/visibility.png","$Visibility km/h"),
                              WeatherTheme.otherInfo("Pressure","Assets/Image/Weather/pressure.png","$Pressure mb"),
                              WeatherTheme.otherInfo("Dew Point","Assets/Image/Weather/dew point.png","$Dewpoint°"),
                              WeatherTheme.otherInfo("Sunrise","Assets/Image/Weather/sunrise.png","$Sunrise"),
                              WeatherTheme.otherInfo("Sunset","Assets/Image/Weather/sunset.png","$Sunset"),
                              WeatherTheme.otherInfo("is Rain Today","Assets/Image/Weather/rainy.png",isRain(IsRain).toString()),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        );



  void getPreferanceData() async
  {
    var pref = await SharedPreferences.getInstance();

    var location = pref.getString('location');
    var tempC = pref.getString('tempC');
    var condition = pref.getString('condition');
    var windKPH = pref.getString('windKPH');
    var humidity = pref.getString('humidity');
    var UVrays = pref.getDouble('UVRays');
    var pressure = pref.getString('pressure');
    var visibility = pref.getString('visibility');
    var dewPoint = pref.getString('dewPoint');
    var forecastHourData = pref.getStringList('forecastHourData');
    var forecastConditionData = pref.getStringList('forecastConditionData');
    var forecastMaxTempC6 = pref.getStringList('forecastMaxTempC6');
    var forecastMinTempC6 = pref.getStringList('forecastMinTempC6');
    var sunrise = pref.getString('sunrise');
    var sunset = pref.getString('sunset');
    var isRain = pref.getInt('isRain');


    Location = location ?? "no value get from preferances";
    Temperature = tempC ?? "no value get from preferances";
    Condition = condition ?? "no value get from preferances";
    WindSpeed = windKPH ?? "no value get from preferances";
    Humidity = humidity ?? "no value get from preferances";
    UVRays = UVrays!  ;
    Pressure = pressure ?? "no value get from preferances";
    Visibility = visibility ?? "no value get from preferances";
    Dewpoint = dewPoint ?? "no value get from preferances";
    ForecastHour = forecastHourData!;
    ForecastCondition = forecastConditionData! ;
    ForecastMaxTempC6 = forecastMaxTempC6!;
    ForecastMinTempC6 = forecastMinTempC6!;
    Sunrise = sunrise ?? "no value get from preferances";
    Sunset = sunset ?? "no value get from preferances";
    IsRain = isRain ?? 100;

    setState(() {});
  }
}

weatherTheme WeatherTheme = new weatherTheme();

String? IconChanger([dynamic condition ])
{
  if(condition == 'Sunny')
  {
    return 'Assets/Image/Weather/50d.png';
  }
  else
  {
    return 'Assets/Image/Weather/50n.png';
  }
  // print(condition);
  // print("hello");
}

String? uvIndex([double UV = 0])
{
  if(UV < 3 )
    return "Low";
  if(UV > 2 && UV < 6)
    return "Moderate";
  if(UV > 5 && UV < 8)
    return "High";
  if(UV > 7 && UV < 11)
    return "Very High";
  if(UV > 10)
    return "Extreme";
}

String? hourIconChanger([dynamic condition ])
{
  if(condition == 'Sunny')
  {
    return 'Assets/Image/Weather/02d.png';
  }
  else
  {
    return 'Assets/Image/Weather/02n.png';
  }
}

String? isRain(int i)
{
  if(i == 1)
    {
      return "Yes";
    }
  else
    {
      return "No";
    }
}

void getLocation(BuildContext context) async
{
  dynamic position = await determinePosition(context);
  if(position!= null)
  {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    var location = place.subLocality.toString() + " " + place.locality.toString();
    print("Location : ");
    print(location);

    /// *************Storing user location in shared preferances *************///
    var preflocation = await SharedPreferences.getInstance();
    preflocation.setString('userLocation', location.toString());

  }
}

Future<Object> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Navigator.pushReplacementNamed(context, '/openLocationSettings');

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Navigator.pushReplacementNamed(context, '/openAppSettings');
      return Future.error('Location permissions are denied');
  }

  if (permission == LocationPermission.deniedForever) {
    Navigator.pushReplacementNamed(context, '/openAppSettings');
    return Future.error("Location Service permenentaly denied");
  }

  Timer(Duration(seconds:3),
          ()=>Navigator.pushReplacementNamed(context, '/weather_forecast'));
  return await Geolocator.getCurrentPosition();
}
