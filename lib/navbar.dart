import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:life_capsule/home.dart';



class Adminnavbar extends StatefulWidget {
  const Adminnavbar({super.key});

  @override
  State<Adminnavbar> createState() => _AdminnavbarState();
}

class _AdminnavbarState extends State<Adminnavbar> {


  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home home;
  late Home home1;
  late Home home2;
  late Home home3;
  late Home home4;

  @override
  void initState() {
    home = Home();
    home1 = Home();
    home2 = Home();
    home3 = Home();
    home4 = Home();

   
    pages = [ home,home1,home2,home3,home4];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
        
      // ),
        
      // extendBody: true,

        bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.green,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items:  [
          
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
             Icon(
              Icons.home,
              color: Colors.white,
            ),
             Icon(
              Icons.home,
              color: Colors.white,
            ),
             Icon(
              Icons.home,
              color: Colors.white,
            ),
          ],
          ),
      body: pages[currentTabIndex], 
    );
  }
}
