import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.of(context).pop();
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.of(context).pop(); },),
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("Liked Products", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            shoptheme.favorite(context,0)
          ],
        ),
      ),
    )
    );
  }
}

shopTheme shoptheme = new shopTheme();
