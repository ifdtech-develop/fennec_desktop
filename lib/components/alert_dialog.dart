import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String description;

  const CustomAlertDialog({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alerta',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        "$description.\n\nEntre em contato com o suporte.",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
