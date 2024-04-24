import 'dart:convert';

import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class recommendedProductsSpinner extends StatefulWidget {
  const recommendedProductsSpinner({Key? key}) : super(key: key);

  @override
  State<recommendedProductsSpinner> createState() => _recommendedProductsSpinnerState();
}

class _recommendedProductsSpinnerState extends State<recommendedProductsSpinner> {
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
      var url = Uri.parse("https://agrinfo.000webhostapp.com/showRecommendedProduct.php");

      var response = await http.post(url,body: {
        'language' : language
      });
      var shopAllProductsData;

      if (response.body.isNotEmpty) {
        shopAllProductsData = jsonDecode(response.body);
        if(shopAllProductsData != null){
          shopAllProductsData[0]["language"] = language;
          Navigator.pushNamed(context,'/recommendedProducts',arguments: shopAllProductsData);
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

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Navigator.popAndPushNamed(context, '/home');
      }
      else if (_selectedIndex == 1) {
        Navigator.pushNamed(context,'/expenseSpinner');
      }
      else if (_selectedIndex == 2) {
        Navigator.popAndPushNamed(context, '/shopHomeSpinner');
      }
      else if (_selectedIndex == 3) {
        Navigator.popAndPushNamed(context, '/cropDisease');
      }
      else if(_selectedIndex == 4)
      {
        Navigator.popAndPushNamed(context,'/settings');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments;
    var title = "Shop Recommended Products";
    if(data == "marathi")
    {
      title = "शिफारस केलेली उत्पादने";
    }
    if(data == "hindi" )
    {
      title = "अनुशंसित उत्पादों";
    }
    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/shopHomeSpinner');
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          elevation: 0,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.black54, size: 30),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "$title", style: TextStyle(color: Colors.black),),
              ),
            ],
          )
      ),
      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      //   currentIndex: _selectedIndex,
      //   onTap: _navigateBottomBar,
      //   type: BottomNavigationBarType.fixed,
      //   selectedIconTheme: IconThemeData(color: Colors.green),
      //   selectedFontSize: 13,
      //   unselectedFontSize: 13,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      //   // showSelectedLabels: false,
      //   // showUnselectedLabels: false,
      //   selectedItemColor: Colors.green,
      //   unselectedItemColor: Colors.black45,
      //   elevation: 20,
      //   iconSize: 24,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(AssetImage('Assets/Image/tab_home.png',)),
      //         label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(AssetImage('Assets/Image/expenses.png')),
      //         label: "Expense"),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(AssetImage('Assets/Image/tab_shop.png')),
      //         label: "Shop"),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(AssetImage('Assets/Image/tab_crop.png')),
      //         label: "Crop"),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(AssetImage('Assets/Image/tab_setting.png')),
      //         label: "Settings"),
      //   ],
      // ),
    )
    );
  }
}

class recommendedProducts extends StatefulWidget {
  const recommendedProducts({Key? key}) : super(key: key);

  @override
  State<recommendedProducts> createState() => _recommendedProductsState();
}

class _recommendedProductsState extends State<recommendedProducts> {

  var Data;
  List<String> productName = [];
  List<String> imgsrc = [];
  List<String> likes = [];
  List<String> price = [];
  var length;
  var language;

  @override
  Widget build(BuildContext context) {
    Data = ModalRoute.of(context)?.settings.arguments;
    length = Data.length;
    language = Data[0]["language"];
    var title = "Recommended";
    if(language == "marathi")
    {
      title = "शिफारस केलेली उत्पादने";
    }
    if(language == "hindi" )
    {
      title = "अनुशंसित उत्पादों";
    }

    for(int i=0;i<length;i++)
    {
      productName.add(Data[i]['product_name']);
      price.add(Data[i]['price']);
      likes.add(Data[i]['likes']);
      imgsrc.add(Data[i]['product_imgsrc1']);
    }
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
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/notification');
          }, icon: ImageIcon(AssetImage('Assets/Image/bell.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopFavorite');
          }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
        ],

        title: Text("$title", style: TextStyle(color: Colors.black,),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(199, 237, 210,0.1),
              height: MediaQuery.of(context).size.height,
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
