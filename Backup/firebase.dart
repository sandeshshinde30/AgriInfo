
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class firebase extends StatefulWidget {
  const firebase({Key? key}) : super(key: key);

  @override
  State<firebase> createState() => _firebaseState();
}

class _firebaseState extends State<firebase> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Login');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Connection"),
      ),

      body: Container(
          child : Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    controller: username,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    controller: password,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.text,
                  ),
                ),
                TextButton(onPressed: (){

                  Map<String,String> students = {
                    'username' : username.text,
                    'password' : password.text
                  };

                  databaseRef.child('1').set({
                    'id' : 1
                  });

                }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,top: 5,right: 15,bottom: 5),
                    child: Text("INSERT",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}


