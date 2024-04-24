
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.of(context).pop(); },),
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("Notifications", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            shoptheme.notification(context,0)
          ],
        ),
      ),

    );
  }
}

shopTheme shoptheme = new shopTheme();
