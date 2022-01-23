import 'package:flutter/material.dart';

class SquadScreen extends StatefulWidget {
  const SquadScreen({Key? key}) : super(key: key);

  @override
  _SquadScreenState createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          color: Color(0xFFF3F2F3),
        ),
        height: MediaQuery.of(context).size.height,
        child: const Text('Squad'),
      ),
    );
  }
}
