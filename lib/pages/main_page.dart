import 'package:fennec_desktop/components/appbar.dart';
import 'package:fennec_desktop/components/bottom_navigation_bar.dart';
import 'package:fennec_desktop/pages/chat/chat_screen.dart';
import 'package:fennec_desktop/pages/main_feed/main_feed_screen.dart';
import 'package:fennec_desktop/pages/menu/menu_screen.dart';
import 'package:fennec_desktop/pages/menu/workspace/workspace_screen.dart';
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
  bool _isWorkspaceVisible = false;
  String backgroundcolorMenu = '0xFFFDF5E6';
  String backgroundcolorTeams = '0xFFFFFFFF';
  String backgroundcolorSquad = '0xFFFFFFFF';
  bool chatIsOpen = false;
  final List<bool> _selected = List.generate(4, (i) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarComponent(),
      bottomNavigationBar: const BottomNavigationBarComponent(),
      // com stack os componentes irao ficar um em cima do outro
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 100.0, right: 60.0),
            child: MainFeedScreen(),
          ),
          // TIME/SQUAD/CHAT
          //conteudo principal serás sobreposto
          Padding(
            padding: const EdgeInsets.only(left: 100.0, right: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: _isTeamVisible,
                  child: TeamScreen(backgroundColor: backgroundcolorTeams),
                ),
                Visibility(
                  visible: _isSquadVisible,
                  child: SquadScreen(backgroundColor: backgroundcolorSquad),
                ),
                Visibility(
                  visible: _isChatVisible,
                  child: ChatScreen(isChatOpened: chatIsOpen),
                ),
                Visibility(
                  visible: _isWorkspaceVisible,
                  child: const WorkspaceScreen(),
                ),
              ],
            ),
          ),
          // MENU
          // sidebar ficara fixo e ao abrir o perfil, irá sobrepor o conteúdo principal
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Container(
              // container por traz do menu para que não apareça o conteúdo que o menu esta sobrepondo
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: MenuScreen(
                backgroundColor: backgroundcolorMenu,
                //por aqui, fico sabendo que houve uma ação no botao perfil
                onProfileSelected: () {
                  setState(() {
                    //estou alocando um valor booleano na posicao 3 do array
                    _selected[3] = !_selected[3];
                    //mudando a cor do background do container do menu acordo com o widget selecionado
                    if (_selected[3]) {
                      if (_selected[0]) {
                        backgroundcolorMenu = '0xFFCCCCCC';
                      } else if (!_selected[0] && _selected[1]) {
                        backgroundcolorMenu = '0xFFF3F2F3';
                      } else if (!_selected[0] &&
                          !_selected[1] &&
                          _selected[2]) {
                        backgroundcolorMenu = '0xFF5CE1E6';
                      } else if (!_selected[0] &&
                          !_selected[1] &&
                          !_selected[2]) {
                        backgroundcolorMenu = '0xFFFDF5E6';
                      }
                    }
                    _isWorkspaceVisible = false;
                  });
                },
                onGeralSelected: () {
                  setState(() {
                    //estou alocando um valor booleano na posicao 0 do array
                    _selected[0] = true;
                    _isTeamVisible = true;

                    //estou alocando um valor booleano na posicao 1 do array
                    _selected[1] = true;
                    _isSquadVisible = true;

                    //estou alocando um valor booleano na posicao 2 do array
                    _selected[2] = true;
                    _isChatVisible = true;

                    if (_selected[0] && _selected[1] && _selected[2]) {
                      backgroundcolorMenu = '0xFFCCCCCC';
                      backgroundcolorTeams = '0xFFF3F2F3';
                      backgroundcolorSquad = '0xFF5CE1E6';
                    } else {
                      backgroundcolorMenu = '0xFFFDF5E6';
                    }

                    // exibir o chat somente se tiver no maximo duas telas abertas
                    var count = _selected.where((element) => element == true);
                    if (count.length < 3) {
                      chatIsOpen = true;
                    } else {
                      chatIsOpen = false;
                    }

                    _isWorkspaceVisible = false;
                  });
                },
                onFeedSelected: () {
                  setState(() {
                    _isTeamVisible = false;
                    //estou alocando um valor booleano na posicao 0 do array
                    _selected[0] = false;
                    _isSquadVisible = false;
                    //estou alocando um valor booleano na posicao 1 do array
                    _selected[1] = false;
                    _isChatVisible = false;
                    //estou alocando um valor booleano na posicao 2 do array
                    _selected[2] = false;
                    // background do menu
                    backgroundcolorMenu = '0xFFFDF5E6';
                    _isWorkspaceVisible = false;
                  });
                },
                onWorkspaceSelected: () {
                  setState(() {
                    _isWorkspaceVisible = !_isWorkspaceVisible;
                    _isTeamVisible = false;
                    //estou alocando um valor booleano na posicao 0 do array
                    _selected[0] = false;
                    _isSquadVisible = false;
                    //estou alocando um valor booleano na posicao 1 do array
                    _selected[1] = false;
                    _isChatVisible = false;
                    //estou alocando um valor booleano na posicao 2 do array
                    _selected[2] = false;
                    if (_isWorkspaceVisible) {
                      backgroundcolorMenu = '0xFFE4E4E4';
                    } else {
                      backgroundcolorMenu = '0xFFFDF5E6';
                    }
                  });
                },
              ),
            ),
          ),
          // BOTOES ABRIR TELA TIME/SQUAD/CHAT
          //fica em cima das telas principais do conteudo principal
          Positioned(
            right: 20.0,
            bottom: 0.0,
            top: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mainButtons(Icons.groups, 0),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                  child: mainButtons(Icons.format_list_bulleted, 1),
                ),
                mainButtons(Icons.chat, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell mainButtons(IconData icon, int id) {
    return InkWell(
      onTap: () {
        setState(() {
          if (id == 0) {
            _isTeamVisible = !_isTeamVisible;
            //estou alocando um valor booleano na posicao 0 do array
            _selected[0] = !_selected[0];
          } else if (id == 1) {
            _isSquadVisible = !_isSquadVisible;
            //estou alocando um valor booleano na posicao 1 do array
            _selected[1] = !_selected[1];
          } else {
            _isChatVisible = !_isChatVisible;
            //estou alocando um valor booleano na posicao 2 do array
            _selected[2] = !_selected[2];
          }

          // exibir o chat somente se tiver no maximo duas telas abertas
          var count = _selected.where((element) => element == true);
          if (count.length < 3) {
            chatIsOpen = true;
          } else {
            chatIsOpen = false;
          }

          //mudando a cor do background do container teams de acordo com o widget selecionado
          if (_selected[0]) {
            if (_selected[1]) {
              backgroundcolorTeams = '0xFFF3F2F3';
            } else if (!_selected[1] && _selected[2]) {
              backgroundcolorTeams = '0xFF5CE1E6';
            } else if (!_selected[1] && !_selected[2]) {
              backgroundcolorTeams = '0xFFFFFFFF';
            }
          }
          //mudando a cor do background do container squad de acordo se widget chat selecionado ou não
          if (_selected[1]) {
            if (_selected[2]) {
              backgroundcolorSquad = '0xFF5CE1E6';
            } else if (!_selected[2]) {
              backgroundcolorSquad = '0xFFFFFFFF';
            }
          }
          //mudando a cor do background do container do menu acordo com o widget selecionado
          //quando expandido
          if (_selected[3]) {
            if (_selected[0]) {
              backgroundcolorMenu = '0xFFCCCCCC';
            } else if (!_selected[0] && _selected[1]) {
              backgroundcolorMenu = '0xFFF3F2F3';
            } else if (!_selected[0] && !_selected[1] && _selected[2]) {
              backgroundcolorMenu = '0xFF5CE1E6';
            } else if (!_selected[0] && !_selected[1] && !_selected[2]) {
              backgroundcolorMenu = '0xFFFFFFFF';
            }
          }

          //mudando a cor do background do container do menu acordo com o widget selecionado
          //quando nao expandido
          if (_selected[0]) {
            backgroundcolorMenu = '0xFFCCCCCC';
          } else if (!_selected[0] && _selected[1]) {
            backgroundcolorMenu = '0xFFF3F2F3';
          } else if (!_selected[0] && !_selected[1] && _selected[2]) {
            backgroundcolorMenu = '0xFF5CE1E6';
          } else {
            backgroundcolorMenu = '0xFFFDF5E6';
          }

          _isWorkspaceVisible = false;
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
          child: _selected[id]
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
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
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Icon(
                    icon,
                    size: 50.0,
                  ),
                )
              : Icon(
                  icon,
                  size: 50.0,
                ),
        ),
      ),
    );
  }
}
