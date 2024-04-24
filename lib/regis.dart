import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Settings/settingsTheme.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final List<String> states = [    'Select State',    'Andhra Pradesh',    'Arunachal Pradesh',    'Assam',    'Bihar',    'Chhattisgarh',    'Goa',    'Gujarat',    'Haryana',    'Himachal Pradesh',    'Jharkhand',    'Karnataka',    'Kerala',    'Madhya Pradesh',    'Maharashtra',    'Manipur',    'Meghalaya',    'Mizoram',    'Nagaland',    'Odisha',    'Punjab',    'Rajasthan',    'Sikkim',    'Tamil Nadu',    'Telangana',    'Tripura',    'Uttarakhand',    'Uttar Pradesh',    'West Bengal'  ];
  late String _selectedState = states[0];

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  String? state;
  static String verify = "";
  String countyCode = "+91";
  var language;

  String titile = "Agrinfo Registration";
  String nameTxt = "Name";
  String emailTxt = "Email";
  String mobileTxt = "Mobile Number";
  String stateTxt = "Select State";
  String btnTxt = "Register";
  String haveAcc = "Already have account?";
  String login = "Login";
  String invalidPhone = "Invalid Phone Number";
  String alreadyReg = "Already Registered..";
  String must10Digit = "Mobile number must be 10 digits.";
  String emptyName = "Please Enter Name....";
  String emptyEmail = "Please Enter Email....";
  String emptyState = "Please Select State....";

  Future setDataOnLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    print("Register $language");

    if(language == "marathi")
      {
         titile = "ॲग्रीइनफो रजिस्ट्रेशन";
         nameTxt = "नाव";
         emailTxt = "ईमेल";
         mobileTxt = "मोबाईल नंबर";
         stateTxt = "राज्य निवडा";
         btnTxt = "रजिस्टर";
         haveAcc = "आधीपासून अकाऊंट आहे?";
         login = "लॉगिन";
         invalidPhone = "चुकीचा मोबाईल नंबर";
         alreadyReg = "तुम्ही आधीपासून रजिस्टर आहात";
         must10Digit = "मोबाईल नंबर 10 अंकी हवा आहे";
         emptyName = "कृपया नाव टाका";
         emptyEmail = "कृपया ईमेल टाका";
         emptyState = "कृपया राज्य निवडा";
         setState(() {});

      }
    if(language == "hindi")
      {
        titile = "ॲग्रीइनफो रजिस्ट्रेशन";
        nameTxt = "नाम";
        emailTxt = "ईमेल";
        mobileTxt = "मोबाइल नंबर";
        stateTxt = "राज्य चुनें";
        btnTxt = "रजिस्टर";
        haveAcc = "पहले से खाता है?";
        login = "लॉगिन";
        invalidPhone = "अवैध फोन नंबर";
        alreadyReg = "पहले से ही रजिस्टर है";
        must10Digit = "मोबाइल नंबर 10 अंकों का होना चाहिए";
        emptyName = "कृपया नाम दर्ज करें";
        emptyEmail = "कृपया ईमेल दर्ज करें";
        emptyState = "कृपया राज्य का चयन करें";

        setState(() {});
      }
  }

  Future registerUser() async
  {
    try {
      var url = Uri.parse("https://agrinfo.000webhostapp.com/registerCheck.php");

      var response = await http.post(url, body: {
        'mob': mob.text,
      });

      var data;
      int Mobile = int.parse(mob.text);

      if(response.body.isNotEmpty)
        {
          data = jsonDecode(response.body);
        }

      if(data == "true")
        {
          Navigator.pop(context);
          // settingsTheme().showToast("Registration Successful...");

          var prefUserProfile = await SharedPreferences.getInstance();
          prefUserProfile.setString("UserName", name.text);
          prefUserProfile.setString("UserMob", mob.text);
          prefUserProfile.setString("UserEmail", email.text);
          prefUserProfile.setString("UserState", state.toString());

          {
            showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '${countyCode + mob.text}',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('$invalidPhone'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              codeSent: (String verificationId, int? resendToken) {
                Navigator.of(context).pop();
                RegistrationFormState.verify = verificationId;
                Navigator.pushReplacementNamed(context, '/regOtp');
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                Navigator.of(context).pop();
              },
            );
          }

        }
      if(data == "false")
        {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('$alreadyReg'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
      // if(data == "false")
      //   {
      //     Navigator.pop(context);
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text('Error'),
      //             content: Text('Registration Failed..'),
      //             actions: <Widget>[
      //               TextButton(
      //                 child: Text('OK'),
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //               ),
      //             ],
      //           );
      //         }
      //     );
      //   }
    }
    catch(e)
    {
      Navigator.pop(context);
      settingsTheme().showToast("Error : Registration Failed...");
      print("Error in registering user");
      print(e);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    setDataOnLanguage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // appBar: AppBar(
      //   title: Text('AgriInfo Registration'),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text(
                '$titile',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                ),
              ),
              SizedBox(height: 10.0),
              Image.asset(
                'Assets/Image/Agrinfo_SignUp.png',
                height: 265.0,
                width: 265.0,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: name,
                decoration: InputDecoration(
                  labelText: '$nameTxt',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: '$emailTxt',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                maxLength: 10,
                controller: mob,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: '$mobileTxt',
                    prefixText: '+91 ',
                    counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.phone),

                ),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: _selectedState,
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue!;
                    state = newValue;
                  });
                },
                items: states.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: '$stateTxt',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(height: 40.0),
              TextButton(onPressed: (){
                // print(name.text + email.text + mob.text + state.toString());

                if (mob.text.length < 10 || mob.text.length >10) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('$must10Digit'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                else if(name.text.isEmpty)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('$emptyName'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                else if(email.text.isEmpty)
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('$emptyEmail'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                else if(state == null)
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('$emptyState'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                else{
                  showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                  registerUser();
                }
              }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
                    child: Text("$btnTxt > ",style: TextStyle(color: Colors.white,letterSpacing: 1),),
      ),),
              SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
            // Navigate to the login page when the button is pressed
            Navigator.pushReplacementNamed(context, '/lgn');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$haveAcc',
                  style: TextStyle(
                      color: Colors.black,fontSize: 17),
                ),
                Text(
                  ' $login',
                  style: TextStyle(
                      color: Colors.green,fontSize: 17),
                ),
              ],
            )
          ),
            ],
          ),
        ),
      ),
    );
  }
}