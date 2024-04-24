

import 'dart:convert';

import 'package:agri_info/Shop/shopTheme.dart';
import 'package:agri_info/Crop%20Disease/cropDiseaseTheme.dart';
import 'package:agri_info/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class cropDisease extends StatefulWidget {
  const cropDisease({Key? key}) : super(key: key);

  @override
  State<cropDisease> createState() => _cropDiseaseState();
}

class _cropDiseaseState extends State<cropDisease> {

  TextEditingController search = TextEditingController();
  String val = "Nothing";
  bool s = false;

  int _selectedIndex = 3;
  int notfound = 0;

  var cropDiseaseName;
  var cropDiseaseImg;
  var searchData;
  var isfound;
  String language = "english";

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  String title = "Crop Disease Information";
  String searchtxt = "Enter crop name";

  Future getlanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);


    if(language == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

      title = "पिकावरील रोगाची माहिती";
      searchtxt = "तुमच्या पिकाचे नाव टाका";

      setState(() {});

    }
    else if(language == "hindi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      title = "फसल रोग की जानकारी";
      searchtxt = "अपने फसल का नाम डाले";

      setState(() {});
    }

  }

  Future searchCropDisease() async
  {
    try {
      var url = Uri.parse("https://agrinfo.000webhostapp.com/searchCropDisease.php");

      var response = await http.post(url, body: {
        'cropName': search.text.trim(),
        'language' : language
      });



      if(response.body.isNotEmpty) {

        searchData = jsonDecode(response.body);

        if(searchData == "no records") {
          isfound = 0;
          Navigator.pop(context);
          setState(() {});
        }
        else
          {
            cropDiseaseName = searchData[0]['diseaseName'];
            cropDiseaseImg = searchData[0]['diseasephotoPath1'];
            isfound = 1;
            Navigator.pop(context);
            setState(() {});
          }
      }

    }
    catch(e)
    {
      print(e);
    }
  }

  

  void _navigateBottomBar(int index){
    setState((){
      _selectedIndex = index;

      if(_selectedIndex == 0)
      {
        Navigator.popAndPushNamed(context,'/home');
      }
      else if(_selectedIndex == 1)
      {
        Navigator.pushNamed(context,'/expenseSpinner');
      }
      else if(_selectedIndex == 2)
      {
        Navigator.popAndPushNamed(context,'/shopHomeSpinner');
      }
      else if(_selectedIndex == 3)
      {
        Navigator.popAndPushNamed(context,'/cropDisease');
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
    getlanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {Navigator.pushNamed(context,'/home');return true;},

    child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255,255,255, 1),
          elevation: 0,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.black54,size: 30),
          title: Text("$title", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/savedDisease');
            }, icon: ImageIcon(AssetImage('Assets/Image/save_for_later_filled.png'),size: 25,color: Colors.black87,),)
          ],
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: CupertinoSearchTextField(
                    controller: search,
                    itemSize: 25,
                    placeholder: "$searchtxt",
                    itemColor: Colors.black87,
                    prefixInsets: EdgeInsets.only(left: 15),
                    padding: EdgeInsets.all(15),
                    prefixIcon: Icon(Icons.search),
                    style: TextStyle(fontSize: 17),
                    onChanged: (value) {
                      isfound = 2;
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      searchCropDisease();
                      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                      setState(() {});
                    },
                    onSuffixTap: (){
                      FocusScope.of(context).unfocus();
                      search.text = "";
                      setState(() {});
                      isfound = 2;
                    },
                    autocorrect: true,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              // Container(
              //   color: Color.fromRGBO(199, 237, 210,0.3),
              //   height: 190,
              //   width: double.maxFinite,
              //   child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10,top: 10),
              //             child: Text("Recent >>",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Row(
              //               children: [
              //                 if(isfound == 1)
              //                   cropDiseaseTheme().cropCircle(context,cropDiseaseName,cropDiseaseImg),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              // ),

              if(isfound == 1)
                cropDiseaseTheme().showDisease(language,context,cropDiseaseName,cropDiseaseImg),

               if(isfound == 0)
                  cropDiseaseTheme().notFound(),

            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(255,255,255,1),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Colors.green),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black45,
          elevation: 20,
          iconSize: 24,
          // ImageIcon(AssetImage('Assets/Image/tab_home.png',))

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_home.png',)), SizedBox(height: 4.0),],), label: '$home',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/expenses.png',)), SizedBox(height: 4.0),],), label: '$expense',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_shop.png',)), SizedBox(height: 4.0),],), label: '$shop',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_crop.png',)), SizedBox(height: 4.0),],), label: '$crop',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_setting.png',)), SizedBox(height: 4.0),],), label: '$settings',),
          ],
        )
    )
    );
}


