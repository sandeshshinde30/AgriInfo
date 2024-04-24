import 'dart:async';
import 'dart:io';
import 'package:agri_info/Crop%20Disease/savedDisease.dart';
import 'package:agri_info/Crop%20Disease/showCropDisease.dart';
import 'package:agri_info/Expense/addExpense.dart';
import 'package:agri_info/Settings/language.dart';
import 'package:agri_info/Settings/userProfile.dart';
import 'package:agri_info/Shop/allProducts.dart';
import 'package:agri_info/Shop/bestProducts.dart';
import 'package:agri_info/Shop/recommendedProducts.dart';
import 'package:agri_info/Crop%20Disease/crop_disease.dart';
import 'package:agri_info/Shop/shopProduct.dart';
import 'package:agri_info/notification.dart';
import 'package:agri_info/Settings/settings.dart';
import 'package:agri_info/otpPage.dart';
import 'package:agri_info/regOtpScreen.dart';
import 'package:agri_info/regis.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:agri_info/Weather/Weather%20Forecasting.dart';
import 'package:agri_info/Shop/shopHome.dart';
import 'package:agri_info/search.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Expense/expense.dart';
import 'cart.dart';
import 'Shop/cropFertilizer.dart';
import 'Shop/cropTonics.dart';
import 'favorite.dart';
import 'Weather/openAppSetting.dart';
import 'Weather/openLocationSetting.dart';
import 'firebase_options.dart';
import 'lang_select.dart';
import 'login.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (BuildContextcontext) => Loader(),
          '/langSelect' : (BuildContextcontext) => LanguageSelectionPage(),
          '/lgn' : (BuildContextcontext) => LoginPage(),
          '/signup' : (BuildContextcontext) => RegistrationForm(),
          '/otp' : (BuildContextcontext) => OtpScreen(),
          '/regOtp' : (BuildContextcontext) => regOtpScreen(),
          '/home' : (BuildContextcontext) => home(),
          '/expenseSpinner' : (BuildContextcontext) => ExpenseSpinner(),
          '/expense' : (BuildContextcontext) => Expenses(),
          '/addexpense' : (BuildContextcontext) => addExpense(),
          '/weather_forecast' : (BuildContext) => Wheather_Forecasting(),
          '/weather_forecast_loader' : (BuildContext) => WeatherLoader(),
          '/shopHomeSpinner' : (BuildContext) => shopHomeSpinner(),
          '/shopHome' : (BuildContext) => shopHome(),
          // '/login' : (BuildContext) => (),
          // '/register' : (BuildContext context)=>regis(),
          '/openLocationSettings' : (BuildContext context)=>openLocationSetting(),
          '/openAppSettings' : (BuildContext context)=>openAppSetting(),
          '/search' : (BuildContext context)=>search(),
          '/shopProductSpinner' : (BuildContext context)=>shopProductSpinner(),
          '/shopProduct' : (BuildContext context)=>shopProduct(),
          '/allProductsSpinner' : (BuildContext context)=>allProductsSpinner(),
          '/allProducts' : (BuildContext context)=>allProducts(),
          '/cropTonics' : (BuildContext context)=>cropTonics(),
          '/cropFertilizer' : (BuildContext context)=>cropFertilizer(),
          '/bestProductsSpinner' : (BuildContext context)=>bestProductsSpinner(),
          '/bestProducts' : (BuildContext context)=>bestProducts(),
          '/recommendedProductsSpinner' : (BuildContext context)=>recommendedProductsSpinner(),
          '/recommendedProducts' : (BuildContext context)=>recommendedProducts(),
          '/shopCart' : (BuildContext context)=>cart(),
          '/shopFavorite' : (BuildContext context)=>favorite(),
          '/notification' : (BuildContext context)=>notification(),
          '/cropDisease' :  (BuildContext context)=>cropDisease(),
          '/showDiseaseSpinner' : (BuildContext context)=>ShowDiseaseSpinner(),
          '/showDisease' : (BuildContext context)=>showDisease(),
          '/savedDisease' : (BuildContext context)=>savedDisease(),
          '/settings' : (BuildContext context)=>settings(),
          '/language' : (BuildContext context)=>Applanguage(),
          '/userProfile' : (BuildContext context)=>userProfile(),
        },
      )
  );
}

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {

  String? location;

  void getLocation() async
  {
    final Position position = await determinePosition(context);
    if(position!= null)
    {
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      location = place.subLocality.toString() + " " + place.locality.toString();
      print("Location : ");
      print(location);

      var preflocation = await SharedPreferences.getInstance();
      preflocation.setString('userLocation', location.toString());
    }
  }

  Future<void> checkLogin() async {
    var loginOrNot;
    var prefCheckLogin = await SharedPreferences.getInstance();
    loginOrNot = prefCheckLogin.getBool("LoginString");
    print("home boolean $loginOrNot");

     if (loginOrNot == null || !loginOrNot) {
       Timer(Duration(seconds: 2), () => Navigator.pushNamed(context, '/langSelect'));
       print("$loginOrNot lang select");
     } else {
      Timer(Duration(seconds: 2), () => Navigator.pushNamed(context, '/home'));
      print("$loginOrNot home");
     }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:Container(
            color: Colors.white,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('Assets/Image/AppIcon.jpeg',height: 100,),
                    ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('Assets/Gif/App Loader.gif',width: 70)]
                ),
              ],
            )
        ),
      ),
    );
  }
}

