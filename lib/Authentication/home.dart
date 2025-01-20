import 'package:flutter/material.dart';
import 'package:life_capsule/Authentication/adminlogin.dart';
import 'package:life_capsule/Authentication/clinicauth.dart';
import 'package:life_capsule/Authentication/userlogin.dart';
import 'package:lottie/lottie.dart';


class Home extends StatefulWidget {
  const Home({super.key}); 

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
   
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
         
          child: SingleChildScrollView(
            child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
              
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                          //  Padding(
                                          //    padding: const EdgeInsets.only(left:30,),
                                          //    child: Text("Life Capsule",style: TextStyle(fontFamily: 'PlaywriteGBS',color: Colors.green,fontWeight: FontWeight.bold,fontSize: 40),),
                                          //  ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                        Navigator.push(context,
                   MaterialPageRoute(builder: (context) => Adminlogin()));
                                    },
                                    child: Container(
                                      
                                      child: Column(
                                        children: [
                                          Lottie.network("https://lottie.host/5098f56c-7d62-4677-b318-4a309f8db3e8/UZBbzSBUNP.json",height: 70,fit: BoxFit.fill),
                                           Text("Admin",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                                        ],
                                      )),
                                  ),
                                )
                              ],
                            ),
            const SizedBox(height: 20
            ,),
            
                           Container(
             height: 400,
            width: 400,
            child: Image.asset("assets/images/logo.jpg",)
            ),
                           
           
                            // This is for gaping
             const SizedBox(height: 20
            ,),
                     
            Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
            child: Text("Clinic",style: TextStyle(color: Colors.white),),
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size(300, 50),
              textStyle:  TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () { 
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => Clinicauth()));
             },
                          )
                          ),
            
                           Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
            child: Text("User",style: TextStyle(color: Colors.white),),
            
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size(300, 50),
              textStyle:  TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () { 
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => Userlogin()));
             },
                          )
                          ),
                           Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Reports at your fingure tips!",style: TextStyle(fontFamily: 'PlaywriteGBS',color: Colors.green,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 50),
                          ],
                        ),
          )),
    );
  }
}
