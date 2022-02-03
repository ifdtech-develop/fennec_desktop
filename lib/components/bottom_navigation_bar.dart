import 'package:flutter/material.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  const BottomNavigationBarComponent({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarComponent> createState() =>
      _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState
    extends State<BottomNavigationBarComponent> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
