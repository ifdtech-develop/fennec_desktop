import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final String backgroundColor;
  //Por essa função, aviso ao component pai que chamar esse widget que aconteceu uma
  //ação nesse widget
  final VoidCallback onCountSelected;

  const MenuScreen({
    Key? key,
    required this.backgroundColor,
    required this.onCountSelected,
  }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextStyle listStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
  bool _isMenuVisible = false;
  final List<Color> gradientColors = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return _isMenuVisible ? expandedMenu(context) : menuOnly(context);
  }

  Expanded expandedMenu(BuildContext context) {
    return Expanded(
      child: Container(
        //background do container teams que deve mudar de acordo com o widget selecionado
        color: Color(int.parse(widget.backgroundColor)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: gradientColors,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                child: sidebarNavigation(),
              ),
              const Text('Menu'),
            ],
          ),
        ),
      ),
    );
  }

  Container menuOnly(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: gradientColors,
        ),
      ),
      child: sidebarNavigation(),
    );
  }

  Column sidebarNavigation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isMenuVisible = !_isMenuVisible;
              //ao clicar, aviso ao parent widget que houve uma ação
              widget.onCountSelected();
            });
          },
          child: Column(
            children: [
              // Image.asset('assets/images/profile.png'),
              const Icon(Icons.person, size: 40.0, color: Colors.white),
              Text('Perfil', style: listStyle)
            ],
          ),
        ),
        Column(
          children: [
            // Image.asset('assets/images/teams.png'),
            const Icon(Icons.groups, size: 40.0, color: Colors.white),
            Text('Time', style: listStyle)
          ],
        ),
        Column(
          children: [
            // Image.asset('assets/images/workspace.png'),
            const Icon(Icons.workspaces, size: 40.0, color: Colors.white),
            Text('Workspace', style: listStyle)
          ],
        ),
        Column(
          children: [
            // Image.asset('assets/images/feed.png'),
            const Icon(Icons.feed, size: 40.0, color: Colors.white),
            Text('Feed', style: listStyle)
          ],
        ),
        Column(
          children: [
            // Image.asset('assets/images/ead.png'),
            const Icon(Icons.computer, size: 40.0, color: Colors.white),
            Text('EAD', style: listStyle)
          ],
        ),
        Column(
          children: [
            // Image.asset('assets/images/certificates.png'),
            const Icon(Icons.star, size: 40.0, color: Colors.white),
            Text('Certificados', style: listStyle)
          ],
        ),
        Column(
          children: [
            // Image.asset('assets/images/logout.png'),
            const Icon(Icons.logout, size: 40.0, color: Colors.white),
            Text('Sair', style: listStyle)
          ],
        ),
      ],
    );
  }
}
