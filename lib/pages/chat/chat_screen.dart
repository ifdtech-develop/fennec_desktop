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
    );
  }
}
