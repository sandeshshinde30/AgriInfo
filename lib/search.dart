import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  TextEditingController search = TextEditingController();
  String val = "Nothing";
  bool s = false;

  int _selectedIndex = 1;

  void _navigateBottomBar(int index){
    setState((){
      _selectedIndex = index;

      if(_selectedIndex == 0)
      {
        Navigator.popAndPushNamed(context,'/home');
      }
      else if(_selectedIndex == 1)
      {
        Navigator.pushNamed(context,'/search');
      }
      else if(_selectedIndex == 2)
      {
        Navigator.popAndPushNamed(context,'/shopHome');
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

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {Navigator.pushNamed(context,'/home');return true;},

      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("Search", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopFavorite');
          }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),iconSize:25,color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopCart');
          }, icon: ImageIcon(AssetImage('Assets/Image/cart.png')),iconSize: 25,color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 10),constraints: BoxConstraints()),
        ],
      ),

      drawer: Drawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: CupertinoSearchTextField(
                  controller: search,
                  itemSize: 25,
                  placeholder: "Search product or crop",
                  itemColor: Colors.black87,
                  prefixInsets: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.search),
                  style: TextStyle(fontSize: 17),
                  onChanged: (value) {
                    setState(() {
                    });
                  },
                  onSubmitted: (value) {},
                  onSuffixTap: (){
                    FocusScope.of(context).unfocus();
                    search.text = "";
                    setState(() {});
                  },
                  autocorrect: true,
                ),
              ),
            ),
            SizedBox(height: 250,),
            Center(
              child: Text(search.text,style: TextStyle(fontSize: 25),),
            )
          ],
        ),
      ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(255,255,255,1),
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
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/Image/tab_home.png',)),label:"Home"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/Image/expenses.png')),label: "Expense"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/Image/tab_shop.png')),label: "Shop"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/Image/tab_crop.png')),label: "Crop"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('Assets/Image/tab_setting.png')),label: "Settings"),
          ],
        )
    )
  );
  }

shopTheme shoptheme = new shopTheme();