class home extends StatefulWidget {

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selectedIndex = 0;
  /// ********* Weather API Data ********** ///

  var Location = "no location";
  var Temperature = "no temperature";
  var Condition = "no condition";
  var Sunrise = "no sunrise";
  var Sunset = "no sunset";
  var language;

  String AgriInfo = "AgriInfo";
  // Slideshow Variables
  String slideShowText1_0="Recognize your";
  String slideShowText1_1="CROP DISEASE";
  String slideShowText2_0="Protect Plant";
  String slideShowText2_1="GO ORGANIC";
  String slideShowText3_0="Stay ahead of";
  String slideShowText3_1="THE WEATHER";

  // Crop disease container variables
  String cropDiseaseTitle = "Identify Crop Disease";
  String cropDiseaseText1 = "Save your plants from disease";
  String cropDiseaseText2 = "Healthy Plants, Happy plants";
  String cropDiseaseBtn = "IDENTIFY DISEASE";

  // Biopestices container variables
  String biopesticidesTitle = "Biopesticides";
  String biopesticidesText1 = "Say no to harmful pesticides";
  String biopesticidesText2 = "Healthy soil, Healthy people";
  String biopesticidesBtn = "SEE BIOPESTICIDES";

  // Weather container variables
  String weatherTitle = "Weather";
  String weatherSunset="Sunset";
  String weatherbtn="SEE WEATHER";

  // Bottom Tab variables
  String home = "Home";
  String expense = "Expense";
  String shop = "Shop";
  String crop = "Crop";
  String settings = "Settings";

  String name = "none";
  String email = "none";

  Future getUserProfileData() async
  {
    var prefUserProfile = await SharedPreferences.getInstance();
    name = prefUserProfile.getString("UserName").toString();
    email = prefUserProfile.getString("UserEmail").toString();
    setState(() {});
  }

  Future<void> checkLogin()
  async {
    var prefCheckLogin = await SharedPreferences.getInstance();
    prefCheckLogin.setBool("LoginString",true);
  }

  void getPreferanceData() async
  {
    var pref = await SharedPreferences.getInstance();

    var location = pref.getString('location');
    var tempC = pref.getString('tempC');
    var condition = pref.getString('condition');
    var sunrise = pref.getString('sunrise');
    var sunset = pref.getString('sunset');

    Location = location ?? "Kolhapur";
    Temperature = tempC ?? "32";
    Condition = condition ?? "no value get from preferances";
    Sunrise = sunrise ?? "no value get from preferances";
    Sunset = sunset ?? "18:36 PM";

    setState(() {});
  }


