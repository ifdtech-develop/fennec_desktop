import 'package:fennec_desktop/models/sidebar_buttons.dart';
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
              Container(
                child: sidebarButtons[widgetIndex].content,
              )
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

  Widget sidebarNavigation() {
    return Center(
      child: ListView.builder(
        itemCount: sidebarButtons.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                //a aba do menu só fecha se for o  mesmo botão clicado duas vezes,
                //se for outro botão do menu, ele somente muda o conteúdo
                if (widgetIndex == index) {
                  widgetIndex = index;
                  _isMenuVisible = !_isMenuVisible;
                  //ao clicar, aviso ao parent widget que houve uma ação
                  widget.onCountSelected();
                } else {
                  widgetIndex = index;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
              child: Column(
                children: [
                  Icon(
                    sidebarButtons[index].icon,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  Text(sidebarButtons[index].title, style: listStyle)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
