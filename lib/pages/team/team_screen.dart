import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  final String backgroundColor;
  const TeamScreen({Key? key, required this.backgroundColor}) : super(key: key);

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
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
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100.0),
              bottomRight: Radius.circular(100.0),
            ),
            color: Color(0xFFCCCCCC),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Time'),
              Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: PostInput(),
              )
            ],
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
    return Column(
      children: [
        Row(
          children: const [
            Text('Tem algo a dizer?'),
          ],
        ),
        Container(
          width: 500.0,
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
            ElevatedButton(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 30.0,
                ),
                shadowColor: Colors.grey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
