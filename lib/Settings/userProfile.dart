import 'dart:convert';

import 'package:agri_info/Settings/settingsTheme.dart';
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {

  int _selectedIndex = 4;
  TextEditingController UserName = new TextEditingController();
  TextEditingController UserMob = TextEditingController();
  TextEditingController UserEmail = TextEditingController();
  TextEditingController UserState = TextEditingController();
  var language;

  String name = "Name";
  String phone = "Phone";
  String email = "Email";
  String state = "State";
  String save = "SAVE CHANGES";
  String reset = "RESET";
  String myAccount = "My Account";
  String toastMsg = "Changes Saved Successfully";

  String? selectedState;

  List<String> states = [    'Select State',    'Andhra Pradesh',    'Arunachal Pradesh',    'Assam',    'Bihar',    'Chhattisgarh',    'Goa',    'Gujarat',    'Haryana',    'Himachal Pradesh',    'Jharkhand',    'Karnataka',    'Kerala',    'Madhya Pradesh',    'Maharashtra',    'Manipur',    'Meghalaya',    'Mizoram',    'Nagaland',    'Odisha',    'Punjab',    'Rajasthan',    'Sikkim',    'Tamil Nadu',    'Telangana',    'Tripura',    'Uttarakhand',    'Uttar Pradesh',    'West Bengal'  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage();
    getUserData();
    setState(() {});
  }

  Future getLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    print(language);
    if(language == "marathi")
      {
         name = "नाव";
         phone = "फोन";
         email = "ईमेल";
         state = "राज्य";
         save = "बदल जतन करा";
         reset = "रीसेट करा";
         myAccount = "माझे अकाउंट";
         toastMsg = "बदल यशस्वीरित्या सेव्ह झाले";
         setState(() {});

      }

    if(language == "hindi")
      {
        name = "नाम";
        phone = "फ़ोन";
        email = "ईमेल";
        state = "राज्य";
        save = "सेव चेंजेस";
        reset = "रीसेट करें";
        myAccount = "मेरा अकाउंट";
        toastMsg = "बदलाव सुरक्षित किया गया";
        setState(() {});
      }
  }

  Future updateProfile() async
  {
    try{
      var url = Uri.parse("https://agrinfo.000webhostapp.com/updateUserProfile.php");
      var response = await http.post(url,body: {
        'name' : UserName.text,
        'email' : UserEmail.text,
        'mob' : UserMob.text,
        'state' : UserState.text
      });

      var Data;

      if(response.body.isNotEmpty)
      {
        Data = jsonDecode(response.body);
      }

      if(Data == "true")
      {
        Navigator.pop(context);
        settingsTheme().showToast("$toastMsg");
      }
      else
      {
        Navigator.pop(context);
        settingsTheme().showToast("Error : Profile Updation");
      }
    }
    catch(e)
    {
      print(e);
      print("User profile updation error");
    }
  }



  Future<void> getUserData()
  async {
    var prefUserProfile = await SharedPreferences.getInstance();
    UserName.text = prefUserProfile.getString("UserName").toString();
    UserMob.text = prefUserProfile.getString("UserMob").toString();
    UserEmail.text = prefUserProfile.getString("UserEmail").toString();
    UserState.text = prefUserProfile.getString("UserState").toString();
    selectedState = prefUserProfile.getString("UserState").toString();
    setState(() {});
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
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
        },

      child:Scaffold(
        resizeToAvoidBottomInset: false,
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(255,255,255, 1),
            elevation: 0,
            titleSpacing: 0,
            iconTheme: IconThemeData(color: Colors.black54,size: 30),
            title: Text("$myAccount", style: TextStyle(color: Colors.black),),
            leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.of(context).pop(); },),
          ),

          body: SingleChildScrollView(
            child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                          SizedBox(
                            height: 200,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('Assets/Image/user.png'),
                            ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),
                            child: IconButton(
                                icon: Icon(Icons.add_a_photo_outlined),
                                  color : Colors.black,
                              onPressed:imagePickerOption ,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                    settingsTheme().userProfileFields("$name",UserName),
                    SizedBox(height: 15,),
                    settingsTheme().userProfileFields("$phone",UserMob),
                    SizedBox(height: 15),
                    settingsTheme().userProfileFields("$email",UserEmail),
                    SizedBox(height: 15,),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                                  Padding(
                                  padding: const EdgeInsets.only(left : 15),
                                  child: Text(state,style: TextStyle(fontSize: 15),),
                                  ),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                    Icon(Icons.location_on_outlined,color: Colors.deepOrange,size: 30,),
                                    Container(width: 1,color: Colors.black12,height: 30,),
                                Container(
                                    width: 300,
                                    child:Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: DropdownButton<String>(
                                          value: selectedState,
                                          hint: Text('Select a state'),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedState = newValue;
                                            });
                                          },
                                          items: states.map((String state) {
                                            return DropdownMenuItem<String>(
                                              value: state,
                                              child: Text(state),
                                            );
                                          }).toList(),
                                        ),
                                    ),
                                )
                              ],
                          ),
                    SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {
                          UserName.text = "";
                          UserMob.text = "";
                          UserEmail.text = "";
                          UserState.text = "";
                          setState(() {});

                        },
                          style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(
                              199, 23, 23, 1.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 7,right: 15,bottom: 7),
                            child: Text("$reset",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        TextButton(onPressed: () async {
                          var prefUserProfile = await SharedPreferences.getInstance();
                          prefUserProfile.setString("UserName", UserName.text);
                          prefUserProfile.setString("UserMob", UserMob.text);
                          prefUserProfile.setString("UserEmail", UserEmail.text);
                          prefUserProfile.setString("UserState", selectedState.toString());
                          showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                          updateProfile();
                          setState(() {});

                        },
                            style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 7,right: 15,bottom: 7),
                              child: Text("$save",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                            ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
    ]
          )
      )
  ),
  );

  void imagePickerOption()
  {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}

shopTheme shoptheme = new shopTheme();
}