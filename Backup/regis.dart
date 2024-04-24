import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'login.dart';


class regis extends StatefulWidget {

  const regis({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _regisState();

}

class _regisState extends State<regis>{

  final formKey = GlobalKey<FormState>();
  String name = "";
  
  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(139, 227, 143, 1),
       
        title: Row(
                children: <Widget>[
                  // Image.asset('Assets/Image/App Logo.png',height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap : (){
                              Navigator.popAndPushNamed(context, '/home').then((_) => setState(() {}));
                              },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Registration Page",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
        //       decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage("assets/img/back.jpg"),
        //       fit: BoxFit.cover),
        // ),
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form( //for form validation 
            key: formKey, //for form validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.12,),
                Text("Login Here !!", style: TextStyle(fontSize: 30, color: Colors.amber),),
                // Text("Hello", style: TextStyle(fontSize: 30),),
                SizedBox(height: height*0.06,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Name",
                  ),
      
                  // ********************************Validation************************************
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                        return "Please Enter Valid Name";
                    }
                    else{
                      return null;
                    }
                  },
                ),
      
                SizedBox(height: height*0.06,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Password",
                  ),
                  
                  // ********************************Validation************************************
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                        return "Please Enter Valid Password";
                    }
                    else{
                      return null;
                    }
                  },
                ),
      
                SizedBox(height: height*0.06,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Email",
                  ),
      
                  // ********************************Validation************************************
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                        return "Please Enter Valid Email";
                    }
                    else{
                      return null;
                    }
                  },
                ),
      
                SizedBox(height: height*0.06,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Mobile Number",
                  ),
      
                  // ********************************Validation************************************
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)){
                        return "Please Enter Valid Mobile Number";
                    }
                    else{
                      return null;
                    }
                  },
                ),
      
                
                SizedBox(height: height*0.09,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Center(
                      child: ElevatedButton(
                        child: Text("Submit"),
                        onPressed: (){
                        if(formKey.currentState!.validate()){
                          final snackBar = SnackBar(content: Text('Succesful'));
                          // _scaffoldKey.currentState!.showSnackBar(snackBar);
                        }
                      },
                      onLongPress: (){
                        print("Long Pressed");
                      },
                      ),
                    )
                  ],
                )
              ],
            ), 
            ),
          ),
      ),
    );
  }

  
} 

