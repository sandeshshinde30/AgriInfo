import 'dart:async';

import 'package:agri_info/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<FocusNode> _focusNodes = [    FocusNode(),    FocusNode(),    FocusNode(),    FocusNode(), FocusNode() , FocusNode() ];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  String phoneCode = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  String title = "Enter 6-Digit OTP";
  String remainTime = "seconds remaining";
  String btnText = "Verify";
  String haveAcc = "Already have account?";
  String login = "Login";
  String wrongOtp = "Wrong OTP";

  int _timer = 30;
  bool _timerRunning = true;
  var language;

  Future setDataOnLanguage() async
  {
    var preflanguage = await SharedPreferences.getInstance();
    language = preflanguage.getString('language').toString().toLowerCase();

    if(language == "marathi")
    {
      title = "6-अंकी OTP एंटर करा";
       remainTime = "सेकंद शिल्लक";
       btnText = "Verify";
       haveAcc = "आधीच खाते आहे";
       login = "लॉगिन";
       wrongOtp = "चुकीचा OTP";
      setState(() {});
    }

    if(language == "hindi")
    {
      title = "6 अंकों का ओटीपी दर्ज करें";
      remainTime = "सेकंड शेष";
      btnText = "Verify";
      haveAcc = "पहले से खाता है";
      login = "लॉगिन";
      wrongOtp = "गलत OTP";
      setState(() {});
    }

    setState(() {});
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_timer == 0) {
          setState(() {
            _timerRunning = false;
          });
          timer.cancel();
        } else {
          setState(() {
            _timer--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    setDataOnLanguage();
    startTimer();
    super.initState();
  }

  void _handleSubmitted(String value, int index) {
    if (index == 5) {
      // if all digits are filled, move to next screen or validate OTP
      print(_controller1.text + _controller2.text + _controller3.text + _controller4.text + _controller5.text + _controller6.text);
      phoneCode = _controller1.text + _controller2.text + _controller3.text + _controller4.text + _controller5.text + _controller6.text;


    } else {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Image.asset(
                'Assets/Image/Agrinfo_otp.png', // replace with your image path
                height: 275.0,
                width: 275.0,
              ),
              SizedBox(height: 50.0),
              Text(
                '$title',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[0],
                      controller: _controller1,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 0);
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[1],
                      controller: _controller2,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 1);
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[2],
                      controller: _controller3,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 2);
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[3],
                      controller: _controller4,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 3);
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[4],
                      controller: _controller5,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 4);
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50.0,
                    child: TextField(
                      focusNode: _focusNodes[5],
                      controller: _controller6,
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _handleSubmitted(value, 5);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                '$_timer $remainTime',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30,),

              TextButton(onPressed: () async {
                try{
                  showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginPageState.verify, smsCode: phoneCode);
                  await auth.signInWithCredential(credential);
                  Navigator.pushNamedAndRemoveUntil(context, '/home',(route)=>false);
                }
                catch(e)
                {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('$wrongOtp'),
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
              }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
                  child: Text("$btnText",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                ),),
              SizedBox(height: 60.0),
              TextButton(
                  onPressed: () {
                    // Navigate to the login page when the button is pressed
                    Navigator.pushReplacementNamed(context, '/lgn');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$haveAcc?',
                        style: TextStyle(
                            color: Colors.black,fontSize: 15),
                      ),
                      Text(
                        ' $login',
                        style: TextStyle(
                            color: Colors.green,fontSize: 15),
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