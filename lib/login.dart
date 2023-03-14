import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:agri_info/regis.dart';




class lgn extends StatefulWidget {

  const lgn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _lgnState();

}

class _lgnState extends State<lgn>{

  final formKey = GlobalKey<FormState>();
  String name = "";
  
  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
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

              SizedBox(height: height*0.08,),
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
              SizedBox(height: height*0.09,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Text("SignUp here", style: TextStyle(color: Colors.blue),),
                        onTap : (){
                      Navigator.pushReplacementNamed(
                          context,
                          '/register').then((_) => setState(() {}));
                    },
                        )
                    ],
                  ),
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
    );
  }

  
} 

