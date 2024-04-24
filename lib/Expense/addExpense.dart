import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';
import '../Settings/settingsTheme.dart';

import 'package:http/http.dart' as http;

class addExpense extends StatefulWidget {
  const addExpense({Key? key}) : super(key: key);

  @override
  State<addExpense> createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {

  TextEditingController name = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  var userEmail;
  int n = 0;

  String title = "Add Expense";
  String Name_txt = "Name";
  String Amount_txt = "Amount";
  String totAmount_txt = "Total Amount";
  String save = "SAVE";

  Future getUserEmail() async
  {
    var prefUserProfile = await SharedPreferences.getInstance();
    userEmail = prefUserProfile.getString("UserEmail");
    print(userEmail);
  }

  Future addExpense() async
  {
    var url = Uri.parse("https://agrinfo.000webhostapp.com/addExpese.php");
    var response = await http.post(url,body: {
      'expenseName' : name.text,
      'expenseAmount' : amount.text,
      'userEmail' : userEmail
    });

    var data;

    if(response.body.isNotEmpty)
      {
        setState(() {
          data = jsonDecode(response.body);
        });
      }

    if(data == "Failed")
      {
        Navigator.pop(context);
        settingsTheme().showToast("Error : Expense Not Saved");
      }
    else
      {
        Navigator.pop(context);
        settingsTheme().showToast("Expense Saved");
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Data = ModalRoute.of(context)?.settings.arguments;

    if(Data == "marathi")
      {
        title = "खर्च जोडा";
         Name_txt = "नाव";
         Amount_txt = "रक्कम";
         totAmount_txt = "एकूण रक्कम";
         save = "जतन करा";
      }
    if(Data == "hindi")
      {
        title = "व्यय जोड़ें";
        Name_txt = "नाम";
        Amount_txt = "राशि";
        totAmount_txt = "कुल राशि";
        save = "SAVE";
      }

    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/expenseSpinner');
      return true;
    },
    child: Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Color.fromRGBO(249, 253, 250, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,255,255, 1),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.pushNamed(context, '/expenseSpinner').then((_) { setState(() {}); } );; },),
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        title: Text("$title", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: DataTable(
                columns: [
                  DataColumn(label: Text(
                      '$Name_txt',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)
                  )),
                  DataColumn(label: Text(
                      '$Amount_txt',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                  )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(SizedBox(
                      width: 200,
                      child:
                      TextField(
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(borderSide: BorderSide.none)
                          hintText: "$Name_txt"
                        ),
                        controller: name,
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        keyboardType: TextInputType.name,
                      )
                    )),
                    DataCell(SizedBox(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(
                              // border: OutlineInputBorder(borderSide: BorderSide.none)
                            hintText: "$Amount_txt"
                          ),
                          controller: amount,
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() {}),
                        )
                    )),
                  ]),
                ],

              ),
            ),
            
            SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("$totAmount_txt",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 70.0),
                    child: Text("\u{20B9}${amount.text}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            TextButton(onPressed: () {
              if(name.text != "" && amount.text != "")
                {
                 //  n = n+1;
                  String Name = name.text;
                  String Amount = amount.text;
                  showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)));
                  addExpense();
                }
              else{
                settingsTheme().showToast("Any Field can not be empty");
              }

            }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                child: Text("$save",style: TextStyle(color: Colors.white,letterSpacing: 1),),
              ),)
          ],
        ),
      ),
    )
    );
  }
}
