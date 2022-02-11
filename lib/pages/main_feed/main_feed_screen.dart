// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:fennec_desktop/models/main_feed_content.dart';
import 'package:fennec_desktop/services/main_feed_dao.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

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
  late List<PostContent> _postagens = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/message',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          // Map<String, dynamic> result = json.decode(frame.body!);
          var result = json.decode(frame.body!);
          print('result');
          print(result);
          setState(
            () => {
              // // postagens.add(result['texto']),
              // _getDados = _daoMainFeed.getFeedContent()
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

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  'https://picsum.photos/id/1012/80/80',
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
                                    '${post.data} - ${post.hora}',
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
                              Text(
                                post.texto,
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
}
