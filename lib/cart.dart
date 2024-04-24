import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.of(context).pop(); },),
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("Cart", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            shoptheme.cart(context,0)
            ],
        ),
      ),

    );
  }
}

shopTheme shoptheme = new shopTheme();
