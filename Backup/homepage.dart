import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  Future<bool?>showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Are you sure to exit app?"),
        actions: [
          ElevatedButton(
              child: Text("No"),
               onPressed: ()=> Navigator.pop(context,false)
          ),
          ElevatedButton(
              child: Text("Yes"),
              onPressed: ()=> Navigator.pop(context,true)
          )
        ],
      )

  );

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        final willPop = await showWarning(context);
        return willPop ?? false;
      },
      child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(child: Text('Welcome to Agri Info',
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.green.shade300),
                )
                ),
              height: 70,
              ),
            Container(
              decoration: BoxDecoration(

                gradient: LinearGradient(colors: [
                  Colors.white, Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                )
              ),
              // height: 300,
              child: Container(
                padding: EdgeInsets.all(15),
                child: ImageSlideshow(
                  /// Width of the [ImageSlideshow].
                  width: double.infinity,

                  /// Height of the [ImageSlideshow].
                  height: 200,

                  /// The page to show when first creating the [ImageSlideshow].
                  initialPage: 0,

                  /// The color to paint the indicator.
                  indicatorColor: Colors.green.shade300,

                  /// Auto scroll interval.
                  /// Do not auto scroll with null or 0.
                  autoPlayInterval: 8000,

                  /// Loops back to first slide.
                  isLoop: true,

                  /// The color to paint behind th indicator.
                  indicatorBackgroundColor: Colors.white,

                  /// The widgets to display in the [ImageSlideshow].
                  /// Add the sample image file into the images folder
                  children: [
                    Image.asset(
                      'Assets/Image/Biopesticide.jpg',
                      fit: BoxFit.fitWidth,

                    ),
                    Image.asset(
                      'Assets/Image/Crop.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                    Image.asset(
                      'Assets/Image/Whether.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width : 160,
                    height: 120,
                    color: Color.fromRGBO(203, 251, 219, 0.7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('Assets/Image/crop diseas icon.png',height: 70,color: Colors.green,),
                        Text("Crop Disease")
                      ],
                    )
                  ),
                  Container(
                      width : 160,
                      height: 120,
                      color: Color.fromRGBO(203, 251, 219, 0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                    onTap : (){
                      Navigator.pushReplacementNamed(
                          context,
                          '/biopesticides').then((_) => setState(() {}));
                    },
                    child: Container(
                        width : 160,
                        height: 120,
                        color: Color.fromRGBO(203, 251, 219, 0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('Assets/Image/bio pesticide icon.png',height: 80,color: Colors.green,),
                            Text("BioPesticide")
                          ],
                        )
                    ),
                  )
                        ],
                      )
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap : (){
                      Navigator.pushReplacementNamed(
                          context,
                          '/weather_forecast_loader');
                    },
                    child: Container(
                        width : 160,
                        height: 120,
                        color: Color.fromRGBO(203, 251, 219, 0.7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('Assets/Image/weather forecast icon.png',height: 80,color: Colors.green,),
                            Text("Weather Forecasting")
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
          ),
      )
    );

}