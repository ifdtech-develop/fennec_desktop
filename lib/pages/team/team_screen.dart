import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 500.0,
          width: 500.0,
          // alignment: FractionalOffset.center,
          child: Stack(
            //alignment:Alignment(x, y)
            children: const [
              Icon(Icons.monetization_on,
                  size: 36.0, color: Color.fromRGBO(218, 165, 32, 1.0)),
              Positioned(
                left: 20.0,
                child: Icon(Icons.monetization_on,
                    size: 36.0, color: Color.fromRGBO(218, 165, 32, 1.0)),
              ),
              Positioned(
                left: 40.0,
                child: Icon(Icons.monetization_on,
                    size: 36.0, color: Color.fromRGBO(218, 165, 32, 1.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
