import 'package:flutter/material.dart';
import 'package:sprint2/paginas/login.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Eureka Finder",
      home: Login(),
    );
  }
}