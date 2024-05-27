import 'package:flutter/material.dart';

class AppBarM extends StatelessWidget implements PreferredSizeWidget {
  const AppBarM({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
