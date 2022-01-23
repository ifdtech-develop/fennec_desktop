import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  final String backgroundColor;
  const TeamScreen({Key? key, required this.backgroundColor}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        //background do container teams que deve mudar de acordo com o widget selecionado
        color: Color(int.parse(widget.backgroundColor)),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
            color: Color(0xFFCCCCCC),
          ),
          height: MediaQuery.of(context).size.height,
          // child: const Text('Team'),
          child: const Text('Team'),
        ),
      ),
    );
  }
}
