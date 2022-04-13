// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:math' as math;

import 'package:fennec_desktop/components/alert_dialog.dart';
import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/models/main_feed_content.dart';
import 'package:fennec_desktop/services/main_feed_dao.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:url_launcher/url_launcher.dart';

const socketUrl = '$serverURL/wss';

class MainFeedScreen extends StatefulWidget {
  final String? backgroundColor;
  const MainFeedScreen({Key? key, this.backgroundColor}) : super(key: key);

  @override
  _MainFeedScreenState createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  StompClient? stompClient;
  String texto = '';
  int index = 0;
  final MainFeedDao _daoMainFeed = MainFeedDao();
  // late Future<MainFeed> _getDados;
  final List<PostContent> _postagens = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/message',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          // Map<String, dynamic> result = json.decode(frame.body!);
          var result = PostContent.fromJson(jsonDecode(frame.body!));
          print('result');
          print(result);
          setState(
            () => {
              // _getDados = _daoMainFeed.getFeedContent(),
              // print(globalValue!.texto),
              _postagens.insert(0, result)
            },
          );
        }
      },
    );
  }

  void populateArray(int index) async {
    await _daoMainFeed.getFeedContent(index).then((value) {
      print(value.content.length);
      setState(() {
        _postagens.addAll(value.content);
      });
    }).catchError((onError) {
      // se o erro for um tipo de erro da chamada
      if (onError.runtimeType == ErrorMessage) {
        if (onError.status == 403) {
          // status for acesso negado
          // !  caso o token tenha expirado, retorna para a tela de login
          Navigator.of(context).pushNamed('/loginPage');
        } else {
          Future.delayed(
            const Duration(seconds: 0),
            () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => CustomAlertDialog(
                description:
                    "${onError.message}.\n\nEntre em contato com o suporte.",
              ),
            ),
          );
        }

        // se caso for outro tipo de erro, exemplo: SocketException, servidor fora do ar
      } else {
        Navigator.of(context).pushNamed('/loginPage');

        Future.delayed(
          const Duration(seconds: 0),
          () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => CustomAlertDialog(
              description:
                  "${onError.toString()}.\n\nEntre em contato com o suporte.",
            ),
          ),
        );
      }
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
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //borda do container cortada e o texto some ao passar por ela
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(100.0),
        bottomRight: Radius.circular(100.0),
      ),
      child: Container(
        color: const Color(0xFFFDF5E6),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Feed',
              style: TextStyle(
                color: Color(0xFF4D4D4D),
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
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
                onNotification: (ScrollNotification notification) {
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
                    String date1 = DateFormat("HH:mm:ss")
                        .format(DateFormat('HH:mm:ss').parse(post.hora));
                    final convert1 = DateFormat("HH:mm:ss").parse(date1);

                    final date = DateFormat('dd/MM/yyyy')
                        .format(DateFormat('yyyy-MM-dd').parse(post.data));
                    DateTime formatISOTime(DateTime date) {
                      var duration = date.timeZoneOffset;
                      int h = int.parse(
                          duration.inHours.toString().padLeft(2, '0'));
                      int m = int.parse(
                          (duration.inMinutes - (duration.inHours * 60))
                              .toString()
                              .padLeft(2, '0'));
                      if (duration.isNegative) {
                        return date.add(Duration(hours: h, minutes: m));
                        // "-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
                      } else {
                        return date.subtract(Duration(hours: h, minutes: m));
                      }
                    }

                    String local = (DateFormat('HH:mm:ss')
                        .format(formatISOTime(convert1)));
                    // fim data e hora

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Container(
                                  color: Color((math.Random().nextDouble() *
                                              0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0),
                                  height: 55.0,
                                  child: Center(
                                    child: Text(
                                      post.usuarioId.name.substring(0, 1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.usuarioId.name,
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
                          padding: const EdgeInsets.only(left: 63.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableLinkify(
                                onOpen: _onOpen,
                                text: post.texto,
                                style: const TextStyle(
                                  color: Color(0xFF4D4D4D),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: 100.0,
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(Icons.thumb_up_alt_outlined),
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
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Color(0xFFCCCCCC),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) {
                  // função para postar com a tecla enter
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft)) {
                      print('break line');
                    } else {
                      print('Enter Pressed');
                      String _texto = _postController.text;
                      _texto = _texto.replaceAll('\r', '');
                      _texto = _texto.replaceAll('\n', '');
                      _texto = _texto.replaceAll('\r\n', '');
                      _texto = _texto.replaceAll('\n\r', '');
                      _postController.text =
                          _postController.text.replaceAll('\r\n', '');
                      _postController.text =
                          _postController.text.replaceAll('\n', '');

                      _daoMainFeed.postContent(_texto).then((value) {
                        setState(() {
                          // _getDados = _daoMainFeed.getFeedContent();
                          _postController.text = '';
                        });
                      }).catchError((onError) {
                        print(onError);
                      });
                    }
                  }
                },
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
                    hintText: 'Compartilhe o que está pensando...',
                    // hintStyle: TextStyle(color: tcolor),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // textInputAction: TextInputAction.go,
                ),
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
                    _daoMainFeed
                        .postContent(_postController.text)
                        .then((value) {
                      setState(() {
                        // _getDados = _daoMainFeed.getFeedContent();
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

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
