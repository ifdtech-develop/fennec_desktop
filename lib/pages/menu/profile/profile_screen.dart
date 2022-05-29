import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userFirstLetter = '';
  late String userName = '';
  late String userPhone = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name')!;
      userPhone = prefs.getString('phone')!;
      userFirstLetter = prefs.getString('name')!.substring(0, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 58.0, bottom: 50.0),
          child: Text(
            'Editar Perfil',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(
            width: 70.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                height: 70.0,
                child: Center(
                  child: Text(
                    userFirstLetter,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
              child: Text(userName),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Text(
            'Telefone',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
              child: Text(userPhone),
            ),
          ],
        ),
        Container()
      ],
    );
  }
}
