import 'dart:convert';



import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class weatherAPI
{
  String location = "";

  weatherAPI({this.location = ""})
  {
    location = this.location;
  }

  Map APIData = {};
  double tempC = 0;
  String condition = " ";
  double windKPH = 0;
  double humidity = 0;
  double UVRays = 0;
  double pressureMB = 0;
  double visibilityKPH = 0;
  double dewPoint = 0;
  List<String> hourTempC = [];
  List<String> forecastcondition = [];
  String Location = "none";
  List<String> forecastMaxTempC6 = [];
  List<String> forecastMinTempC6 = [];
  String sunrise = "";
  String sunset = "";
  int isRain = 10;


  Future<void>getAPIData() async
  {
    try{
      Response response = await get(Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=212996ab9ef04119827143101230802&q=$location&days=7&aqi=no&alerts=no"));
      Map APIdata = jsonDecode(response.body);

      Location = location;
      tempC = APIdata['current']['temp_c'];
      condition = APIdata['current']['condition']['text'];
      windKPH = APIdata['current']['wind_kph'];
      humidity = APIdata['current']['humidity'].toDouble();
      UVRays = APIdata['current']['uv'];
      pressureMB = APIdata['current']['pressure_mb'];
      dewPoint = APIdata['forecast']['forecastday'][0]['hour'][0]['dewpoint_c'];
      visibilityKPH = APIdata['current']['vis_km'];
      sunrise = APIdata['forecast']['forecastday'][0]['astro']['sunrise'];
      sunset = APIdata['forecast']['forecastday'][0]['astro']['sunset'];
      isRain = APIdata['forecast']['forecastday'][0]['day']['daily_chance_of_rain'];

      for(int i = 0;i<23;i++)
        {
          hourTempC.add(APIdata['forecast']['forecastday'][0]['hour'][i]['temp_c'].toString());
          forecastcondition.add(APIdata['forecast']['forecastday'][0]['hour'][i]['condition']['text'].toString()) ;
          i = i+1;
        }

      for(int i = 0;i<7;i++)
        {
          forecastMaxTempC6.add(APIdata['forecast']['forecastday'][i]['day']['maxtemp_c'].toString());
          forecastMinTempC6.add(APIdata['forecast']['forecastday'][i]['day']['mintemp_c'].toString());
        }

      // print(forecastcondition);
      // print(hourTempC);
      APIData = {'location' : location , 'tempC' : tempC , 'condition' : condition ,
        'windKPH' : windKPH , 'humidity' : humidity , 'UVRays' : UVRays ,
        'pressure' : pressureMB , 'visibility' : visibilityKPH , 'dewPoint' : dewPoint ,
        'forecastHourData' : hourTempC  ,
        'forecastConditionData' : forecastcondition};
      // print(APIdata['forecastHourData'][0]);
      // print(APIdata['condition']);
      // print(APIData);
      // print(hourTempC);
      // print(hourTempC1);

      var prefData = await SharedPreferences.getInstance();

      if(location == "Mumbai")
        {
          prefData.setString('location',"no");
        }
      else
        {
          prefData.setString('location',location.toString());
        }
      prefData.setString('tempC',tempC.toString());
      prefData.setString('condition',condition.toString());
      prefData.setString('windKPH',windKPH.toString());
      prefData.setString('humidity',humidity.toString());
      prefData.setDouble('UVRays',UVRays);
      prefData.setString('pressure',pressureMB.toString());
      prefData.setString('visibility',visibilityKPH.toString());
      prefData.setString('dewPoint',dewPoint.toString());
      prefData.setStringList('forecastHourData',hourTempC);
      prefData.setStringList('forecastConditionData',forecastcondition);
      prefData.setStringList('forecastMaxTempC6',forecastMaxTempC6);
      prefData.setStringList('forecastMinTempC6',forecastMinTempC6);
      prefData.setString('sunrise',sunrise.toString());
      prefData.setString('sunset',sunset.toString());
      prefData.setInt('isRain',isRain);

      print("Api Called..");



    }
    catch(e)
    {
      print("API Data fetching failed...");
      print(e);
    }
  }
}

// class APIdata
// {
//
//   Map APIData = {};
//
//    APIdata()
//   {
//     weatherAPI objAPI = weatherAPI(location: "kolhapur");
//     objAPI.getAPIData();
//     // print("hours : ");
//     // print(objAPI.currentData);
//     APIData = objAPI.APIData;
//     // print(APIData);
//     // print(APIData['forecastConditionData'][0]);
//     print(APIData);
//   }
// }