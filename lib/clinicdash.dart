import 'package:flutter/material.dart';

class Clinicdash extends StatefulWidget {
  const Clinicdash({super.key});

  @override
  State<Clinicdash> createState() => _ClinicdashState();
}

class _ClinicdashState extends State<Clinicdash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinic"),
      ),
    );
  }
}