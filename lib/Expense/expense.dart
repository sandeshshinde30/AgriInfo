import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Settings/settingsTheme.dart';
import 'expenseTheme.dart';
import 'package:http/http.dart' as http;

class ExpenseSpinner extends StatefulWidget {
  const ExpenseSpinner({Key? key}) : super(key: key);

  @override
  State<ExpenseSpinner> createState() => _ExpenseSpinnerState();
}

class _ExpenseSpinnerState extends State<ExpenseSpinner> {
  @override

  int _selectedIndex = 1;
  var expenseName = [];
  var expenseAmount = [];
  var expenseID = [];
  var length=0;
  double totAmount = 0 ;
  var noExpenses = "false";
  String? userEmail;
  var language;

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  Future setDataOnLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    print(language);

    if(language == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

      setState(() {});
    }

    if(language == "hindi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      setState(() {});
    }
  }

  Future getUserEmail() async
  {
    var prefUserProfile = await SharedPreferences.getInstance();
    userEmail = prefUserProfile.getString("UserEmail").toString();
    if(userEmail != null)
      {
        getExpense();
      }
  }

  Future getLanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
  }

  Future getExpense() async
  {
    var url = Uri.parse("https://agrinfo.000webhostapp.com/showExpense.php");

    try
    {
      var response = await http.post(url,body: {
        'userEmail' : userEmail
      });

      var expenseData;

      if(response.body.isNotEmpty)
      {
        expenseData = jsonDecode(response.body);
        length = expenseData.length;
        print(expenseData);
      }

      if(expenseData == "no records")
      {
        settingsTheme().showToast("No expenses");
        length = 0;
        noExpenses = "true";
        Navigator.pushNamed(context, "/expense");
        setState(() {});
      }
      else
      {
        for(int i=0;i<expenseData.length;i++)
        {
          expenseName.add(expenseData[i]['expenseName']);
          expenseAmount.add(expenseData[i]['expenseAmount']);
          expenseID.add(expenseData[i]['ID']);
          totAmount += double.parse(expenseData[i]['expenseAmount']) ;
        }
        var data = {
          'name' : expenseName,
          'amount' : expenseAmount,
          'totamount' : totAmount,
          'ID' : expenseID,
          'noExpenses' : noExpenses,
          'length' : length,
          'language' : language
        };
        // Timer(Duration(seconds:2),()=>Navigator.pushNamed(context,'/langSelect'));
        Timer(Duration(seconds:3),()=>Navigator.pushNamed(context, "/expense",arguments: data));
      }
    }
    catch(e)
    {
      print(e);
      expenseName.add("0");
      expenseAmount.add("0");
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
    setDataOnLanguage();
    getLanguage();
    getUserEmail();
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/home');
          return true;
        },
        child: Scaffold(
            drawerEnableOpenDragGesture: false,
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
                  "Expenses", style: TextStyle(color: Colors.black),),
              ),
            ],
          )
      ),
      drawer: Drawer(),
      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
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
}


class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  int _selectedIndex = 1;

  final items = ["Ploughing","Sowing","Incecticide"];

  var expenseData;

  var expenseName = [];
  var expenseAmount = [];
  var expenseID = [];
  var length=0;
  double totAmount = 0 ;
  var noExpenses = "false";

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";
  String title = "Expenses";
  String total = "Total";

  var language;

  Future setDataOnLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    print(language);

    if(language == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

      setState(() {});
    }

    if(language == "hindi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      setState(() {});
    }
  }

  Future getLanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    setState(() {});
    print("Expense language : $language");
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
  Widget build(BuildContext context) {

    var data = ModalRoute.of(context)?.settings.arguments;

    expenseData = data;

    if(language == "marathi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "पीक";
      settings = "सेटिंग्ज";

      title = "खर्च";
      total = "एकूण";

      setState(() {

      });

    }
    else if(language == "hindi")
    {
      // Bottom Tab variables
      home = "होम";
      expense = "खर्च";
      shop = "दुकान";
      crop = "फसल";
      settings = "सेटिंग्ज";

      title = "खर्च";
      total = "कुल";

      setState(() {

      });
    }

    if(expenseData != null)
      {
        expenseName = expenseData['name'];
        expenseAmount = expenseData['amount'];
        expenseID = expenseData['ID'];
        totAmount = expenseData['totamount'];
        noExpenses = expenseData['noExpenses'];
        length = expenseData['length'];
      }

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/home');
          return true;
        },
        child: Scaffold(
            drawerEnableOpenDragGesture: false,
            floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(20, 79, 22, 1),
            onPressed: () {
              Navigator.pushNamed(context, '/addexpense',arguments: language);
            },
          ),
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
                      "$expense", style: TextStyle(color: Colors.black),),
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


            body: RefreshIndicator(
              onRefresh: (){
                return Future.delayed(
                    Duration(seconds: 2),
                        (){
                      setState(() {});
                    });},
              child: SingleChildScrollView(
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15, top: 15),
                          height: 30,
                          child: Text("$total : \u{20B9}${totAmount}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),),
                        )
                      ],
                    ),
                    Container(height: 1,
                      color: Colors.black54,
                      margin: EdgeInsets.only(top: 10, bottom: 10),),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: length,
                        itemBuilder: (context, index) {
                          if(length != 0) {
                            return ExpenseTheme().expense(context,expenseName[index],expenseAmount[index],expenseID[index]);
                          }

                          if(noExpenses == "true")
                          Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                          child: Text("No Expenses", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                          ),
                          );

                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 1,
                            color: Colors.black45,
                          );
                        },


                      ),

                    ),
                    SizedBox(height: 50,)

                  ]
              ),
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
  }

