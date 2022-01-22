import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
              color: Color(0xFFCCCCCC),
            ),
            height: MediaQuery.of(context).size.height,
            child: const Text('data'),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
              color: Color(0xFFF3F2F3),
            ),
            height: MediaQuery.of(context).size.height,
            child: const Text('data'),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
              color: Color(0xFF5CE1E6),
            ),
            height: MediaQuery.of(context).size.height,
            child: const Text('data'),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            MainButtons(
              icon: Icons.groups,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: MainButtons(
                icon: Icons.format_list_bulleted,
              ),
            ),
            MainButtons(
              icon: Icons.chat,
            ),
          ],
        ),
      ],
    );
  }
}

class MainButtons extends StatelessWidget {
  final IconData icon;

  const MainButtons({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: const Color(0xFFF5F5F5),
      shadowColor: const Color(0xFFCCCCCC),
      child: Padding(
        // padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          size: 50.0,
        ),
      ),
    );
  }
}
