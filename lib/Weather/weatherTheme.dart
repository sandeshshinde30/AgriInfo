import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class weatherTheme
{
  var ForegroundColor = [0, 0, 0];
  var BackgroundColor = [255, 255, 255];

  void swapColor()
  {
    var swap = ForegroundColor;
    ForegroundColor = BackgroundColor;
    BackgroundColor = swap;
    print("Change theme called...");
  }

  Color foregroundColor([double opacity = 1])
  {
    return Color.fromRGBO(ForegroundColor[0], ForegroundColor[1], ForegroundColor[2],opacity);
  }

  Color backgroundColor([double opacity = 1])
  {
    return Color.fromRGBO(BackgroundColor[0], BackgroundColor[1], BackgroundColor[2],opacity);
  }

  Column container3([String imagepath = 'Assets/Image/Weather/wind speed.png' , String data = "2.06 km/h"])
  {
    return
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color : Color.fromRGBO(211, 211, 211, 0.5),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(imagepath),
                ),
              ),
              Text(data,style: TextStyle(color: foregroundColor(),fontSize: 12),)
            ],
          );
  }

  Container todayHour([String time = "12:00 AM" , String imagePath = 'Assets/Image/Weather/02d.png' , String temp = "30°"])
  {
    return
      Container(
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color : Color.fromRGBO(206,205,210, 0.5),
        ),
        height: 130,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(time,style: TextStyle(color: foregroundColor(),fontSize: 12),),
            Image.asset(imagePath,height: 50,),
            Text(temp,style: TextStyle(color: foregroundColor(),fontSize: 15))
          ],
        ),
      );
  }

  Column next6Days(int i,[String maxTempc = "0" , String minTempc = "-0"])
  {
    return
          Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 70,
                          child: Text(DateFormat("EEEE").format(DateTime.now().add(Duration(days:i))),style: TextStyle(color:foregroundColor(),fontSize: 12))),
                      SizedBox(width: 15,),
                      Container(
                          width: 35,
                          child: Image.asset('Assets/Image/Weather/04d.png',height: 30,)),
                      Container(
                          width: 70,
                          child: Text("$maxTempc°/$minTempc°",style: TextStyle(color:foregroundColor(),fontSize: 12)))
                    ],
                 ),
                  ),
                if(i<6)
                Container(margin: EdgeInsets.only(top: 8,left: 15,right: 15),height: 1,color: foregroundColor(0.2)),
              ],
          ) ;

  }

  Column otherInfo([String title = 'Visibility',String imagePath = 'Assets/Image/Weather/visibility.png' , String value = '12 km/h'])
  {
    return
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 80,
                    child: Text(title,style: TextStyle(color:foregroundColor(),fontSize: 12)),),
                SizedBox(width: 15,),
                Container(
                    width: 35,
                    child: Image.asset(imagePath,height: 30,)),
                  Container(
                    width: 70,
                    child: Text(value,style: TextStyle(color:foregroundColor(),fontSize: 12)))
              ],
            ),
          ),
            Container(margin: EdgeInsets.only(top: 8,left: 15,right: 15),height: 1,color: foregroundColor(0.2)),
        ],
      ) ;
  }

}