import 'package:fennec_desktop/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// não mostra o scrollBar na aplicação inteira
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 50.0,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
        toolbarHeight: 80,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: const MainPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: '',
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            tooltip: '',
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        mouseCursor: SystemMouseCursors.alias,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
