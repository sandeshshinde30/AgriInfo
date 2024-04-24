import 'package:agri_info/Shop/shopTheme.dart';
import 'package:agri_info/Settings/settingsTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {

  TextEditingController UserName = new TextEditingController();
  TextEditingController UserMob = TextEditingController();
  var lang;

  String val = "Nothing";
  bool s = false;
  String Language = "Sorry";
  int _selectedIndex = 4;

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  String languagetxt = "Language";
  String shareApp = "Share App";
  String RateApp = "Rate App";
  String privacyPolicy = "Privacy Policy";

  Future<void> getUserData()
  async {
    var prefUserProfile = await SharedPreferences.getInstance();
    UserName.text = prefUserProfile.getString("UserName").toString();
    UserMob.text = prefUserProfile.getString("UserMob").toString();
  }



  Future getLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    lang = preflanguage.getString('language').toString().toLowerCase();

    print(lang);

    if(lang == "marathi")
      {
        // Bottom Tab variables
        home = "होम";
        expense = "खर्च";
        shop = "दुकान";
        crop = "पीक";
        settings = "सेटिंग्ज";

         languagetxt = "भाषा";
         shareApp = "ॲप शेअर करा";
         RateApp = "ॲप रेट करा";
         privacyPolicy = "प्रायव्हसी पॉलसी";

         Language = "मराठी";

        setState(() {});
      }

    if(lang == "hindi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      languagetxt = "भाषा";
      shareApp = "ऐप शेअर कीजिए";
      RateApp = "ॲप रेट कीजिए";
      privacyPolicy = "प्रायव्हसी पॉलसी";

      Language = "हिंदी";

      setState(() {});
    }
  }


  Future<void> determineLanguage()
  async {
    var preflanguage = await SharedPreferences.getInstance();
    Language = preflanguage.getString('language').toString().toLowerCase();
    setState(() {});
  }

  Future<void> Logout()
  async {
    var prefCheckLogin = await SharedPreferences.getInstance();
    prefCheckLogin.setBool("LoginString",false);
    settingsTheme().showToast("Logout Successfull..");
    Navigator.pushNamed(context,'/');
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
    super.initState();
    determineLanguage();
    getUserProfileData();
    getUserData();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {Navigator.pushNamed(context,'/home');return true;},

      child:Scaffold(
          backgroundColor: Color.fromRGBO(244, 255, 247, 1.0),
          drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255,255,255, 1),
          elevation: 0,
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Colors.black54,size: 30),
          title: Text("$settings", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
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
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/userProfile');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('Assets/Image/user.png'),
                          radius: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              Text(UserName.text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),
                              Text(UserMob.text,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              settingsTheme().divider(30,10),
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/language');
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 15),
                         child: Text("$languagetxt ($Language)",style: TextStyle(fontSize: 16),),
                       ),
                       Icon(Icons.arrow_forward_ios_rounded)
                     ], 
                  )
              ),
              settingsTheme().divider(),
              settingsTheme().settingFields("$shareApp"),
              settingsTheme().divider(),
              settingsTheme().settingFields("$RateApp"),
              settingsTheme().divider(),
              settingsTheme().settingFields("$privacyPolicy"),
              settingsTheme().divider(),

              Padding(
                padding: const EdgeInsets.only(right: 20,top: 20),
                child: TextButton(onPressed: (){
                  Logout();
                }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
                    child: Text("Logout",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                  ),),
              ),
              ]
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

shopTheme shoptheme = new shopTheme();
