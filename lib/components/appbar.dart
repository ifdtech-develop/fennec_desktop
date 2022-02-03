import 'package:flutter/material.dart';

class AppbarComponent extends StatelessWidget with PreferredSizeWidget {
  const AppbarComponent({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 50.0,
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
      ),
      toolbarHeight: 80,
      elevation: 0,
    );
  }
}
