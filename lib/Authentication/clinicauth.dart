import 'package:flutter/material.dart';
// import 'package:life_capsule/Authentication/adminlogin.dart';
import 'package:life_capsule/Authentication/cliniclogin.dart';
import 'package:life_capsule/Authentication/clinicregistration.dart';
// import 'package:life_capsule/Authentication/userlogin.dart';
import 'package:life_capsule/widget/custom-widget.dart';
import 'package:lottie/lottie.dart';


class Clinicauth extends StatefulWidget {
  const Clinicauth({super.key}); 

  @override
  State<Clinicauth> createState() => _ClinicauthState();
}

class _ClinicauthState extends State<Clinicauth> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       // title: Text("User Login"),

      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          //color: const Color.fromARGB(255, 241, 61, 7),
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
              
          //    image: AssetImage("assets/images/food.png"),
          //     fit: BoxFit.cover ,
          //   ),
          // ),
          //   decoration: BoxDecoration(gradient: LinearGradient( colors: [
           
          //   Color.fromRGBO(252, 251, 251, 1),
          //    Colors.black,
          // ],
          // begin: Alignment.bottomCenter,
          // end: Alignment.topCenter,
          // )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                          children: [
            // const SizedBox(height: 50
            // ,),
            
                           Container(
                           height: 300,
            width: 300,
            child:
          Lottie.network("https://lottie.host/e4339ef4-f6b5-4fa8-a553-156c7bb1470d/kwXzHzz7uR.json"),

            //  Image.asset("assets/images/logo-color.png")
                          //   child:  const CircleAvatar(
                          //     backgroundImage: AssetImage("assets/images/logo-color.png") ,
                          //   ),
                           ),
            
            SizedBox(height: 50), // This is for gaping
            RichText(text: TextSpan(
              children: [
                TextSpan(text: "Login or Register as ",style: TextStyle(color: Colors.black,fontSize: 23)),
                TextSpan(text: "Clinic", style: Mywidget.skipText())
              ]
            )),
            SizedBox(height: 34,),
                     
            Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
            child: Text("Log in",style: TextStyle(color: Colors.white),),
            
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
                   MaterialPageRoute(builder: (context) => Cliniclogin()));
             },
                          )
                          ),
             Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
            child: Text("Register",style: TextStyle(color: Colors.white)),
            
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
                   MaterialPageRoute(builder: (context) => Clinicregistration()));
             },
                          )
                          ),
                         
                          ],
                        ),
          )),
    );
  }
}