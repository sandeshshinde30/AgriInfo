

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Settings/settingsTheme.dart';

class ExpenseTheme
{
  List totalAmount = [0];


  ListTile expense(BuildContext context,[String name = "none",String amount = "none",String ID = "none"])
  {
    totalAmount.add(amount);
    return ListTile(
      leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(name.toString() + "                \u{20B9}${amount}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ),
      trailing: IconButton(onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Message'),
              content: Text('Are you sure you want to delete?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // deleteExpense(context,ID);
                    var url = Uri.parse("https://agrinfo.000webhostapp.com/deleteExpense.php");

                    var prefUserProfile = await SharedPreferences.getInstance();
                    var userEmail = prefUserProfile.getString("UserEmail").toString();

                    Navigator.pushNamed(context,'/expenseSpinner');

                    if (userEmail != null) {
                      try {
                        var response = await http.post(url, body: {
                          'userEmail': userEmail,
                          'expenseID': ID
                        });

                        var result;

                        if (response.body.isNotEmpty) {
                          result = jsonDecode(response.body);
                        }

                        if (result == "Success") {
                          settingsTheme().showToast("Expense Deleted Successfully");
                        }
                        else {
                          settingsTheme().showToast("Failed to Delete expense");
                        }
                      }
                      catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      }, icon: Icon(Icons.delete,color: Colors.deepOrange,))
      );
  }


  Future<void> totAmount()
  async {
    var prefExpense = await SharedPreferences.getInstance();
    prefExpense.setStringList("total",totalAmount[0]);
    prefExpense.setStringList("total",totalAmount[1]);
    prefExpense.setStringList("total",totalAmount[2]);
  }
}

Future deleteExpense(BuildContext context,String ID) async
{
  var url = Uri.parse("https://agrinfo.000webhostapp.com/deleteExpense.php");

  var prefUserProfile = await SharedPreferences.getInstance();
  var userEmail = prefUserProfile.getString("UserEmail").toString();

  if (userEmail != null) {
    try {
      var response = await http.post(url, body: {
        'userEmail': userEmail,
        'expenseID': ID
      });

      var result;

      if (response.body.isNotEmpty) {
        result = jsonDecode(response.body);
      }

      if (result == "Success") {
        Navigator.pushNamed(context,'/expenseSpinner');
        settingsTheme().showToast("Expense Deleted Successfully");
      }
      else {
        Navigator.pushNamed(context,'/expenseSpinner');
        settingsTheme().showToast("Failed to Delete expense");
      }
    }
    catch (e) {
      print(e);
    }
  }
}