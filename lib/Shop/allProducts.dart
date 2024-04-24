import 'dart:convert';

import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class allProductsSpinner extends StatefulWidget {
  const allProductsSpinner({Key? key}) : super(key: key);

  @override
  State<allProductsSpinner> createState() => _allProductsSpinnerState();
}

class _allProductsSpinnerState extends State<allProductsSpinner> {
  String? language;
  int _selectedIndex = 2;

  Future getlanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);
    fetchAllProductData();
  }

  Future fetchAllProductData() async
  {
    try {
      var url = Uri.parse("https://agrinfo.000webhostapp.com/showAllProducts.php");

      var response = await http.post(url,body: {
        'language' : language
      });
      var shopAllProductsData;

      if (response.body.isNotEmpty) {
        shopAllProductsData = jsonDecode(response.body);
        if(shopAllProductsData != null){
          shopAllProductsData[0]["language"] = language;
          // print(shopAllProductsData);
          Navigator.pushNamed(context,'/allProducts',arguments: shopAllProductsData);
        }
      }
    }
    catch (e) {
      print(e);
      print("Shop All Product data fetching error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getlanguage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/shopHomeSpinner');
      return true;
    },
    child: Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      //     elevation: 0,
      //     titleSpacing: 0,
      //     iconTheme: IconThemeData(color: Colors.black54, size: 30),
      //     title: Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 10),
      //           child: Text(
      //             "Shop All Products", style: TextStyle(color: Colors.black),),
      //         ),
      //       ],
      //     )
      // ),
      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
    )
    );
  }
}


class allProducts extends StatefulWidget {
  const allProducts({Key? key}) : super(key: key);

  @override
  State<allProducts> createState() => _allProductsState();
}

class _allProductsState extends State<allProducts> {

  var Data;
  List<String> productName = [];
  List<String> imgsrc = [];
  List<String> likes = [];
  List<String> price = [];
  var length;
  var language;
  String allProducts = "All Products";

  void setDataOnLanguage() async
  {

  }

  @override
  void initState() {
    // TODO: implement initState
    setDataOnLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data = ModalRoute.of(context)?.settings.arguments;
    length = Data.length;
    language = Data[0]['language'];
    print("Given Language : $language");
    for(int i=0;i<length;i++)
      {
        productName.add(Data[i]['product_name']);
        price.add(Data[i]['price']);
        likes.add(Data[i]['likes']);
        imgsrc.add(Data[i]['product_imgsrc1']);
      }

    if(language == "marathi")
    {
      allProducts = "सर्व उत्पादने";
    }
    else if(language == "hindi")
    {
      allProducts = "सभी प्रोडक्ट";
    }

    print(Data);

    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/shopHomeSpinner');
      return true;
    },
    child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255,255,255, 1),
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.popAndPushNamed(context,'/shopHomeSpinner'); },),
          iconTheme: IconThemeData(color: Colors.black54,size: 22),
          // actions: [
          //   IconButton(onPressed: (){
          //     Navigator.pushNamed(context, '/search');
          //   }, icon: ImageIcon(AssetImage('Assets/Image/search.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),constraints: BoxConstraints()),
          //   IconButton(onPressed: (){
          //     Navigator.pushNamed(context, '/notification');
          //   }, icon: ImageIcon(AssetImage('Assets/Image/bell.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          //   IconButton(onPressed: (){
          //     Navigator.pushNamed(context,'/shopFavorite');
          //   }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          //   IconButton(onPressed: (){
          //     Navigator.pushNamed(context,'/shopCart');
          //   }, icon: ImageIcon(AssetImage('Assets/Image/cart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),constraints: BoxConstraints()),
          //   SizedBox(width: 5,)
          // ],

          title: Text("$allProducts", style: TextStyle(color: Colors.black),),
        ),


        body: SingleChildScrollView(
          child: Column(
            children: [
          Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(199, 237, 210,0.1),
          child: Column(
            children: [
              SizedBox(height: 15,),
                  for(int i=0;i<length;i+=2)
                    shoptheme.allProducts(context,productName[i],productName[i+1],price[i],price[i+1],likes[i],likes[i+1],imgsrc[i],imgsrc[i+1])
            ],
          ),
        )

            ],
          ),
        ),
    )
    );
  }
}

shopTheme shoptheme = new shopTheme();
