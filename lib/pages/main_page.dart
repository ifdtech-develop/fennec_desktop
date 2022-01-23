import 'package:fennec_desktop/pages/chat/chat_screen.dart';
import 'package:fennec_desktop/pages/squad/squad_screen.dart';
import 'package:fennec_desktop/pages/team/team_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isTeamVisible = false;
  bool _isSquadVisible = false;
  bool _isChatVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sidebarNavigation(),
        Visibility(
          visible: _isTeamVisible,
          child: const TeamScreen(),
        ),
        Visibility(
          visible: _isSquadVisible,
          child: const SquadScreen(),
        ),
        Visibility(
          visible: _isChatVisible,
          child: const ChatScreen(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mainButtons(Icons.groups, 0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: mainButtons(Icons.format_list_bulleted, 1),
            ),
            mainButtons(Icons.chat, 2),
          ],
        ),
      ],
    );
  }

  InkWell mainButtons(IconData icon, int id) {
    return InkWell(
      onTap: () {
        setState(() {
          id == 0
              ? _isTeamVisible = !_isTeamVisible
              : id == 1
                  ? _isSquadVisible = !_isSquadVisible
                  : _isChatVisible = !_isChatVisible;
        });
      },
      child: Card(
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
      ),
    );
  }

  Container sidebarNavigation() {
    const TextStyle listStyle = TextStyle(fontSize: 16.0, color: Colors.white);

    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      decoration: BoxDecoration(
        // color: Color(0xFFF5F5F5),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          // stops: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
          colors: [
            const Color(0xFFFB00B8).withOpacity(0.8),
            const Color(0xFFFB2588).withOpacity(0.8),
            const Color(0xFFFB3079).withOpacity(0.8),
            const Color(0xFFFB4B56).withOpacity(0.8),
            const Color(0xFFFB5945).withOpacity(0.8),
            const Color(0xFFFB6831).withOpacity(0.8),
            const Color(0xFFFB6E29).withOpacity(0.8),
            const Color(0xFFFB8C03).withOpacity(0.8),
            const Color(0xFFFB8D01).withOpacity(0.8),
            const Color(0xFFFB8E00).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              // Image.asset('assets/images/profile.png'),
              Icon(Icons.person, size: 40.0, color: Colors.white),
              Text('Perfil', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/teams.png'),
              Icon(Icons.groups, size: 40.0, color: Colors.white),
              Text('Time', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/workspace.png'),
              Icon(Icons.workspaces, size: 40.0, color: Colors.white),
              Text('Workspace', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/feed.png'),
              Icon(Icons.feed, size: 40.0, color: Colors.white),
              Text('Feed', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/ead.png'),
              Icon(Icons.computer, size: 40.0, color: Colors.white),
              Text('EAD', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/certificates.png'),
              Icon(Icons.star, size: 40.0, color: Colors.white),
              Text('Certificados', style: listStyle)
            ],
          ),
          Column(
            children: const [
              // Image.asset('assets/images/logout.png'),
              Icon(Icons.logout, size: 40.0, color: Colors.white),
              Text('Sair', style: listStyle)
            ],
          ),
        ],
      ),
    );
  }
}
