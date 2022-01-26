import 'package:flutter/material.dart';

class SquadScreen extends StatefulWidget {
  final String backgroundColor;

  const SquadScreen({Key? key, required this.backgroundColor})
      : super(key: key);

  @override
  _SquadScreenState createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Squad',
                  style: TextStyle(
                    color: Color(0xFF4D4D4D),
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Center(
                  child: PostInput(),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    color: Color(0xFFCCCCCC),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15.0),
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 55.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(posts[index]['photo']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      posts[index]['name'],
                                      style: const TextStyle(
                                        color: Color(0xFF4D4D4D),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      posts[index]['createdAt'],
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
                                  posts[index]['comment'],
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
              ],
            ),
          ),
        ),
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
