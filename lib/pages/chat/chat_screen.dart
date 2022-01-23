import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        //background do container teams que deve mudar de acordo com o widget selecionado
        // color: Color(0xFF5CE1E6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0.5, 0.5],
            colors: [
              Color(0xFFFFFFFF),
              // Colors.red,
              Color(0xFF5CE1E6),
            ],
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
            color: Color(0xFF5CE1E6),
          ),
          height: MediaQuery.of(context).size.height,
          child: const Text('Chat'),
        ),
      ),
    );
  }
}
