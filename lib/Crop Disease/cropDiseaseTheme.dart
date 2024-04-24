

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cropDiseaseTheme
{

  InkWell cropCircle(BuildContext context , [String name = "none",String imgSrc = "https://image3.photobiz.com/8852/3_20171212101935_22529028_large.jpg"])
  {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context,'/showDiseaseSpinner');
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 50,
              child: Image.network(imgSrc),
            )
          ),
          Text(name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  Padding searchDisease([String imgSrc = "Assets/Image/Greening.jpg"])
  {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(89, 204, 227,0.8),
        backgroundImage: NetworkImage(imgSrc),
        radius: 50,
      ),
    );
  }

  Container showDisease(String language,BuildContext context,[String Diseasename = "none",String imgSrc = ""])
  {
    String seeMore = "See More";
    if(language == "marathi")
      {
        seeMore = "अजून पहा";
      }
    if(language == "hindi")
    {
        seeMore = "और देखें";
    }
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(199, 237, 210,0.3),
      ),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            cropDiseaseTheme().searchDisease(imgSrc),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Diseasename,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,'/showDiseaseSpinner',arguments: Diseasename);
                    },
                    child: Row(
                      verticalDirection: VerticalDirection.up,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("$seeMore",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color.fromRGBO(4, 133, 51,0.8)),),
                        Icon(Icons.arrow_forward_ios_rounded,size:20,color: Color.fromRGBO(4, 133, 51,0.8))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column notFound()
  {
    return Column(
      children: [
        SizedBox(height: 100,),
        Center(
              child: Text("Nothing Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
      ],
    );
  }

  Padding showDiseaseInfo([String title = "none" , String description = "nothing"])
  {
    return Padding(
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

  Container cropDiseaseRecommendedProduct(BuildContext context,[String name = "none" , String imgSrc = "Assets/Image/pesticide.png"])
  {
    return Container(
        margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(231, 223, 234, 1.0),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 15,),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: AssetImage(imgSrc),
              ),
              SizedBox(width: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,'/shopProduct');
                    },
                    child: Row(
                      verticalDirection: VerticalDirection.up,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("See Info",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Color.fromRGBO(4, 133, 51,0.8)),),
                        Icon(Icons.arrow_forward_ios_rounded,size:17,color: Color.fromRGBO(4, 133, 51,0.8))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }

  Column savedCropDisease(BuildContext context , int item , [String name = "none" , String imgSrc = "Assets/Image/Greening.jpg"])
  {
    return Column(
      children: [
        if(item <= 0)
        Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Image.asset('Assets/Image/save_for_later_filled.png',height: 150,color: Colors.purple,),
              SizedBox(height: 20,),
              Text("Nothing Saved",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w600,fontSize: 20,),)
            ],
          ),
        ),

        if(item>0)
          Container(
            margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(199, 232, 219, 1.0),
            ),
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    backgroundImage: AssetImage(imgSrc),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context,'/showDiseaseSpinner');
                        },
                        child: Row(
                          verticalDirection: VerticalDirection.up,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("See Info",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Color.fromRGBO(4, 133, 51,0.8)),),
                            Icon(Icons.arrow_forward_ios_rounded,size:17,color: Color.fromRGBO(4, 133, 51,0.8))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      ],
    );
  }

  InkWell zoomCropDisease(BuildContext context , [String cropDiseaseImg = 'https://agrinfo.000webhostapp.com/Images/image_loading_error.jpg'])
  {
    return InkWell( onTap: (){
      showDialog(context: context, builder: (context) => AlertDialog(
        content: Image.network(cropDiseaseImg,fit: BoxFit.fitWidth),
        backgroundColor: Color.fromRGBO(245, 252, 247,1),
      ),
      );
    },
      child: Image.network(cropDiseaseImg,fit: BoxFit.fitWidth),
    );
  }
}