  Future setDataOnLanguage() async
  {
    var prefLanguage = await SharedPreferences.getInstance();
    language = prefLanguage.getString("language").toString().toLowerCase();
    print(language);

    if(language == "marathi")
      {
        slideShowText1_0 = "तुमच्या पिकाचे";
        slideShowText1_1 = "रोग ओळखा";
        slideShowText2_0 = "गो ऑरगॅनिक";
        slideShowText2_1 = "वनस्पतीचे संरक्षण करा";
        slideShowText3_0 = "हवामानाच्या";
        slideShowText3_1 = "पुढे रहा";

        cropDiseaseTitle = "पिकावरील रोग ओळखा";
        cropDiseaseText1 = "आपले पीक रोगापासून वाचवा";
        cropDiseaseText2 = "निरोगी वनस्पती, आनंदी वनस्पती";
        cropDiseaseBtn = "रोग ओळखा";

        biopesticidesTitle = "जैवकीटनाशक";
        biopesticidesText1 = "हानिकारक कीटकनाशकांना नाही म्हणा";
        biopesticidesText2 = "निरोगी माती, निरोगी लोक";
        biopesticidesBtn = "जैवकीटनाशक पहा";

        // Weather container variables
        weatherTitle = "हवामान";
        weatherSunset="सूर्यास्त";
        weatherbtn = "हवामान पहा";

        // Bottom Tab variables
        home = "होम";
        expense = "खर्च";
        shop = "दुकान";
        crop = "पीक";
        settings = "सेटिंग्ज";

        AgriInfo = "ॲग्रीइनफो";
      }
    else if(language == "hindi")
      {
        slideShowText1_0 = "अपने फसल";
        slideShowText1_1 = "रोग को पहचानें";
        slideShowText2_0 = "गो ऑरगॅनिक";
        slideShowText2_1 = "फसल की रक्षा करें";
        slideShowText3_0 = "मौसम से";
        slideShowText3_1 = "आगे रहें";

        cropDiseaseTitle = "फसल रोग की पहचान करें";
        cropDiseaseText1 = "अपने पौधों को बीमारी से बचाएं";
        cropDiseaseText2 = "स्वस्थ पौधे, खुश पौधे";
        cropDiseaseBtn = "रोग पहचानोा";

        biopesticidesTitle = "जैवकीटनाशक";
        biopesticidesText1 = "हानिकारक कीटनाशकों को ना कहें";
        biopesticidesText2 = "नस्वस्थ मिट्टी, स्वस्थ लोग";
        biopesticidesBtn = "जैवकीटनाशक देखें";

        // Weather container variables
        weatherTitle = "मौसम";
        weatherSunset="सूर्यास्त";
        weatherbtn = "मौसम देखें";

        // Bottom Tab variables
        home = "होम";
        expense = "खर्च";
        shop = "दुकान";
        crop = "फसल";
        settings = "सेटिंग्ज";

        AgriInfo = "ॲग्रीइनफो";
      }
  }

