import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: ImageSlideshow(
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

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: [
            Image.asset(
              'Assets/Image/01d.png',
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              'Assets/Image/01n.png',
              fit: BoxFit.fitHeight,
            ),
            Image.asset(
              'Assets/Image/02d.png',
              fit: BoxFit.fitHeight,
            ),
          ],

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
            print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 3000,

          /// Loops back to first slide.
          isLoop: true,
        ),
      ),
    );
  }
}