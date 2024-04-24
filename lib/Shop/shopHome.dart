import 'dart:convert';

import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class shopHomeSpinner extends StatefulWidget {
  const shopHomeSpinner({Key? key}) : super(key: key);

  @override
  State<shopHomeSpinner> createState() => _shopHomeSpinnerState();
}

class _shopHomeSpinnerState extends State<shopHomeSpinner> {

  String? language;
  int _selectedIndex = 2;

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  String Shop = "Shop";

  String name = "none";
  String email = "none";


  Future getlanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();

    if(language == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

      setState(() {

      });

    }
    else if(language == "hindi") {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      setState(() {

      });
    }

    fetchProductData();
  }

  Future fetchProductData() async
  {
    try {
      var url = Uri.parse("https://agrinfo.000webhostapp.com/shopHome.php");

      var response = await http.post(url,body: {
        'language' : language
      });
      var shopHomeData;

      if (response.body.isNotEmpty) {
        shopHomeData = jsonDecode(response.body);
        if(shopHomeData != null){
          Navigator.pushNamed(context,'/shopHome',arguments: shopHomeData);
        }

      }
    }
    catch (e) {
      print(e);
      print("Shop Product data fetching error");
      Navigator.pushNamed(context,'/home');
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
  void initState() {
    // TODO: implement initState
    getlanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Data = ModalRoute.of(context)?.settings.arguments;
    if(Data == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";
      shop = "दुकान";

    }
    else if(Data == "hindi") {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";
      shop = "दुकान";
    }

    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/home');
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
                  "$shop", style: TextStyle(color: Colors.black),),
              ),
            ],
          )
      ),

      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.green),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black45,
        elevation: 20,
        iconSize: 24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_home.png',)), SizedBox(height: 4.0),],), label: '$home',),
          BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/expenses.png',)), SizedBox(height: 4.0),],), label: '$expense',),
          BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_shop.png',)), SizedBox(height: 4.0),],), label: '$shop',),
          BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_crop.png',)), SizedBox(height: 4.0),],), label: '$crop',),
          BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_setting.png',)), SizedBox(height: 4.0),],), label: '$settings',),
        ],
      ),
    )
    );
  }
}

class shopHome extends StatefulWidget {
  const shopHome({Key? key}) : super(key: key);

  @override
  State<shopHome> createState() => _shopHomeState();
}

List<String> price = [];
var language;

String Shop = "Shop";

// Categories variables
String categoriesTitle = "Categories";
String categoriesAllProduct = "All Products";
String categoriesCropTonics = "Crop Tonics";
String categoriesFertilizer = "Fertilizer";

// Best Product variables
String bestProductsCategories = "Best Products";
String bestProductsAll = "View ALL";
String ProductsLikes = "Likes";
class _shopHomeState extends State<shopHome> {

  int _selectedIndex = 2;
  var Data;
  List<String> productName = [];
  List<String> imgsrc = [];
  List<String> likes = [];

  // Best Product variables
  String recommendedProductsCategories = "Recommended Products";
  String recommendedProductsAll = "View ALL";

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  Future setDataOnLanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();

