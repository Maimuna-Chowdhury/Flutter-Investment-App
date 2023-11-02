import 'package:flutter/material.dart';
import 'package:investment_agro/constant/AppColors.dart';
import 'package:investment_agro/src/ui/bottom_nav_pages/cart.dart';
import 'package:investment_agro/src/ui/bottom_nav_pages/favorite.dart';
import 'package:investment_agro/src/ui/bottom_nav_pages/home.dart';
import 'package:investment_agro/src/ui/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget{
  @override
  _BottomNavControllerState createState()=> _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController>{
  @override

  final List<Widget>  _pages=[Home(),Favorite(),Cart(),Profile()];
  int _currentIndex=0;
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Welcome to WeGRO",
              style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
         bottomNavigationBar: BottomNavigationBar(
           selectedItemColor: Color(0xFF586B00),
           unselectedItemColor: Color(0xFF638B4D),
           selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
           unselectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
           items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home",backgroundColor: Color(0xFF9BC27E)),
             BottomNavigationBarItem(icon: Icon(Icons.favorite),label:"Favorite",backgroundColor: Color(0xFF9BC27E)),
             BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),label:"Cart",backgroundColor: Color(0xFF9BC27E)),
             BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile",backgroundColor: Color(0xFF9BC27E)),
           ],
           onTap:(index){
             setState(() {
               if (index >= 0 && index < _pages.length) {
                 _currentIndex = index;
               }

             });
           } ,
           selectedIconTheme: IconThemeData(color: Color(0xFF586B00)), // Set the color of the selected icon
           unselectedIconTheme: IconThemeData(color: Colors.white),
         ),
         body: _pages[_currentIndex],
    );
  }
}