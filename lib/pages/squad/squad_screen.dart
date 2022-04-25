import 'dart:convert';
import 'dart:math' as math;

import 'package:fennec_desktop/models/squad_feed.dart';
import 'package:fennec_desktop/models/squad_notifier.dart';
import 'package:fennec_desktop/services/squad_feed_dao.dart';
import 'package:fennec_desktop/services/squad_list_dao.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SquadScreen extends StatefulWidget {
  final String backgroundColor;

  const SquadScreen({Key? key, required this.backgroundColor})
      : super(key: key);

  @override
  _SquadScreenState createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  final SquadFeedDao _daoSquadFeed = SquadFeedDao();
  final SquadListDao _daoSquadList = SquadListDao();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();
  final List<PopupMenuItem> popupMenuItem = [];
  String squadName = "";
  int squadId = 1;
  bool noSquad = true;

  StompClient? stompClient;
  int index = 0;
  final List<PostContent> _postagens = [];

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/message/2',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          var result = PostContent.fromJson(jsonDecode(frame.body!));
          print('result squad');
          print(result.squad!.id);

          // se a squad da postagem for igual ao selecionado, a postagem só aparecerá nele
          if (result.squad!.id == squadId) {
            setState(
              () => {_postagens.insert(0, result)},
            );
          }
        }
      },
    );
  }

  void populateArray(int index) async {
    await _daoSquadFeed.getFeedContent(index, squadId).then((value) {
      setState(() {
        _postagens.addAll(value.content);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    populateArray(0);

    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
        url: socketUrl,
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ));

      stompClient!.activate();
    }

    _daoSquadList.listaSquad().then((squads) {
      if (squads.isEmpty) {
        if (mounted) {
          setState(() {
            noSquad = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            noSquad = false;
          });
        }

        for (var squad in squads) {
          squadId = squads[0].id!;
          squadName = squads[0].name!;

          popupMenuItem.add(
            PopupMenuItem(
              child: Text(squad.name!),
              value: squad.id,
              onTap: () {
                setState(() {
                  squadId = squad.id!;
                  squadName = squad.name!;
                  _postagens.clear();
                  populateArray(0);
                });
              },
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SquadNotifier>(
      builder: (context, storedValue, child) {
        if (storedValue.reload) {
          // reseto os valores
          storedValue.reload = false;
          popupMenuItem.clear();
          _postagens.clear();

          _daoSquadList.listaSquad().then((squads) {
            if (squads.isEmpty) {
              setState(() {
                noSquad = true;
              });
            } else {
              setState(() {
                noSquad = false;
              });

              for (var squad in squads) {
                squadId = squads[0].id!;
                squadName = squads[0].name!;

                popupMenuItem.add(
                  PopupMenuItem(
                    child: Text(squad.name!),
                    value: squad.id,
                    onTap: () {
                      setState(() {
                        squadId = squad.id!;
                        squadName = squad.name!;
                        _postagens.clear();
                        populateArray(0);
                      });
                    },
                  ),
                );
              }
            }
            // populando array de posts da squad
            populateArray(0);
          });
        }

        return Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            //background do container teams que deve mudar de acordo com o widget selecionado
            // color: Color(int.parse(widget.backgroundColor)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: const [0.5, 0.5],
                colors: [
                  Color(int.parse(widget.backgroundColor)),
                  const Color(0xFFF3F2F3),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
              child: Container(
                //borda do container cortada e o texto some ao passar por ela
                color: const Color(0xFFF3F2F3),
                height: MediaQuery.of(context).size.height,
                child: noSquad
                    ? const Center(
                        child: Text(
                          'Nenhuma squad nesse time por agora. 🥺',
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        squadName,
                                        style: const TextStyle(
                                          color: Color(0xFF4D4D4D),
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton(
                                      // padding: const EdgeInsets.only(left: 20.0),
                                      icon: const Icon(Icons.menu,
                                          color: Colors.black87),
                                      itemBuilder: (context) => popupMenuItem,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: postInput(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Divider(
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                          Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification:
                                  (ScrollNotification notification) {
                                if (notification.metrics.atEdge) {
                                  if (notification.metrics.pixels == 0) {
                                    print('At top');
                                  } else {
                                    print('At bottom');
                                    setState(() {
                                      index++;
                                      populateArray(index);
                                    });
                                  }
                                }
                                return true;
                              },
                              child: ListView.separated(
                                primary: false,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(15.0),
                                itemCount: _postagens.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final PostContent post = _postagens[index];

                                  // data e hora
                                  String date1 = DateFormat("HH:mm:ss").format(
                                      DateFormat('HH:mm:ss').parse(post.hora!));
                                  final convert1 =
                                      DateFormat("HH:mm:ss").parse(date1);

                                  final date = DateFormat('dd/MM/yyyy').format(
                                      DateFormat('yyyy-MM-dd')
                                          .parse(post.data!));
                                  DateTime formatISOTime(DateTime date) {
                                    var duration = date.timeZoneOffset;
                                    int h = int.parse(duration.inHours
                                        .toString()
                                        .padLeft(2, '0'));
                                    int m = int.parse((duration.inMinutes -
                                            (duration.inHours * 60))
                                        .toString()
                                        .padLeft(2, '0'));
                                    if (duration.isNegative) {
                                      return date
                                          .add(Duration(hours: h, minutes: m));
                                      // "-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
                                    } else {
                                      return date.subtract(
                                          Duration(hours: h, minutes: m));
                                    }
                                  }

                                  String local = (DateFormat('HH:mm:ss')
                                      .format(formatISOTime(convert1)));
                                  // fim data e hora

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 55.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Container(
                                                color: Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(1.0),
                                                height: 55.0,
                                                child: Center(
                                                  child: Text(
                                                    post.usuarioId.name!
                                                        .substring(0, 1),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.usuarioId.name!,
                                                  style: const TextStyle(
                                                    color: Color(0xFF4D4D4D),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '$date - $local',
                                                  style: const TextStyle(
                                                    color: Color(0xFF4D4D4D),
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 63.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.texto!,
                                              style: const TextStyle(
                                                color: Color(0xFF4D4D4D),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              width: 100.0,
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Icon(Icons
                                                      .thumb_up_alt_outlined),
                                                  Icon(Icons.comment_outlined),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  color: Color(0xFFCCCCCC),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container postInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      width: MediaQuery.of(context).size.width * 0.82,
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Tem algo a dizer?',
                style: TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _postController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25.0),
                  // cor da borda
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF707070),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  // Border quando usuario clica no input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText:
                      'Compartilhe o que está pensando...', // pass the hint text parameter here
                  // hintStyle: TextStyle(color: tcolor),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                child: ElevatedButton(
                  onPressed: () {
                    _daoSquadFeed
                        .postContent(_postController.text, squadId)
                        .then((value) {
                      setState(() {
                        _postController.text = '';
                      });
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: const Text(
                    'Postar',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18.0,
                      horizontal: 30.0,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
