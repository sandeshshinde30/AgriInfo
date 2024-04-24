
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';

class shopTheme
{
  Padding product_info([String title = "none" , String description = "none"])
  {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: ExpansionTile(
        title: Text(title,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          selectionColor: Colors.cyan,
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 30),
            child: ExpandableText(
              description,
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 3,
              linkColor: Colors.cyan,
              style: TextStyle(fontSize: 13,letterSpacing: 0.7),
            ),
          )
        ],
      ),
    );
  }

  Padding ref_link([String title = "none" , String description = "none"]) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ExpansionTile(
        title: Text(
          title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          selectionColor: Colors.cyan,
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: InkWell(
              onTap: () async
              {
                print("ref link");
                // var url = "https://agrinfo.000webhostapp.com/register.php";
                launch('$description');
              },
              child: ExpandableText(
                description,
                urlStyle: TextStyle(color: Colors.cyan),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 3,
                linkColor: Colors.cyan,
                style: TextStyle(fontSize: 13, letterSpacing: 0.7),
              ),
            ),
          )
        ],
      ),
    );
  }



    Expanded Product(BuildContext context,[String name="none",String price = "0",String Likes = "-1",String imageSrc = "Assets/Image/Weather/Criyagen.png"])
  {
    return Expanded(flex:7,child: InkWell(
      onTap: (){
        Navigator.popAndPushNamed(context, '/shopProductSpinner',arguments: name);
      },
      child: Container(
        color: Color.fromRGBO(163, 214, 178,0.1),
        height: 230,
        child: Column(
          children: [
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(flex : 2, child: Image.network(imageSrc,height: 120,)),
                Expanded(flex : 1, child: Column(
                  children: [
                    IconButton(onPressed: (){}, icon: Image.asset('Assets/Image/like.png',color: Colors.pink,width:25,)),
                    Text("$Likes Likes",style: TextStyle(fontSize: 10),)
                  ],
                ) ,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(name,style: TextStyle(fontSize: 10),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\u{20B9}${price}",style: TextStyle(fontSize: 15 ,wordSpacing: 2 , fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }


  Column shopProduct(String language , BuildContext context ,List imgsrc,[String name = "none",available_quantity = "none",quantity_type = "none",double Price = 0.0,String available = "none" ,String about_product = "none",String suitable_crops="none",String description = "none",String composition = "none", String dosage = "none",String referance_link = "none"])
  {
   var available_qnty = available_quantity.split("_");
   var qnty_length = available_qnty.length;

   String? availabe_quantities_txt="Available Quantities";
   String? description_txt="Description";
   String? suitable_crops_txt="Suitable Crops";
   String? about_product_txt="About Product";
   String? composition_txt="Composition";
   String? dosage_txt="Dosage";
   String? referance_link_txt="Referance Link";

   if(language == "marathi")
   {
       availabe_quantities_txt="उपलब्ध प्रमाणात";
       description_txt="वर्णन";
       suitable_crops_txt="योग्य पिके";
       about_product_txt="उत्पादन बद्दल";
       composition_txt="रचना";
       dosage_txt="डोस";
       referance_link_txt="संदर्भ लिंक";
   }
   if(language == "hindi")
   {
     availabe_quantities_txt="उपलब्ध मात्राएँ";
     description_txt="विवरण";
     suitable_crops_txt="उपयुक्त फसलें";
     about_product_txt="उत्पाद के बारे में";
     composition_txt="संघटन";
     dosage_txt="डोज़";
     referance_link_txt="संदर्भ लिंक";
   }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: 250,
          initialPage: 0,
          indicatorColor: Colors.transparent,
          autoPlayInterval: 8000,
          isLoop: false,
          indicatorBackgroundColor: Colors.white,
          children: [
            ImageSlideshow(
              width: MediaQuery.of(context).size.width,
              initialPage: 0,
              indicatorColor: Colors.deepOrange,
              autoPlayInterval: 150000,
              isLoop: false,
              indicatorBackgroundColor: Colors.white,
              children: [
                if(imgsrc[0]!=null)
                  for(int i = 0;i<4;i++)
                    Image.network(imgsrc[i])
              ],
            ),
          ],
        ),
        SizedBox(height: 30,),
        Center(child: Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 0.2,wordSpacing: 2),)),
        Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex : 2, child: Text('\u{20B9}${Price}',style: TextStyle(fontSize: 18 ,wordSpacing: 2 , fontWeight: FontWeight.bold,))),
                Expanded(flex : 3 , child: Text(available,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color: Color.fromRGBO(20, 79, 22,1)),)),
              Expanded(flex : 1, child: IconButton(onPressed: (){}, icon: Image.asset('Assets/Image/like.png',color: Color.fromRGBO(93, 150, 101,0.6),width:25,))),
              Expanded(flex : 1 ,child: IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('Assets/Image/cart_field.png',),color: Color.fromRGBO(93, 150, 101,0.6),size: 30,)))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:15,left: 20),
          child: Text("$availabe_quantities_txt",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        ),

        Padding(
          padding: const EdgeInsets.only(top:15,left: 20),
          child : Row(
            children: [

                  for(int i =0;i<qnty_length;i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextButton(onPressed: (){}, style: TextButton.styleFrom(backgroundColor: Color.fromRGBO(20, 79, 22,1)),
                      child: Text(available_qnty[i].toString() + " $quantity_type",style: TextStyle(color: Colors.white),),),
                  ),
            ],
          ),
        ),
        SizedBox(height: 20,),

        product_info("$description_txt","$description"),

        product_info("$suitable_crops_txt","$suitable_crops"),

        product_info("$about_product_txt","$about_product"),

        product_info("$composition_txt","$composition"),

        product_info("$dosage_txt","$dosage"),

        ref_link("$referance_link_txt","$referance_link"),

        SizedBox(height: 200,)
      ],
    );
  }


  // Container allProducts(BuildContext context)
  // {
  //   return
  //       Container(
  //         width: MediaQuery.of(context).size.width,
  //         color: Color.fromRGBO(199, 237, 210,0.1),
  //         height: 280,
  //         child: Column(
  //           children: [
  //             SizedBox(height: 15,),
  //             Row(
  //               children: [
  //                 // Product(context,"Criyagen 00-55-34",270.00,435.00,165.00,'Assets/Image/Weather/Criyagen.png'),
  //                 // Expanded(flex:1,child: Container(),),
  //                 // Product(context,"Criyagen 00-55-34",270.00,435.00,165.00,'Assets/Image/Weather/Criyagen.png'),
  //               ],
  //             ),
  //           ],
  //         ),
  //   );
  // }

  Column cart(BuildContext context , [int item = 0])
  {
    return Column(
      children: [
        if(item <= 0)
          Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Image.asset('Assets/Image/empty_cart.png',height: 150,),
                SizedBox(height: 20,),
                Text("Your cart is empty",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w600,fontSize: 20),)
              ],
            ),
          ),
        // if(item > 0)
        //   allProducts(context),
      ],
    );
  }

  Column favorite(BuildContext context , [int item = 0])
  {
    return Column(
      children: [
        if(item <= 0)
          Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Image.asset('Assets/Image/love_heart.png',height: 100,),
                SizedBox(height: 20,),
                Text("No items in favorites",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w600,fontSize: 20),)
              ],
            ),
          ),
        // if(item > 0)
        //   allProducts(context),
      ],
    );
  }

  Column notification(BuildContext context , [int item = 0])
  {
    return Column(
      children: [
        if(item <= 0)
          Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Image.asset('Assets/Image/notification.png',height: 100,),
                SizedBox(height: 20,),
                Text("No Notification Found!",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w600,fontSize: 20),)
              ],
            ),
          ),
        // if(item > 0)
        //   allProducts(context),
      ],
    );
  }

  Container allProducts(context,[productName1="",productName2="",price1="",price2="",likes1="",likes2="",imgsrc1="",imgsrc2=""])
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(199, 237, 210,0.1),
      height: 250,
      child: Column(
        children: [
          SizedBox(height: 15,),
          Row(
            children: [
              Product(context,productName1,price1,likes1,imgsrc1),
              Expanded(flex:1,child: Container(),),
              Product(context,productName2,price2,likes2,imgsrc2),
            ],
          ),
        ],
      ),
    );
  }

}