    if(language == "marathi")
    {
      // Categories variables
      categoriesTitle = "श्रेणी";
      categoriesAllProduct = "सर्व उत्पादने";
      categoriesCropTonics = "पीक टॉनिक";
      categoriesFertilizer = "खत";

      // Best Product variables
        bestProductsCategories = "सर्वोत्तम उत्पादने";
        bestProductsAll = "सर्व पहा";
        ProductsLikes = "Likes";

      // Best Product variables
        recommendedProductsCategories = "शिफारस केलेली उत्पादने";
        recommendedProductsAll = "सर्व पहा";

      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

        Shop = "दुकान";

        setState(() {});
    }
    else if(language == "hindi")
    {
      // Categories variables
        categoriesTitle = "श्रेणियाँ";
        categoriesAllProduct = "सभी प्रोडक्ट";
        categoriesCropTonics = "फसल टॉनिक";
        categoriesFertilizer = "उर्वरक";

      // Best Product variables
        bestProductsCategories = "सर्वश्रेष्ठ प्रोडक्ट";
        bestProductsAll = "सभी को देखें";
        ProductsLikes = "Likes";

      // Best Product variables
        recommendedProductsCategories = "सिफ़ारिश किये हुए उत्पाद";
      recommendedProductsAll = "सभी को देखें";

        Shop = "दुकान";

        // Bottom Tab variables
        home = "होम";
        expense = "खर्च";
        shop = "दुकान";
        crop = "फसल";
        settings = "सेटिंग्ज";

        setState(() {});
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

  String name = "none";
  String email = "none";

  Future getUserProfileData() async
  {
    var prefUserProfile = await SharedPreferences.getInstance();
    name = prefUserProfile.getString("UserName").toString();
    email = prefUserProfile.getString("UserEmail").toString();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserProfileData();
    setDataOnLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Data = ModalRoute.of(context)?.settings.arguments;
    productName.add(Data[0]['product_name']);
    productName.add(Data[1]['product_name']);
    productName.add(Data[2]['product_name']);
    productName.add(Data[3]['product_name']);
    imgsrc.add(Data[0]['product_imgsrc1']);
    imgsrc.add(Data[1]['product_imgsrc1']);
    imgsrc.add(Data[2]['product_imgsrc1']);
    imgsrc.add(Data[3]['product_imgsrc1']);
    likes.add(Data[0]['likes']);
    likes.add(Data[1]['likes']);
    likes.add(Data[2]['likes']);
    likes.add(Data[3]['likes']);
    price.add(Data[0]['price']);
    price.add(Data[1]['price']);
    price.add(Data[2]['price']);
    price.add(Data[3]['price']);

    // print(productName);
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // build your widget tree here
          return WillPopScope(
              onWillPop: () async {
                Navigator.pushNamed(context, '/home');
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 0,
                    titleSpacing: 0,
                    iconTheme: IconThemeData(color: Colors.black54, size: 30),
                    actions: [
                      IconButton(onPressed: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                          icon: ImageIcon(AssetImage('Assets/Image/bell.png'),
                              color: Colors.black),
                          iconSize: 22,
                          color: Colors.black,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          constraints: BoxConstraints()),
                      IconButton(onPressed: () {
                        Navigator.pushNamed(context, '/shopFavorite');
                      },
                          icon: ImageIcon(AssetImage('Assets/Image/heart.png'),
                              color: Colors.black),
                          iconSize: 22,
                          color: Colors.black,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          constraints: BoxConstraints()),
                      SizedBox(width: 5,)
                    ],
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("$Shop", style: TextStyle(color: Colors
                              .black),),
                        ),
                      ],
                    )
                ),

