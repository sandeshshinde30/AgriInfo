import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Biopesticide extends StatefulWidget{
  @override
  State<Biopesticide> createState() => _bioState();
  
}

class _bioState extends State<Biopesticide>
{

  final List<Map<String, dynamic>> gridMap = [
    {
      "title" : "Organic Bio-Pesticides",
      "price" : "₹1000",
      "images" : "https://5.imimg.com/data5/SY/PC/MY-3446508/organic-bio-pesticides-500x500.jpg"
    },
    {
      "title" : "ANSHUL BIO FINISH (BIO PESTICIDE)",
      "price" : "₹366",
      "images" : "https://cdn.shopify.com/s/files/1/0722/2059/products/biofinish_800x.jpg?v=1632997266"
    },
    {
      "title" : "Bio Pesticides, Destroy Fly, 250ML-500ml-1litre",
      "price" : "₹950",
      "images" : "https://5.imimg.com/data5/SELLER/Default/2022/8/IJ/OL/UL/130333039/bio-pesticides-500x500.jpg"
    },
    {
      "title" : "Bio larvicide",
      "price" : "₹800",
      "images" : "https://5.imimg.com/data5/ANDROID/Default/2020/10/NQ/RK/SZ/14397763/product-jpeg-500x500.jpg"
    },
    {
      "title" : "AMRUTH ALMAX LIQUID (BIO PESTICIDE) (एम्रुथ ऐलमैक्स द्रव)",
      "price" : "₹215",
      "images" : "https://cdn.shopify.com/s/files/1/0722/2059/products/ALMAX_800x.jpg?v=1632996867"
    },
    {
      "title" : "b1",
      "price" : "₹100",
      "images" : "https://5.imimg.com/data5/SY/PC/MY-3446508/organic-bio-pesticides-500x500.jpg"
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // how many box can show 
                  crossAxisSpacing: 12.0, //for spacing between boxes
                  mainAxisSpacing: 12.0,  //for spacing between boxes
                  mainAxisExtent: 300, //to increase the size of box
                  ),
                itemCount: gridMap.length,
                itemBuilder: (context, index){
                  return Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromRGBO(139, 227, 143, 1),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(    //for edges of images
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0), 
                            topRight: Radius.circular(16.0),
                            ),
                          child: Image.network("${gridMap.elementAt(index)['images']}",   //box image designing
                          height: 170,                    //box image designing
                          width: double.infinity,         //box image designing
                          fit: BoxFit.cover,              //box image designing
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${gridMap.elementAt(index)['title']}", style: Theme.of(context).textTheme.subtitle1!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  ),
                                  ),
                              ),
                              
                              const SizedBox(height: 8.0,),

                              Text("${gridMap.elementAt(index)['price']}", style: Theme.of(context).textTheme.subtitle2!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey
                                  )
                                  )
                                  ),
                              const SizedBox(height: 8.0,),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){}, icon: Icon(CupertinoIcons.heart),

                                    ),
                                     IconButton(
                                    onPressed: (){}, icon: Icon(CupertinoIcons.cart),
                                    
                                    )
                                ],
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  );
                } ,
              ),
            ),
          ],
          ),
      ),
    );
  }

}