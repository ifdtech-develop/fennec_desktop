import 'package:fennec_desktop/components/appbar.dart';
import 'package:fennec_desktop/components/bottom_navigation_bar.dart';
import 'package:fennec_desktop/models/team_list.dart';
import 'package:fennec_desktop/services/team_list_dao.dart';
import 'package:flutter/material.dart';

class UserTeamsScreen extends StatefulWidget {
  const UserTeamsScreen({Key? key}) : super(key: key);

  @override
  _UserTeamsScreenState createState() => _UserTeamsScreenState();
}

class _UserTeamsScreenState extends State<UserTeamsScreen> {
  final TeamListDao _daoTeamList = TeamListDao();
  late Future<List<TeamList>> _getTeamList;

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getTeamList = _daoTeamList.listaTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarComponent(),
      bottomNavigationBar: const BottomNavigationBarComponent(),
      body: ClipRRect(
        //borda do container cortada e o texto some ao passar por ela
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100.0),
          bottomRight: Radius.circular(100.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFE4E4E4),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Seus Times',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, top: 10.0),
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: editingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Pesquisa",
                                // hintText: "Filtrar por nome, função ou setor",
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    editingController.text = '';
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.close_outlined),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: InkWell(
                            onTap: () {
                              print('asdasdsadasdas');
                            },
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                                Text(
                                  'Adicionar Time',
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FutureBuilder<List<TeamList>>(
                          future: _getTeamList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 8.0, 20.0, 8.0),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = snapshot.data![index];

                                  if (editingController.text.isEmpty) {
                                    return listTile(item);
                                  } else if (item.description!
                                      .toLowerCase()
                                      .contains(editingController.text
                                          .toLowerCase())) {
                                    return listTile(item);
                                  }

                                  return Container();
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF3F2F3),
                  child: Column(
                    children: const [
                      Text('dadasd'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFD8A),
                  child: Column(
                    children: const [
                      Text('dadasd'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column listTile(TeamList item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.description!),
          onTap: () {
            _daoTeamList.usersOnTeamList(item.id!).then((value) {
              print(value[0].name);
            });
          },
        ),
        const Divider(),
      ],
    );
  }
}
