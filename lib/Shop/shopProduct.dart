import 'dart:async';
import 'dart:convert';
import 'package:agri_info/App%20Theme/main2.dart';
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class shopProductSpinner extends StatefulWidget {
  const shopProductSpinner({Key? key}) : super(key: key);

  @override
  State<shopProductSpinner> createState() => _shopProductSpinnerState();
}

class _shopProductSpinnerState extends State<shopProductSpinner> {

  String? language;
  int _selectedIndex = 2;
  var productName;

  Future getlanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);
    fetchProductData();
  }

  Future fetchProductData() async
  {
    try {
      var url = Uri.parse("https://agrinfo.000webhostapp.com/showShopProduct.php");

      var response = await http.post(url,body: {
        'language' : language,
        'productName' : productName
      });
      var productData;

      if (response.body.isNotEmpty) {
        productData = jsonDecode(response.body);
        if(productData != null){
          productData["language"] = language;
          Navigator.pushNamed(context,'/shopProduct',arguments: productData);
        }
      }
    }
    catch (e) {
      print(e);
      print("Shop Product data fetching error");
    }
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
        Navigator.popAndPushNamed(context, '/shopHome');
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
  void initState() {
    // TODO: implement initState
    getlanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productName = ModalRoute.of(context)?.settings.arguments;
    print(productName);
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
                  "Shop", style: TextStyle(color: Colors.black),),
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

class shopProduct extends StatefulWidget {
  const shopProduct({Key? key}) : super(key: key);

  @override
  State<shopProduct> createState() => _shopProductState();
}

class _shopProductState extends State<shopProduct> {
  var shopProductAllData;
  var productName;
  var availabe_quantities;
  var quantity_type;
  var productPrice;
  var isAvailable;
  var about_product;
  var suitable_crops;
  var description;
  var composition;
  var dosage;
  List<String> productImg = [];
  var referance_link;
  var language;



  @override
  Widget build(BuildContext context) {
    var Data = ModalRoute.of(context)?.settings.arguments;
    shopProductAllData = Data;
    // print(shopProductAllData);
    productName = shopProductAllData['product_name'];
    productImg.add(shopProductAllData['product_imgsrc1'].toString());
    productImg.add(shopProductAllData['product_imgsrc2'].toString());
    productImg.add(shopProductAllData['product_imgsrc3'].toString());
    productImg.add(shopProductAllData['product_imgsrc4'].toString());
    productPrice = double.parse(shopProductAllData['price']);
    isAvailable = shopProductAllData['available'];
    availabe_quantities = shopProductAllData['available_quantity'];
    about_product = shopProductAllData['about_product'];
    description = shopProductAllData['description'];
    suitable_crops = shopProductAllData['suitable_crops'];
    composition = shopProductAllData['composition'];
    dosage = shopProductAllData['dosage'];
    referance_link = shopProductAllData['referance_link'];
    quantity_type = shopProductAllData['quantity_type'];
    language = shopProductAllData['language'];
    // print("Show product language : $language");
    // print(shopProductAllData);



    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/shopHomeSpinner');
      return true;
    },
    child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255,255,255, 1),
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.pushNamed(context,'/shopHomeSpinner'); },),
          iconTheme: IconThemeData(color: Colors.black54,size: 22),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/notification');
            }, icon: ImageIcon(AssetImage('Assets/Image/bell.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
            IconButton(onPressed: (){
              Navigator.pushNamed(context,'/shopFavorite');
            }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          ],

          title: Text(productName, style: TextStyle(color: Colors.black),),
        ),

        body: SingleChildScrollView(
            child:shoptheme.shopProduct(language,context,productImg,productName,availabe_quantities,quantity_type,productPrice,isAvailable,about_product,suitable_crops,description,composition,dosage,referance_link)
        ),

        bottomNavigationBar: BottomAppBar(
          height: 60,
          color: Color.fromRGBO(199, 237, 210,1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text('\u{20B9}${productPrice}',style: TextStyle(fontSize: 18 ,wordSpacing: 2 , fontWeight: FontWeight.bold,)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(onPressed: (){}, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
                    child: Text("MAKE FAVORITE",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                  ),),
              ),
            ],
          ),
        )
    )
    );
  }
}



shopTheme shoptheme = new shopTheme();