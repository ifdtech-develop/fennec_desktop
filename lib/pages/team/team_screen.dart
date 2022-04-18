import 'package:fennec_desktop/models/team_feed.dart';
import 'package:fennec_desktop/services/team_feed_dao.dart';
import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  final String backgroundColor;
  const TeamScreen({Key? key, required this.backgroundColor}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final TeamFeedDao _daoTeamFeed = TeamFeedDao();
  late Future<TeamFeed> _getDados;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDados = _daoTeamFeed.getFeedContent();
  }

  final List posts = [
    {
      'photo': 'https://picsum.photos/id/1012/80/80',
      'name': 'Matheus Motta',
      'createdAt': 'há 36 minutos',
      'comment': 'Bom dia, tudo bem?',
    },
    {
      'photo': 'https://picsum.photos/id/1027/80/80',
      'name': 'Letícia Almeida',
      'createdAt': 'há 1 hora',
      'comment': 'Boa semana!',
    },
    {
      'photo': 'https://picsum.photos/id/1027/80/80',
      'name': 'Letícia Almeida',
      'createdAt': 'há 1 hora',
      'comment': 'Boa semana!',
    },
    {
      'photo': 'https://picsum.photos/id/1005/80/80',
      'name': 'David Silvas',
      'createdAt': 'há 15 minutos',
      'comment':
          'Lorem ipsum dolor sit amet. Sed saepe vitae sit perferendis corrupti et quis quia ut consequatur cumque ut libero internos in laborum dignissimos eos earum necessitatibus.',
    },
    {
      'photo': 'https://picsum.photos/id/1005/80/80',
      'name': 'David Silvas',
      'createdAt': 'há 15 minutos',
      'comment':
          'Lorem ipsum dolor sit amet. Sed saepe vitae sit perferendis corrupti et quis quia ut consequatur cumque ut libero internos in laborum dignissimos eos earum necessitatibus.',
    },
    {
      'photo': 'https://picsum.photos/id/1005/80/80',
      'name': 'David Silvas',
      'createdAt': 'há 15 minutos',
      'comment':
          'Lorem ipsum dolor sit amet. Sed saepe vitae sit perferendis corrupti et quis quia ut consequatur cumque ut libero internos in laborum dignissimos eos earum necessitatibus.',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              const Color(0xFFCCCCCC),
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
            color: const Color(0xFFCCCCCC),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time',
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
                    color: Color(0xFFF3F2F3),
                  ),
                ),
                FutureBuilder<TeamFeed>(
                  future: _getDados,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        // Future ainda não foi executado
                        // Normal colocar um widget que permite um clique ou outro tipo de
                        // ação, e que dê início ao Future
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Text('Loading'),
                            ],
                          ),
                        );
                      // break;
                      case ConnectionState.active:
                        // possui um dado disponível, mas o Future ainda não foi finalizado
                        // Isso acontece quando utilizamos outra referência, conhecida
                        // como stream, que trabalha trazendo pedaços de um carregamento
                        // assíncrono, por exemplo no caso do progresso de um download.
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          final TeamFeed? teamPosts = snapshot.data;

                          return Expanded(
                            child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(15.0),
                              itemCount: teamPosts!.content.length,
                              itemBuilder: (BuildContext context, int index) {
                                final PostContent post =
                                    teamPosts.content[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 55.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: Image.network(
                                              'https://picsum.photos/id/1027/80/80',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
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
                                color: Color(0xFFF3F2F3),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        break;
                    }

                    return const Text('Unkown error');
                  },
                ),
              ],
            ),
          ),
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
                    _daoTeamFeed
                        .postContent(_postController.text)
                        .then((value) {
                      setState(() {
                        _getDados = _daoTeamFeed.getFeedContent();
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

class PostInput extends StatelessWidget {
  const PostInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: TextField(
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
                  onPressed: () {},
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