                drawer: Drawer(
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text("$name"),
                        accountEmail: Text("$email"),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage('Assets/Image/user.png'),
                          radius: 70,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(94, 143, 134, 1.0),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle,color: Colors.black54,size: 30,),
                        title: Text("My Account"),
                        onTap: () {
                          Navigator.pushNamed(context, '/userProfile');
                        },
                      ),
                      ListTile(
                        leading: Image.asset('Assets/Image/like.png',height: 25,color: Colors.black54,),
                        title: Text("My Favorites"),
                        onTap: () {
                          Navigator.pushNamed(context, '/shopFavorite');
                        },
                      ),
                      ListTile(
                        leading: Image.asset('Assets/Image/notification.png',height: 25,color: Colors.black54,),
                        title: Text("Notifications"),
                        onTap: () {
                          Navigator.pushNamed(context, '/notification');
                        },
                      ),
                      ListTile(
                        leading: Image.asset('Assets/Image/save_for_later_filled.png',height: 25,color: Colors.black54,),
                        title: Text("Saved for Later"),
                        onTap: () {
                          Navigator.pushNamed(context, '/savedDisease');
                        },
                      ),
                      ListTile(
                        leading: Image.asset('Assets/Image/about_us.png',height: 25,color: Colors.black54,),
                        title: Text("About Us"),
                        onTap: () {
                          // Navigator.pushReplacementNamed(context, '/shopCart');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.language),
                        title: Text("Language"),
                        onTap: () {
                          Navigator.pushNamed(context, '/language');
                        },
                      ),
                    ],
                  ),
                ),

                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Color.fromRGBO(199, 237, 210, 0.1),
                        height: 180,

                        /// ****************** Categories Container ***************** ///
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              child: Text("$categoriesTitle", style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(child: Column(
                                  children: [
                                    IconButton(onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, '/allProductsSpinner');
                                    },
                                      icon: Image.asset(
                                        'Assets/Image/menu.png',width: 80,)),
                                    Text("$categoriesAllProduct",
                                      style: TextStyle(fontSize: 15,
                                          fontWeight: FontWeight.bold),)
                                  ],
                                )
                                ),
                                Expanded(child: Column(
                                  children: [
                                    IconButton(onPressed: () {
                                      // Navigator.popAndPushNamed(
                                      //     context, '/cropTonics',arguments: language);
                                    },
                                      icon: Image.asset(
                                        'Assets/Image/crop tonics.png',width: 80,),
                                      iconSize: 10,),
                                    Text("$categoriesCropTonics",
                                      style: TextStyle(fontSize: 15,
                                          fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                ),
                                Expanded(child: Column(
                                  children: [
                                    IconButton(onPressed: () {
                                      // Navigator.popAndPushNamed(
                                      //     context, '/cropFertilizer');
                                    },
                                      icon: Image.asset(
                                        'Assets/Image/fertilizer.png',width: 80,),
                                      iconSize: 10,),
                                    Text("$categoriesFertilizer",
                                      style: TextStyle(fontSize: 15,
                                          fontWeight: FontWeight.bold),)
                                  ],
                                )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Color.fromRGBO(199, 237, 210, 0.1),
                        height: 350,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              child: Row(
                                children: [
                                  Expanded(child: Text("$bestProductsCategories",
                                      style: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                      flex: 4),
                                  Expanded(child: InkWell(onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, '/bestProductsSpinner',arguments: language);
                                  },
                                      child: Text("$bestProductsAll", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                          decoration: TextDecoration
                                              .underline))))
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                shoptheme.Product(
                                    context, productName[0], price[0], likes[0],
                                    imgsrc[0]),
                                Expanded(flex: 1, child: Container(),),
                                shoptheme.Product(
                                    context, productName[1], price[1], likes[1],
                                    imgsrc[1]),
                              ],
                            ),
                          ],
                        ),
                      ),


                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Color.fromRGBO(199, 237, 210, 0.1),
                        height: 350,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              child: Row(
                                children: [
                                  Expanded(child: Text("$recommendedProductsCategories",
                                      style: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                      flex: 4),
                                  Expanded(child: InkWell(onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, '/recommendedProductsSpinner',arguments: language);
                                  },
                                      child: Text("$recommendedProductsAll", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrange,
                                          decoration: TextDecoration
                                              .underline))))
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                shoptheme.Product(
                                    context, productName[2], price[2], likes[2],
                                    imgsrc[2]),
                                Expanded(flex: 1, child: Container(),),
                                shoptheme.Product(
                                    context, productName[3], price[3], likes[3],
                                    imgsrc[3]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                  currentIndex: _selectedIndex,
                  onTap: _navigateBottomBar,
                  type: BottomNavigationBarType.fixed,
                  selectedIconTheme: IconThemeData(color: Colors.green),
                  selectedFontSize: 13,
                  unselectedFontSize: 13,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                  // showSelectedLabels: false,
                  // showUnselectedLabels: false,
                  selectedItemColor: Colors.green,
                  unselectedItemColor: Colors.black45,
                  elevation: 20,
                  iconSize: 24,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_home.png',)), SizedBox(height: 4.0),],), label: '$home',),
                    BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/expenses.png',)), SizedBox(height: 4.0),],), label: '$expense',),
                    BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_shop.png',)), SizedBox(height: 4.0),],), label: '$shop',),
                    BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_crop.png',)), SizedBox(height: 4.0),],), label: '$crop',),
                    BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_setting.png',)), SizedBox(height: 4.0),],), label: '$settings',),
                  ],
                ),
              )
          );
        }
        else {
          // show a loading indicator or placeholder widget while waiting
          return
            WillPopScope(
              onWillPop: () async {
            Navigator.pushNamed(context, '/shopHome');
            return true;
          },
           child:Scaffold(
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
                        "$Shop", style: TextStyle(color: Colors.black),),
                    ),
                  ],
                )
            ),
            body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              currentIndex: _selectedIndex,
              onTap: _navigateBottomBar,
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(color: Colors.green),
              selectedFontSize: 13,
              unselectedFontSize: 13,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black45,
              elevation: 20,
              iconSize: 24,
              items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_home.png',)), SizedBox(height: 4.0),],), label: '$home',),
        BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/expenses.png',)), SizedBox(height: 4.0),],), label: '$expense',),
        BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_shop.png',)), SizedBox(height: 4.0),],), label: '$shop',),
        BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_crop.png',)), SizedBox(height: 4.0),],), label: '$crop',),
        BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_setting.png',)), SizedBox(height: 4.0),],), label: '$settings',),
           ] ),
          )
            );
        }
      }
    );
  }
}

shopTheme shoptheme = new shopTheme();
