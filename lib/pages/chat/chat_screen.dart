import 'dart:convert';
import 'dart:math' as math;

import 'package:fennec_desktop/main.dart';
import 'package:fennec_desktop/models/list_of_messages.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/services/get_users_dao.dart';
import 'package:fennec_desktop/services/list_of_messages_dao.dart';
import 'package:fennec_desktop/services/send_chat_message_dao.dart';
import 'package:fennec_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatScreen extends StatefulWidget {
  final bool isChatOpened;

  const ChatScreen({Key? key, required this.isChatOpened}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetUsersDao _getUsersDao = GetUsersDao();
  late Future<List<ListOfUsers>> _getUsers;
  final ListOfMessagesDao _getListOfMessagesDao = ListOfMessagesDao();
  late String userId;
  TextEditingController chatMessageController = TextEditingController();
  final SendChatMessageDao _sendChatMessageDao = SendChatMessageDao();

  int friendIndex = 0;
  String friendId = "2";
  int index = 0;

  StompClient? stompClient;
  final List _messages = [];

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/messages/$userId/$friendId',
      callback: (StompFrame frame) {
        print('frame.body');
        print(frame.body);
        if (frame.body != null) {
          // adicionando a msg que o amigo com quem o usuario esta conversando a array _messages
          var result = ListOfMessages.fromJson(jsonDecode(frame.body!));

          if (mounted) {
            setState(
              () => {_messages.insert(0, result)},
            );
          }
        }
      },
    );
  }

  void stomClientFunction() {
    stompClient = StompClient(
        config: StompConfig.SockJS(
      url: socketUrl,
      onConnect: onConnect,
      onWebSocketError: (dynamic error) => print(error.toString()),
    ));

    stompClient!.activate();
  }

  void populateChatArray(int index) async {
    await _getListOfMessagesDao
        .getListOfMessages(userId, friendId, index)
        .then((value) {
      setState(() {
        _messages.addAll(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _messages.clear();

    _getUsers = _getUsersDao.getUsers();
    _getUsers.then(
      (value) {
        setState(() {
          friendId = value[friendIndex].id.toString();
        });

        populateChatArray(0);
      },
    );

    setState(() {
      userId = prefs.getString('id')!;
    });

    if (stompClient == null) {
      stomClientFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        //background do container teams que deve mudar de acordo com o widget selecionado
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0.5, 0.5],
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFF5CE1E6),
            ],
          ),
        ),
        child: ClipRRect(
          //borda do container cortada e o texto some ao passar por ela
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          child: Container(
            color: const Color(0xFF5CE1E6),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<ListOfUsers>>(
              future: _getUsers,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final List<ListOfUsers>? users = snapshot.data;

                      return Row(
                        children: [
                          // *container lista de amigos
                          Container(
                            color: const Color(0xFF5CE1E6),
                            width: 300.0,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(15.0),
                              itemCount: users!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final ListOfUsers user = users[index];

                                return Visibility(
                                  visible: user.id.toString() != userId,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        friendIndex = index;
                                        friendId = users[index].id.toString();
                                        _messages.clear();
                                        populateChatArray(0);
                                        stomClientFunction();
                                      });
                                    },
                                    leading: Stack(
                                      children: [
                                        SizedBox(
                                          width: 50.0,
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
                                                  user.name!.substring(0, 1),
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
                                        // Positioned(
                                        //   right: 0.0,
                                        //   top: 33.0,
                                        //   child: Container(
                                        //     width: 14.0,
                                        //     height: 14.0,
                                        //     decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //       color: friends[index]
                                        //           ['statusColor'],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                    title: Text(user.name!),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          ),
                          // container chat
                          Visibility(
                            visible: widget.isChatOpened,
                            child: chatContainer(users),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('${snapshot.error}');
                    }
                    break;
                }

                return const Text('Unkown error when getting users');
              },
            ),
          ),
        ),
      ),
    );
  }

  Expanded chatContainer(List<ListOfUsers> users) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          color: Color(0xFFF3F2F3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatHeader(friendIndex: friendIndex, users: users),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification.metrics.atEdge) {
                    // * aqui fica invertido pq a lista esta no modo reverso
                    if (notification.metrics.pixels == 0) {
                      print('At bottom');
                    } else {
                      print('At top');
                      setState(() {
                        index++;
                        print(index);
                        populateChatArray(index);
                      });
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final ListOfMessages message = _messages[index];

                    return Container(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 50.0,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Align(
                        alignment:
                            (message.senderId!.id == users[friendIndex].id
                                ? Alignment.topLeft
                                : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                (message.senderId!.id == users[friendIndex].id
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            message.content!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 70.0,
              child: Card(
                margin: const EdgeInsets.all(0.0),
                color: const Color(0xFFE4E4E4),
                child: Center(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.attach_file_outlined),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Icon(Icons.emoji_emotions_outlined),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: TextFormField(
                            controller: chatMessageController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
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
                            ),
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Escreva uma mensagem.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              _sendChatMessageDao
                                  .sendChatMessage(
                                users[friendIndex].id.toString(),
                                chatMessageController.text,
                              )
                                  .then((value) {
                                // adicionando a msg o que o usuario logado digitou na array de _messages
                                var jsonString = jsonEncode(value);
                                var result = ListOfMessages.fromJson(
                                    jsonDecode(jsonString));

                                setState(() {
                                  _messages.insert(0, result);
                                  chatMessageController.text = "";
                                });
                              }).catchError((onError) {
                                print('onError');
                                print(onError);
                              });
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    Key? key,
    required this.friendIndex,
    required this.users,
  }) : super(key: key);

  final int friendIndex;
  final List<ListOfUsers> users;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: Card(
        margin: const EdgeInsets.all(0.0),
        color: const Color(0xFFE4E4E4),
        elevation: 5,
        child: Center(
          child: ListTile(
            leading: Stack(
              children: [
                SizedBox(
                  width: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                      height: 55.0,
                      child: Center(
                        child: Text(
                          users[friendIndex].name!.substring(0, 1),
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
                // Positioned(
                //   right: 0.0,
                //   top: 33.0,
                //   child: Container(
                //     width: 14.0,
                //     height: 14.0,
                //     decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.circular(
                //               10),
                //       color:
                //           friends[friendIndex]
                //               ['statusColor'],
                //     ),
                //   ),
                // )
              ],
            ),
            title: Text(users[friendIndex].name!),
          ),
        ),
      ),
    );
  }
}
