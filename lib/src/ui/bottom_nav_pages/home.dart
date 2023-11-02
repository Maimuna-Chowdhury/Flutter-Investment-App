import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investment_agro/constant/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:investment_agro/src/ui/allProjects.dart';
import 'package:investment_agro/src/ui/product_details_screen.dart';
import 'package:investment_agro/src/ui/search_screen.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home>{
  List<String> _carouselImages=[];
  var _dotPosition=0;
  var _firestoreInstance = FirebaseFirestore.instance;
  //List _products=[];
  List<Map<String, dynamic>> _products = [];
  TextEditingController _searchController = TextEditingController();
  Future<void> fetchCursorImages() async {
    try {
      QuerySnapshot qn =
      await _firestoreInstance.collection("Carousel_slider").get();
      setState(() {
        _carouselImages = qn.docs.map((doc) => doc["img"] as String).toList();
      });
    } catch (e) {
      print("Error fetching images: $e");
    }
  }

 Future<void> fetchProducts() async {
   try {
     QuerySnapshot querySnapshot = await _firestoreInstance.collection(
         "products").get();
     if (querySnapshot.docs.isNotEmpty) {
       setState(() {
         _products = querySnapshot.docs.map((doc) {
           return {
             "name": doc["name"],
             "description": doc["description"],
             "price": doc["price"],
             "img": doc["img"],
           };
         }).toList();
       });
     } else {
       print("No products found");
     }
   }
    catch (e) {
      print("Error fetching images: $e");
    }
  }




  @override
  void initState() {
    fetchCursorImages();
    fetchProducts();
    super.initState();
  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left:20.w,right: 20.w),
                child:  Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          fillColor:Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(
                                  color: Colors.teal
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(
                                  color: Color(0xFF9BC27E)
                              )
                          ),
                          hintText: "Search here",
                          hintStyle: TextStyle(fontSize: 15.sp),
                        ),
                        onTap: ()=>Navigator.push(context,CupertinoPageRoute(builder: (__)=>SearchScreen())),
                      ),
                    ),),

                   GestureDetector(
                     child:  Container(
                       color: AppColors.light_green,
                       height: 50.h,
                       width: 50.h,
                       child: Center(
                         child: Icon(Icons.search,color: Colors.white,),

                       ),
                     ),
                     onTap: (){},
                   )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              AspectRatio
                (aspectRatio: 1.5,
                child: CarouselSlider(
                  items: _carouselImages.map((item) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(item),fit: BoxFit.cover)
                    ),

                  )).toList(),options:CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.99,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (val,carouselPageChangedReason){
                        setState(() {
                          _dotPosition=val;
                        });
                  }
                ) ,
                )
              ),


              SizedBox(height: 10.h,),
              DotsIndicator(
                dotsCount: _carouselImages.length==0?1:_carouselImages.length,
              position: _dotPosition,
               decorator: DotsDecorator(
                 activeColor: AppColors.light_green,
                 color: AppColors.light_green.withOpacity(0.5),
                 spacing: EdgeInsets.all(2),
                 activeSize: Size(8,8),
                 size: Size(6,6),

               ),
              ),

              // ... existing code remains unchanged ...

              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Projects",
                      style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add your view all logic here
                        Navigator.push(context,CupertinoPageRoute(builder: (__)=>AllProjects()));
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),



              SizedBox(height: 10.h),

              Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,childAspectRatio: 1
            ),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (__)=>ProductDetails(_products[index]))),
                child:  Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(aspectRatio: 2,
                        child: Image.network(
                          _products[index]["img"], // Assuming each product has only one image
                          height: 100, // Adjust the height as needed
                          width: 100, // Adjust the width as needed
                          fit: BoxFit.cover, // Adjust the fit property based on your requirement
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ${_products[index]["name"]}" ,
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
                            ),
                            Text(
                              "\$ ${_products[index]["price"]}",
                              style: TextStyle(color: Colors.green),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            },
          ),
        ),
        ],
          ),
        )
      ),
    );
  }
}