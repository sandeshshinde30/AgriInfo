import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class cropTonics extends StatefulWidget {
  const cropTonics({Key? key}) : super(key: key);

  @override
  State<cropTonics> createState() => _cropTonicsState();
}

class _cropTonicsState extends State<cropTonics> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.popAndPushNamed(context,'/shopHome'); },),
        iconTheme: IconThemeData(color: Colors.black54,size: 22),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/search');
          }, icon: ImageIcon(AssetImage('Assets/Image/search.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/notification');
          }, icon: ImageIcon(AssetImage('Assets/Image/bell.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopFavorite');
          }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopCart');
          }, icon: ImageIcon(AssetImage('Assets/Image/cart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),constraints: BoxConstraints()),
          SizedBox(width: 5,)
        ],

        title: Text("Crop Tonics", style: TextStyle(color: Colors.black),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            shoptheme.allProducts(context),
            shoptheme.allProducts(context),

          ],
        ),
      ),

    );
  }
}

shopTheme shoptheme = new shopTheme();
