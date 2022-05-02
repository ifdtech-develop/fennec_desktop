import 'package:fennec_desktop/main.dart';
import 'package:fennec_desktop/pages/menu/profile/profile_screen.dart';
import 'package:fennec_desktop/pages/menu/user_teams.dart/user_teams_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final String backgroundColor;
  //Por essa função, aviso ao component pai que chamar esse widget que aconteceu uma
  //ação nesse widget
  final VoidCallback onProfileSelected;
  final VoidCallback onGeralSelected;
  final VoidCallback onFeedSelected;

  const MenuScreen({
    Key? key,
    required this.backgroundColor,
    required this.onProfileSelected,
    required this.onGeralSelected,
    required this.onFeedSelected,
  }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isMenuVisible = false;
  late int widgetIndex = 0;

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

  Widget expandedMenu(BuildContext context) {
    return Container(
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
      width: 502.0,
      child: Row(
        children: [
          Container(
            width: 100.0,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            child: sidebarNavigation(),
          ),
          Container(
            margin: const EdgeInsets.only(left: 70.0),
            width: 250.0,
            child: const ProfileScreen(),
          )
        ],
      ),
    );
  }

  Container menuOnly(BuildContext context) {
    return Container(
      //background do container teams que deve mudar de acordo com o widget selecionado
      color: Color(int.parse(widget.backgroundColor)),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(70.0),
            bottomRight: Radius.circular(70.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: gradientColors,
          ),
        ),
        child: sidebarNavigation(),
      ),
    );
  }

  Widget sidebarNavigation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SidebarButtons(
            icon: Icons.person,
            title: 'Perfil',
            onSelect: () {
              setState(() {
                _isMenuVisible = !_isMenuVisible;
                //ao clicar, aviso ao parent widget que houve uma ação
                widget.onProfileSelected();
              });
            },
          ),
        ),
        SidebarButtons(
          icon: Icons.feed,
          title: 'Feed',
          onSelect: () {
            setState(() {
              widget.onFeedSelected();
              //se o menu do perfil aberto, fechar ele
              if (_isMenuVisible) {
                _isMenuVisible = !_isMenuVisible;
              }
            });
          },
        ),
        SidebarButtons(
          icon: Icons.groups,
          title: 'Time',
          onSelect: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserTeamsScreen()),
              );
              //se o menu do perfil aberto, fechar ele
              if (_isMenuVisible) {
                _isMenuVisible = !_isMenuVisible;
              }
            });
          },
        ),
        SidebarButtons(
          icon: Icons.groups,
          title: 'Geral',
          onSelect: () {
            setState(() {
              widget.onGeralSelected();
              //se o menu do perfil aberto, fechar ele
              if (_isMenuVisible) {
                _isMenuVisible = !_isMenuVisible;
              }
            });
          },
        ),
        SidebarButtons(
          icon: Icons.workspaces,
          title: 'Workspace',
          onSelect: () {},
        ),
        SidebarButtons(
          icon: Icons.computer,
          title: 'EAD',
          onSelect: () {},
        ),
        SidebarButtons(
          icon: Icons.star,
          title: 'Certificados',
          onSelect: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SidebarButtons(
            icon: Icons.logout,
            title: 'Sair',
            onSelect: () {
              prefs.remove('token');
              prefs.remove('name');
              prefs.remove('phone');
              Navigator.of(context).pushNamed('/loginPage');
            },
          ),
        ),
      ],
    );
  }
}

class SidebarButtons extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onSelect;

  const SidebarButtons({
    Key? key,
    required this.icon,
    required this.title,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                icon,
                size: 28.0,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}
