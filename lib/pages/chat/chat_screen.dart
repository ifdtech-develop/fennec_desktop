import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final bool isChatOpened;

  const ChatScreen({Key? key, required this.isChatOpened}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
            child: Row(
              children: [
                // container lista de amigos
                Container(
                  color: const Color(0xFF5CE1E6),
                  width: 300.0,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            'https://picsum.photos/id/1012/80/80',
                          ),
                        ),
                        title: const Text('Alexander Albuquerque'),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
                // container chat
                Visibility(
                  visible: widget.isChatOpened,
                  child: Expanded(
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
                        children: [
                          SizedBox(
                            height: 70.0,
                            child: Card(
                              margin: const EdgeInsets.all(0.0),
                              color: const Color(0xFFE4E4E4),
                              elevation: 5,
                              child: Center(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.network(
                                      'https://picsum.photos/id/1012/80/80',
                                    ),
                                  ),
                                  title: const Text('Alexander Albuquerque'),
                                ),
                              ),
                            ),
                          ),
                          Container(),
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
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 15.0),
                                      child:
                                          Icon(Icons.emoji_emotions_outlined),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 50.0,
                                        ),
                                        child: TextField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(10.0),
                                            // cor da borda
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF707070),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            // Border quando usuario clica no input
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          ),
                                          keyboardType: TextInputType.multiline,
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
