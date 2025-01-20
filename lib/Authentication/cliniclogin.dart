import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_capsule/Authentication/clinicregistration.dart';
import 'package:life_capsule/Authentication/forgotPasswordPage.dart';
import 'package:life_capsule/Authentication/registeration.dart';
import 'package:life_capsule/clinicdash.dart';
import 'package:life_capsule/home.dart';
import 'package:life_capsule/widget/custom-widget.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';


class Cliniclogin extends StatefulWidget {
  const Cliniclogin({super.key});

  @override
  State<Cliniclogin> createState() => _ClinicloginState();
}

class _ClinicloginState extends State<Cliniclogin> {
  String email = "", password = "";
  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Clinicdash()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      } else {
        // Handle other exceptions (e.g., network errors)
        // Don't print the error code, use a generic message
        showDialog(
          context: context, // Replace with your context provider
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign In Error'),
              content: const Text(
                  'Invalid Email or Password. Please enter correct credentials.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool _secureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.deepOrange,
          title: Text("Login"),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Center(
              //heightFactor: 1.5,

              child: Form(
                key: _formkey,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // SizedBox(height: 20), // This is for gaping
                  Lottie.network(
                      "https://lottie.host/e4339ef4-f6b5-4fa8-a553-156c7bb1470d/kwXzHzz7uR.json",
                      height: 180,
                      fit: BoxFit.fill),
                  // Image.asset("assets/images/user.png",
                  //  height: 110, fit: BoxFit.fill),
                  //Image(image: AssetImage('assets/login3.png')),
                  SizedBox(height: 40),

                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Login as ",
                        style: TextStyle(color: Colors.black, fontSize: 23)),
                    TextSpan(
                      text: "Clinic",
                      style: Mywidget.skipText(),
                    )
                  ])),

                  SizedBox(height: 60), // This is for gaping

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                      //   controller: userIdController,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                                width: 2,
                              )),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "User ID",
                          hintText: "Please Enter User Id ..",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          labelStyle: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  ),

                  SizedBox(height: 10), // This is for gaping

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: _secureText,
                      decoration: InputDecoration(
                          suffixIconColor: Colors.green,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                                width: 2,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                              )),
                          labelText: "password",
                          hintText: "Please Enter Password ..",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          labelStyle: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              icon: Icon(_secureText
                                  ? Icons.remove_red_eye
                                  : Icons.security_outlined)),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  ),
SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Forgotpasswordpage();
                        }),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 34),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // This is for gaping

                  Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          fixedSize: Size(300, 50),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = _emailController.text;
                              password = _passwordController.text;
                            });
                          }
                          userLogin();
                        },
                      )),
                  SizedBox(height: 10),

                  //signup

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member ?'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Clinicregistration()));
                        },
                        child: Text(
                          ' Register now',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                     SizedBox(height: 40),
              
                ]),
              ),
            ))));
  }
}
