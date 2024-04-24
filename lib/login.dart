import 'dart:convert';

import 'package:agri_info/regis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String countyCode = "+91";
  var phone = "";

  static String verify = "";
  var language;

  String title = "Agrinfo Login";
  String textFieldText = "Enter your phone number";
  String otpText1 = "A 6 digit OTP will be sent via SMS to verify";
  String otpText2 = "Your mobile number.";
  String btnText = "Login";
  String dontHaveAcc = "Don\'t have an account?";
  String signUp = "Sign Up";
  String invalidMob = "Invalid Mobile Number";
  String notRegistered = "You are not Registered..";
  String must10Digit = "Mobile number must be 10 digits.";


  @override
  void initState() {
    // TODO: implement initState
    setDataOnLanguage();
    super.initState();
  }

  Future setDataOnLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    if(language == "marathi")
      {
         title = "ॲग्रीइनफो लॉगिन";
         textFieldText = "तुमचा फोन नंबर टाका";
         otpText1 = "6 अंकी OTP तुमच्या फोन नंबर वरती येईल";
         otpText2 = "SMS च्या मार्फत";
         btnText = "लॉगिन";
         dontHaveAcc = "तुमचे अकाऊंट नाही?";
         signUp = "Sign Up";
         invalidMob = "चुकीचा फोन नंबर";
         notRegistered = "तुम्ही अजून रजिस्टर नाही";
         must10Digit = "फोन नंबर 10 अंकी हवा आहे";

        setState(() {});
      }

    if(language == "hindi")
      {
        title = "ॲग्रीइनफो लॉगिन";
        textFieldText = "अपना फोन नंबर डालें";
        otpText1 = "६ अंकी OTP आपके मोबाइल पर  नंबर आएगा";
        otpText2 = "";
        btnText = "लॉगिन";
        dontHaveAcc = "आपका अकाउंट नही है ?";
        signUp = "Sign Up";
        invalidMob = "गलत फोन नंबर";
        notRegistered = "आप रजिस्टर नही है";
        must10Digit = "मोबाइल नंबर १० अंको का चाहिए";
        setState(() {});
      }

    setState(() {});
  }

  Future checkUserRegistered(BuildContext context) async
  {
    try{
      var url = Uri.parse("https://agrinfo.000webhostapp.com/login.php");

      var response = await http.post(url, body: {
        'mob': phone.toString(),
      });

      var Data;
      if(response.body.isNotEmpty)
      {
        Data = jsonDecode(response.body);
      }

      if(Data == "true")
      {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '${countyCode + phone}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('$invalidMob'),
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
            LoginPageState.verify = verificationId;
            Navigator.pushReplacementNamed(context, '/otp');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            Navigator.of(context).pop();
          },
        );
      }
      else
      {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text("$notRegistered"),
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
    }
    catch(e)
    {
      Navigator.of(context).pop();
      print("Login Error");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70.0),
            Text(
              '$title',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[400],
              ),
            ),
            SizedBox(height: 10.0),
            Image.asset(
              'Assets/Image/Agrinfo_Login.png', // replace with your image path
              height: 350.0,
              width: 350.0,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (value){
                  phone = value;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '$textFieldText',
                  prefixText: '+91 ',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Container(height: 1,color: Colors.black12,width: MediaQuery.of(context).size.width * 0.70,),
            Text(
              '$otpText1',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10.0),
            Text(
              '$otpText2',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 50.0),
            InkWell(
              onTap: () async {
                if (phone.length < 10 || phone.length >10) {
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
                else {
                  showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                  checkUserRegistered(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 79, 22, 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                  child: Text(
                    '$btnText >',
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationForm()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$dontHaveAcc',
                      style: TextStyle(color: Colors.black,fontSize: 17),
                    ),
                    Text(
                      ' $signUp',
                      style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.w700),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}




