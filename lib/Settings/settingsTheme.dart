

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class settingsTheme{

  Container divider([double top = 10 , double bottom = 10])
  {
    return Container(
      color: Colors.black12,
      height: 1,
      margin: EdgeInsets.only(top: top,bottom: bottom),
    );
  }

  TextButton settingFields([String title = "none"])
  {
    return TextButton(
        onPressed: (){},
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(title,style: TextStyle(fontSize: 16),),
            ),
          ],
        )
    );
  }

  Column userProfileFields(String title , TextEditingController Controller)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left : 15),
          child: Text(title,style: TextStyle(fontSize: 15),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(title == "Name" || title == "नाव" || title == "नाम")
             Icon(Icons.account_circle,color: Colors.deepOrange,size: 30,),
            if(title == "Phone" || title == "फोन" || title == "फ़ोन" )
              Icon(Icons.phone,color: Colors.deepOrange,size: 30,),
            if(title == "Email" || title == "ईमेल")
              Icon(Icons.email_outlined,color: Colors.deepOrange,size: 30,),
            if(title == "State" || title == "राज्य")
              Icon(Icons.location_on_outlined,color: Colors.deepOrange,size: 30,),
            Container(width: 1,color: Colors.black12,height: 30,),

            if(title == "Name" || title == "नाव" || title == "नाम")
              Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)
                    ),
                    controller: Controller,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.name,
                  )
              ),
            if(title == "Phone" || title == "फोन" || title == "फ़ोन" )
              Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)
                    ),
                    controller: Controller,
                    cursorColor: Colors.black,
                    enabled: false,
                    cursorHeight: 25,
                    keyboardType: TextInputType.phone,
                  )
              ),
            if(title == "Email" || title == "ईमेल")
              Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)
                    ),
                    controller: Controller,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.emailAddress,
                  )
              ),
            if(title == "State" || title == "राज्य")
              Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)
                    ),
                    controller: Controller,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.text,
                  )
              )
          ],
        ),
        Container(
          height: 1,
          margin: EdgeInsets.only(left: 15,right: 15),
          color: Colors.black12,
        )
      ],
    );
  }

  void showToast([String msg = "Nothing"]) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(15, 105, 13, 1.0),
        textColor: Colors.white
    );
  }
}