  Future<bool?>showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Are you sure to exit app?"),
        actions: [
          ElevatedButton(
              child: Text("No"),
              onPressed: ()=> Navigator.pop(context,false)
          ),
          ElevatedButton(
              child: Text("Yes"),
              onPressed: ()=> exit(0)
          )
        ],
      )

  );

  void _navigateBottomBar(int index){
    setState((){
      _selectedIndex = index;

      if(_selectedIndex == 0)
        {
          Navigator.popAndPushNamed(context,'/home');
        }
      else if(_selectedIndex == 1)
        {
          Navigator.pushNamed(context,'/expenseSpinner');
        }
      else if(_selectedIndex == 2)
      {
        Navigator.popAndPushNamed(context,'/shopHomeSpinner',arguments: language);
      }
      else if(_selectedIndex == 3)
        {
          Navigator.popAndPushNamed(context,'/cropDisease');
        }
      else if(_selectedIndex == 4)
        {
          Navigator.popAndPushNamed(context,'/settings');
        }
    });
  }

  @override
  void initState() {
    checkLogin();
    getUserProfileData();
    setDataOnLanguage();
    getPreferanceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
  onWillPop: () async {
  final willPop = await showWarning(context);
  return willPop ?? false;
  },
    child: Scaffold(
      backgroundColor: Color.fromRGBO(247, 253, 249, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54,size: 30),
        titleSpacing: 0,
        title:  Text("$AgriInfo", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/notification');
          }, icon: ImageIcon(AssetImage('Assets/Image/bell.png')),iconSize: 22,color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/shopFavorite');
          }, icon: ImageIcon(AssetImage('Assets/Image/heart.png')),iconSize: 22,color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          IconButton(onPressed: (){
            Navigator.pushNamed(context,'/savedDisease');
          }, icon: ImageIcon(AssetImage('Assets/Image/save_for_later_outlined.png')),iconSize: 22,color: Colors.black,alignment: Alignment.centerRight,padding: EdgeInsets.only(right:10),constraints: BoxConstraints()),
          SizedBox(width: 5,)
        ],
        ),

        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text("$name"),
                  accountEmail: Text("$email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('Assets/Image/user.png'),
                    radius: 70,
                  ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(94, 143, 134, 1.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle,color: Colors.black54,size: 30,),
                title: Text("My Account"),
                onTap: () {
                  Navigator.pushNamed(context, '/userProfile');
                },
              ),
              ListTile(
                leading: Image.asset('Assets/Image/like.png',height: 25,color: Colors.black54,),
                title: Text("My Favorites"),
                onTap: () {
                  Navigator.pushNamed(context, '/shopFavorite');
                },
              ),
              ListTile(
                leading: Image.asset('Assets/Image/notification.png',height: 25,color: Colors.black54,),
                title: Text("Notifications"),
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
              ),
              ListTile(
                leading: Image.asset('Assets/Image/save_for_later_filled.png',height: 25,color: Colors.black54,),
                title: Text("Saved for Later"),
                onTap: () {
                  Navigator.pushNamed(context, '/savedDisease');
                },
              ),
              ListTile(
                leading: Image.asset('Assets/Image/about_us.png',height: 25,color: Colors.black54,),
                title: Text("About Us"),
                onTap: () {
                  // Navigator.pushReplacementNamed(context, '/shopCart');
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text("Language"),
                onTap: () {
                  Navigator.pushNamed(context, '/language');
                },
              ),
            ],
          ),
        ),


        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
               Row(
                 children: [
                   Expanded(
                     child: ImageSlideshow(
                          /// Width of the [ImageSlideshow].
                          width: double.infinity,

                          /// Height of the [ImageSlideshow].
                          height: 200,

                          /// The page to show when first creating the [ImageSlideshow].
                          initialPage: 0,

                          /// The color to paint the indicator.
                          indicatorColor: Colors.green.shade300,

                          /// Auto scroll interval.
                          /// Do not auto scroll with null or 0.
                          autoPlayInterval: 8000,

                          /// Loops back to first slide.
                          isLoop: true,

                          /// The color to paint behind th indicator.
                          indicatorBackgroundColor: Colors.black54,

                          /// The widgets to display in the [ImageSlideshow].
                          /// Add the sample image file into the images folder
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'Assets/Image/plant_disease_detection.jpg',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(slideShowText1_0,style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.black45),),
                                          Text(slideShowText1_1,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Colors.green,letterSpacing: 1)),
                                        ],
                                      )
                                    ),
                                  )
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'Assets/Image/biopesticides_image.jpg',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(slideShowText2_0,style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.black45),),
                                              Text(slideShowText2_1,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Colors.green,letterSpacing: 1)),
                                            ],
                                          )
                                      ),
                                    )
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'Assets/Image/weather_forecasting.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(slideShowText3_0,style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.black45),),
                                              Text(slideShowText3_1,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,color: Colors.green,letterSpacing: 1)),
                                            ],
                                          )
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                   ),
                 ],
               ),

              SizedBox(height:20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(cropDiseaseTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
              ),
              InkWell(
                onLongPress: (){
                  Navigator.popAndPushNamed(context,'/cropDisease');
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border(right: BorderSide(color: Colors.black54)),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.black45,
                        offset: Offset(
                          2,
                          2,
                        ),
                      )],
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 5,),
                            Image(image: AssetImage('Assets/Image/crop diseas icon.png'),height: 90,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(cropDiseaseText1,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.green),),
                                // Text(cropDiseaseText2,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black54),),
                                SizedBox(height: 10,),
                                TextButton(onPressed: (){
                                  Navigator.popAndPushNamed(context,'/cropDisease');
                                }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(41, 110, 46, 1.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                                    child: Text(cropDiseaseBtn,style: TextStyle(color: Colors.white,letterSpacing: 1),),
                                  ),),
                              ],
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(height:20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(biopesticidesTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
              ),

              InkWell(
                onLongPress: (){
                  Navigator.popAndPushNamed(context,'/shopHomeSpinner');
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border(right: BorderSide(color: Colors.black54)),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.black45,
                        offset: Offset(
                          2,
                          2,
                        ),
                      )],
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10,),
                              Image(image: AssetImage('Assets/Image/pesticide_free.jpg'),height: 60,),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(biopesticidesText1,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.green),),
                                  // Text(biopesticidesText2,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black54),),
                                  SizedBox(height: 10,),
                                  TextButton(onPressed: (){
                                    Navigator.popAndPushNamed(context,'/shopHomeSpinner');
                                  }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(41, 110, 46, 1.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                                      child: Text(biopesticidesBtn,style: TextStyle(color: Colors.white,letterSpacing: 1),),
                                    ),),
                                ],
                              )
                            ],
                          ),

                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height:20,),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(weatherTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
              ),

              InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/weather_forecast_loader');
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border(right: BorderSide(color: Colors.black54)),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.black45,
                        offset: Offset(
                          2,
                          2,
                        ),
                      )],
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("$Location,"+DateFormat("dd MMMM").format(DateTime.now()).toString(),style: TextStyle(fontSize: 12,color: Colors.black87),),
                                        Text("$Temperature°C",style: TextStyle(fontSize: 35),),
                                        Text("$weatherSunset $Sunset",style: TextStyle(fontSize: 13,color: Colors.black54),),
                                      ],
                                    ),
                              Image(image: AssetImage('Assets/Image/Weather/50d.png'))
                            ],
                          ),
                          SizedBox(height: 10,),
                          TextButton(onPressed: (){
                            Navigator.pushReplacementNamed(context, '/weather_forecast_loader');
                          }, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(41, 110, 46, 1.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30,top: 5,right: 30,bottom: 5),
                              child: Text(weatherbtn,style: TextStyle(color: Colors.white,letterSpacing: 1),),
                            ),),
                        ],
                      ),
                  ),
                ),
              ),

            ],
          ),
        ),


        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(255,255,255,1),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Colors.green),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black45,
          elevation: 20,
          iconSize: 24,
          // ImageIcon(AssetImage('Assets/Image/tab_home.png',))

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_home.png',)), SizedBox(height: 4.0),],), label: '$home',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/expenses.png',)), SizedBox(height: 4.0),],), label: '$expense',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_shop.png',)), SizedBox(height: 4.0),],), label: '$shop',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_crop.png',)), SizedBox(height: 4.0),],), label: '$crop',),
            BottomNavigationBarItem(icon: Column(children: [ ImageIcon(AssetImage('Assets/Image/tab_setting.png',)), SizedBox(height: 4.0),],), label: '$settings',),
          ],
        )
      ),
  );


  Future<Object> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.pushReplacementNamed(context, '/openLocationSettings');

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Navigator.pushReplacementNamed(context, '/openAppSettings');
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      Navigator.pushReplacementNamed(context, '/openAppSettings');
      return Future.error("Location Service permenentaly denied");
    }

    // Timer(Duration(seconds:3),
    //         ()=>Navigator.pushReplacementNamed(context, '/weather_forecast'));
    return await Geolocator.getCurrentPosition();
  }
}


Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   // await Geolocator.openLocationSettings();
  //   // Timer(Duration(seconds:2),()=>Navigator.pushReplacementNamed(context, '/home'));
  //   return Future.error('Location services are disabled.');
  // }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    // await Geolocator.openAppSettings();
    // Timer(Duration(seconds:2),()=>Navigator.pushReplacementNamed(context, '/home'));
      return Future.error('Location permissions are denied');
  }

  if (permission == LocationPermission.deniedForever) {
    // await Geolocator.openAppSettings();
      permission = await Geolocator.requestPermission();
      // Timer(Duration(seconds:2),()=>Navigator.pushReplacementNamed(context, '/home'));
    return Future.error("Location Service permenentaly denied");
  }

  // Timer(Duration(seconds:2),()=>Navigator.pushReplacementNamed(context, '/home'));

  return await Geolocator.getCurrentPosition();
}




