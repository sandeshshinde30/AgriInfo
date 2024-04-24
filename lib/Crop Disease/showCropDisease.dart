
import 'dart:async';
import 'dart:convert';
import 'package:agri_info/App%20Theme/main2.dart';
import 'package:agri_info/Crop%20Disease/cropDiseaseTheme.dart';
import 'package:agri_info/Shop/shopTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ShowDiseaseSpinner extends StatefulWidget {
  const ShowDiseaseSpinner({Key? key}) : super(key: key);

  @override
  State<ShowDiseaseSpinner> createState() => _ShowDiseaseSpinnerState();
}

class _ShowDiseaseSpinnerState extends State<ShowDiseaseSpinner> {

  var cropDiseaseImg = [];
  var cropDiseasename;
  var symtoms;
  var survivalPrimary;
  var survivalSecondary;
  var management;
  var searchDiseasename;
  String? language;

  Future getlanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);
    fetchCropDiseaseData();
  }

  Future fetchCropDiseaseData() async
  {
    var url = Uri.parse("https://agrinfo.000webhostapp.com/showCropDisease.php");
    try
    {
      print("show crop disease");
      var response = await http.post(url,body: {
        'cropDiseaseName' : searchDiseasename,
        'language' : language
      });

      var cropDiseaseData;

      if(response.body.isNotEmpty)
      {
        cropDiseaseData = jsonDecode(response.body);

        cropDiseaseImg.add(cropDiseaseData[0]['diseasephotoPath1']);
        cropDiseaseImg.add(cropDiseaseData[0]['diseasephotoPath2']);
        cropDiseaseImg.add(cropDiseaseData[0]['diseasephotoPath3']);

        cropDiseasename = cropDiseaseData[0]['diseaseName'];
        symtoms = cropDiseaseData[0]['symtoms'];
        survivalPrimary = cropDiseaseData[0]['survivalPrimary'];
        survivalSecondary = cropDiseaseData[0]['survivalSecondary'];
        management = cropDiseaseData[0]['Management'];

        Map cropDiseaseAllData = {
          'name' : cropDiseasename,
          'symtoms' : symtoms,
          'survivalPrimary' : survivalPrimary,
          'survivalSecondary' : survivalSecondary,
          'management' : management,
          'cropDiseaseImg' : cropDiseaseImg,
        };
        Navigator.pushNamed(context,'/showDisease',arguments: cropDiseaseAllData);
      }
    }
    catch(e)
    {
      print(e);
      cropDiseaseImg.add('https://image3.photobiz.com/8852/3_20171212101935_22529028_large.jpg');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getlanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchDiseasename = ModalRoute.of(context)?.settings.arguments;
    print(searchDiseasename);
    return WillPopScope(
        onWillPop: () async {
      Navigator.pushNamed(context, '/cropDisease');
      return true;
    },
    child: Scaffold(
      body: Center(child: CircularProgressIndicator(color: Color.fromRGBO(20, 79, 22,1),)),
    )
    );
  }
}



class showDisease extends StatefulWidget {
  const showDisease({Key? key}) : super(key: key);

  @override
  State<showDisease> createState() => _showDiseaseState();
}

class _showDiseaseState extends State<showDisease> {

  bool showSpinner = false;
  // final CropDiseaseRef = FirebaseDatabase.instance.reference().child('CropDisease');
  // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  var cropDiseaseData;
  var cropDiseaseImg = [];
  var cropDiseasename;
  var symtoms;
  var survivalPrimary;
  var survivalSecondary;
  var management;
  var language;

  String symtoms_txt = "Symtoms";
  String survival_txt = "Survival and Spread";
  String management_txt = "Management";
  String recProduct = "Recommended Product";
  String primary_txt = "Primary";
  String secondary_txt = "Secondary";

  Future getLanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);

    if(language == "marathi")
    {

       symtoms_txt = "लक्षणे";
       survival_txt = "पसरणे";
       management_txt = "व्यवस्थापन";
       recProduct = "शिफारस केलेले खत";
       primary_txt = "प्राथमिक";
       secondary_txt = "माध्यमिक";
      setState(() {});

    }
    else if(language == "hindi")
    {
      symtoms_txt = "लक्षण";
      survival_txt = "उत्तरजीविता और फैलाव";
      management_txt = "प्रबंध";
      recProduct = "अनुशंसित उर्वरक";
      primary_txt = "प्राथमिक";
      secondary_txt = "माध्यमिक";
      setState(() {});
    }
  }


  
  @override
  void initState() {
    // TODO: implement initState
    // spinner();
    // fetchCropDiseaseData();
    getLanguage();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments;
    cropDiseaseData = data;
    cropDiseasename = cropDiseaseData['name'];
    cropDiseaseImg = cropDiseaseData['cropDiseaseImg'];
    symtoms = cropDiseaseData['symtoms'];
    survivalPrimary = cropDiseaseData['survivalPrimary'];
    survivalSecondary = cropDiseaseData['survivalSecondary'];
    management = cropDiseaseData['management'];
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/cropDisease');
      return true;
    },
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(245, 252, 247,1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(204, 246, 224, 1.0),
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back , color: Colors.black,), onPressed: () { Navigator.pushNamed(context, '/cropDisease'); },),
          iconTheme: IconThemeData(color: Colors.black,size: 25),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/savedDisease');
            }, icon: ImageIcon(AssetImage('Assets/Image/save_for_later_filled.png')),)
          ],
          title: Text(cropDiseasename, style: TextStyle(color: Colors.black),),
        ),

        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageSlideshow(
                    width: MediaQuery.of(context).size.width,
                    initialPage: 0,
                    indicatorColor: Colors.deepOrange,
                    autoPlayInterval: 150000,
                    isLoop: false,
                    indicatorBackgroundColor: Colors.white,
                    children: [
                      if(cropDiseaseImg[0]!=null)
                      for(int i = 0;i<3;i++)
                        cropDiseaseTheme().zoomCropDisease(context,cropDiseaseImg[i])
                    ],
                  ),
                ),
              SizedBox(height: 20,),
                cropDiseaseTheme().showDiseaseInfo("$symtoms_txt",symtoms),
                cropDiseaseTheme().showDiseaseInfo("$survival_txt","$primary_txt: $survivalPrimary.\n\n$secondary_txt: $survivalSecondary"),
                cropDiseaseTheme().showDiseaseInfo("$management_txt",management),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25,top: 10),
                        child: Text("$recProduct",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                      ),
                      // cropDiseaseTheme().cropDiseaseRecommendedProduct(context,"Criyagen 00-55-34"),
                      // cropDiseaseTheme().cropDiseaseRecommendedProduct(context,"Criyagen 00-30-54")
                    ],
                  ),
                ),
              ],
            )
        ),

        bottomNavigationBar: BottomAppBar(
          height: 80,
          color: Color.fromRGBO(199, 237, 210,1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child:
                   Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 200,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(cropDiseasename,style: TextStyle(fontSize: 20 ,wordSpacing: 2 , fontWeight: FontWeight.bold,)))
               ),
             ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(onPressed: (){}, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
                    child: Text("SAVE FOR LATER",style: TextStyle(color: Colors.white,letterSpacing: 1),),
                  ),),
              ),
            ],
          ),
        )
    )
    );
  }
}

shopTheme shoptheme = new shopTheme();