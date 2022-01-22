import 'package:fennec_desktop/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 50.0,
        title: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFFFB00B8),
                Color(0xFFFB2588),
                Color(0xFFFB3079),
                Color(0xFFFB4B56),
                Color(0xFFFB5945),
                Color(0xFFFB6831),
                Color(0xFFFB6E29),
                Color(0xFFFB8C03),
                Color(0xFFFB8D01),
                Color(0xFFFB8E00),
              ],
            ).createShader(rect);
          },
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: MainPage(),
    );
  }
}
