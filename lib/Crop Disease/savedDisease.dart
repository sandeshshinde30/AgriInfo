import 'package:agri_info/Crop%20Disease/cropDiseaseTheme.dart';
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class savedDisease extends StatefulWidget {
  const savedDisease({Key? key}) : super(key: key);

  @override
  State<savedDisease> createState() => _savedDiseaseState();
}

class _savedDiseaseState extends State<savedDisease> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 255, 247, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.of(context).pop(); },),
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("Saved Crop Disease", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            cropDiseaseTheme().savedCropDisease(context,0,"Wilt")
          ],
        ),
      ),

    );
  }
}

shopTheme shoptheme = new shopTheme();

