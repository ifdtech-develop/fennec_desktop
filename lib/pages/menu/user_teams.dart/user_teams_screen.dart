import 'package:fennec_desktop/components/appbar.dart';
import 'package:fennec_desktop/components/bottom_navigation_bar.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/models/squad_list.dart';
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
  String teamName = "";
  String teamDescription = "";
  List<ListOfUsers> teamUsersList = [];
  List<SquadList> teamSquadsList = [];
  TextStyle listTileStyle = const TextStyle(
    fontSize: 15.0,
    color: Color(0xFF4D4D4D),
    fontWeight: FontWeight.w600,
  );

  TextEditingController searchTeamsController = TextEditingController();
  TextEditingController searchTeamUsersController = TextEditingController();
  TextEditingController searchSquadsController = TextEditingController();

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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFE4E4E4),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seus Times',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        searchInput(searchTeamsController),
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

                                  if (searchTeamsController.text.isEmpty) {
                                    return teamsListTile(item);
                                  } else if (item.description!
                                      .toLowerCase()
                                      .contains(searchTeamsController.text
                                          .toLowerCase())) {
                                    return teamsListTile(item);
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teamName,
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF4D4D4D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          teamDescription,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF4D4D4D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text(
                            'Pessoas no Time',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                        ),
                        searchInput(searchTeamUsersController),
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
                                  'Adicionar usuário',
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 8.0),
                          itemCount: teamUsersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var user = teamUsersList[index];

                            if (searchTeamUsersController.text.isEmpty) {
                              return teamUserListTile(user);
                            } else if (user.name!.toLowerCase().contains(
                                searchTeamUsersController.text.toLowerCase())) {
                              return teamUserListTile(user);
                            }

                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFD8A),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Squads',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        searchInput(searchSquadsController),
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
                                  'Adicionar Squad',
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 8.0),
                          itemCount: teamSquadsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var squad = teamSquadsList[index];

                            if (searchSquadsController.text.isEmpty) {
                              return squadListTile(squad);
                            } else if (squad.name!.toLowerCase().contains(
                                searchSquadsController.text.toLowerCase())) {
                              return squadListTile(squad);
                            }

                            return Container();
                          },
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
    );
  }

  Column teamsListTile(TeamList item) {
    return Column(
      children: [
        ListTile(
          title: Text(
            item.description!,
            style: listTileStyle,
          ),
          onTap: () {
            teamUsersList.clear();
            teamSquadsList.clear();

            _daoTeamList.usersOnTeamList(item.id!).then((users) {
              for (var user in users) {
                teamUsersList.add(user);
              }
              setState(() {
                teamName = item.description!;
                teamDescription = item.name!;
              });
            });

            _daoTeamList.teamSquads(item.id!).then((squads) {
              for (var squad in squads) {
                teamSquadsList.add(squad);
              }
            });
          },
        ),
        const Divider(),
      ],
    );
  }

  Column teamUserListTile(ListOfUsers user) {
    return Column(
      children: [
        ListTile(
          title: Text(
            user.name!,
            style: listTileStyle,
          ),
        ),
        const Divider(),
      ],
    );
  }

  Column squadListTile(SquadList squad) {
    return Column(
      children: [
        ListTile(
          title: Text(
            squad.name!,
            style: listTileStyle,
          ),
        ),
        const Divider(),
      ],
    );
  }

  SizedBox searchInput(TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 10.0),
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {});
          },
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),

            filled: true,
            fillColor: Colors.white,
            labelText: "Pesquisa",
            // hintText: "Filtrar por nome, função ou setor",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: InkWell(
              onTap: () {
                controller.text = '';
                setState(() {});
              },
              child: const Icon(Icons.close_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
