import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:life_capsule/calender.dart';
import 'package:life_capsule/firebase_options.dart';
import 'package:life_capsule/home.dart';
import 'package:life_capsule/payment.dart';
import 'package:life_capsule/splashscreen.dart';

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home:
      // CalendarPage()
      Splashscreen()
    );
  }
}
