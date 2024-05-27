import 'package:flutter/material.dart';
import 'package:sprint2/paginas/tipoBusca.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Eureka Finder",
      home: tipoBusca(),
    );
  }
}