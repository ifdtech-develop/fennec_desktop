import 'package:fennec_desktop/components/alert_dialog.dart';
import 'package:fennec_desktop/components/appbar.dart';
import 'package:fennec_desktop/components/bottom_navigation_bar.dart';
import 'package:fennec_desktop/models/list_of_users.dart';
import 'package:fennec_desktop/models/squad_list.dart';
import 'package:fennec_desktop/models/team_list.dart';
import 'package:fennec_desktop/services/get_users_dao.dart';
import 'package:fennec_desktop/services/squad_list_dao.dart';
import 'package:fennec_desktop/services/team_list_dao.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class UserTeamsScreen extends StatefulWidget {
  const UserTeamsScreen({Key? key}) : super(key: key);

  @override
  _UserTeamsScreenState createState() => _UserTeamsScreenState();
}

class _UserTeamsScreenState extends State<UserTeamsScreen> {
  final TeamListDao _daoTeamList = TeamListDao();
  final SquadListDao _daoSquadList = SquadListDao();
  final GetUsersDao _daoGetUsers = GetUsersDao();
  late Future<List<TeamList>> _getTeamList;
  late Future<List<ListOfUsers>> _getUsers;
  List selectedUsers = [];

  String teamName = "";
  String teamDescription = "";
  int _teamIdSelected = -1;
  int _squadIdSelected = -1;
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
  TextEditingController searchUsersController = TextEditingController();
  TextEditingController teamNameController = TextEditingController();
  TextEditingController teamDescriptionController = TextEditingController();
  TextEditingController squadNameController = TextEditingController();
  TextEditingController squadDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getTeamList = _daoTeamList.listaTime();
    _getUsers = _daoGetUsers.getUsers();
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
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
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
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          addTeamDialog(context),
                                    );
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
                            ],
                          ),
                        ),
                        FutureBuilder<List<TeamList>>(
                          future: _getTeamList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 10.0, 0.0, 10.0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                ),
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
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    addUserDialog(
                                  'Adicionar usuários ao Time',
                                  addUsersToTeamFunction,
                                ),
                              ).then((value) {
                                // atualizo a lista de usuários
                                _daoTeamList
                                    .usersOnTeamList(_teamIdSelected)
                                    .then((users) {
                                  teamUsersList.clear();
                                  for (var user in users) {
                                    setState(() {
                                      teamUsersList.add(user);
                                    });
                                  }
                                });
                              });
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
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 8.0),
                            itemCount: teamUsersList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var user = teamUsersList[index];

                              if (searchTeamUsersController.text.isEmpty) {
                                return teamUserListTile(user);
                              } else if (user.name!.toLowerCase().contains(
                                  searchTeamUsersController.text
                                      .toLowerCase())) {
                                return teamUserListTile(user);
                              }

                              return Container();
                            },
                          ),
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
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    addSquadToTeamDialog(context),
                              ).then((value) {
                                // atualizo a lista de squads
                                _daoTeamList
                                    .teamSquads(_teamIdSelected)
                                    .then((squads) {
                                  teamSquadsList.clear();
                                  for (var squad in squads) {
                                    setState(() {
                                      teamSquadsList.add(squad);
                                    });
                                  }
                                });
                              });
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
                        Expanded(
                          child: ListView.builder(
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

  StatefulBuilder addUserDialog(
    String title,
    Function onPressedFunction,
  ) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF4D4D4D),
          fontSize: 25.0,
        ),
        content: addUserContent(setState),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
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
                onPressedFunction();
              },
              child: const Text(
                'Adicionar',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 50.0,
                ),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  SizedBox addUserContent(setState) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchUsersController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Pesquisa",
                    // hintText: "Filtrar por nome, função ou setor",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: InkWell(
                      onTap: () {
                        searchUsersController.text = '';
                        setState(() {});
                      },
                      child: const Icon(Icons.close_outlined),
                    ),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<List<ListOfUsers>>(
            future: _getUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = snapshot.data![index];

                      if (searchUsersController.text.isEmpty) {
                        return addUserListTile(user, setState);
                      } else if (user.name!
                          .toLowerCase()
                          .contains(searchUsersController.text.toLowerCase())) {
                        return addUserListTile(user, setState);
                      }

                      return Container();
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Column addUserListTile(ListOfUsers user, setState) {
    return Column(
      children: [
        Card(
          color:
              selectedUsers.contains(user.id) ? const Color(0xFFAFEEEE) : null,
          shape: (selectedUsers.contains(user.id))
              ? RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(5),
                )
              : null,
          margin: EdgeInsets.zero,
          elevation: 0,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
              child: Text(
                user.name!,
                style: listTileStyle,
              ),
            ),
            leading: SizedBox(
              width: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  height: 50.0,
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
            onTap: () {
              setState(() {
                if (selectedUsers.contains(user.id)) {
                  selectedUsers.remove(user.id);
                } else {
                  selectedUsers.add(user.id);
                }
              });
            },
          ),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }

  AlertDialog addTeamDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Adicionar Time',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF4D4D4D),
        fontSize: 25.0,
      ),
      content: Form(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextFormField(
                autofocus: true,
                controller: teamNameController,
                labelText: 'Nome do Time',
              ),
              CustomTextFormField(
                autofocus: false,
                controller: teamDescriptionController,
                labelText: 'Descrição do Time',
                linhas: 2,
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
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
              _daoTeamList
                  .createTeam(
                      teamNameController.text, teamDescriptionController.text)
                  .then((value) {
                setState(() {
                  teamNameController.text = "";
                  teamDescriptionController.text = "";
                  Navigator.pop(context, 'Adicionar');

                  _getTeamList = _daoTeamList.listaTime();
                });
              }).catchError((onError) {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => CustomAlertDialog(
                      description:
                          "${onError.message.toString()}.\n\nEntre em contato com o suporte.",
                    ),
                  ),
                );
              });
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AlertDialog addSquadToTeamDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Adicionar Squad',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF4D4D4D),
        fontSize: 25.0,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.44,
        child: Column(
          children: [
            Text(
              'Time: $teamName',
              style: const TextStyle(
                color: Color(0xFF707070),
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextFormField(
                      autofocus: true,
                      controller: squadNameController,
                      labelText: 'Nome da Squad',
                    ),
                    CustomTextFormField(
                      autofocus: false,
                      controller: squadDescriptionController,
                      labelText: 'Descrição da Squad',
                      linhas: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
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
              _daoSquadList
                  .createSquad(squadDescriptionController.text,
                      squadNameController.text, _teamIdSelected)
                  .then((value) {
                setState(() {
                  squadNameController.text = "";
                  squadDescriptionController.text = "";
                  Navigator.pop(context, 'Adicionar');
                });
              }).catchError((onError) {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => CustomAlertDialog(
                      description:
                          "${onError.message.toString()}.\n\nEntre em contato com o suporte.",
                    ),
                  ),
                );
              });
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column teamsListTile(TeamList item) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
              child: Text(
                item.description!,
                style: listTileStyle,
              ),
            ),
            // selected: _tileSelected == item.id!,
            tileColor: _teamIdSelected == item.id!
                ? const Color(0xFFF3F3F3)
                : const Color(0xFFE4E4E4),
            // selectedTileColor: Colors.greenAccent,
            onTap: () {
              setState(() {
                _teamIdSelected = item.id!;
              });
              teamUsersList.clear();
              teamSquadsList.clear();
              // setState(() {;

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
        ),
        const Divider(
          height: 0,
        ),
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

  ExpansionTile squadListTile(SquadList squad) {
    return ExpansionTile(
      title: Text(squad.name!, style: listTileStyle),
      onExpansionChanged: (value) {
        if (value) {
          setState(() {
            _squadIdSelected = squad.id!;
            print(_squadIdSelected);
          });
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => addUserDialog(
                    'Adicionar usuários a Squad',
                    addUsersToSquadFunction,
                  ),
                ).then((value) {
                  // atualizo a lista de usuários
                  setState(() {});
                });
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
        ),
        FutureBuilder<List<ListOfUsers>>(
          future: _daoSquadList.usersOnSquadList(_squadIdSelected),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var user = snapshot.data![index];

                  return ListTile(
                    title: Text(
                      user.name!,
                      style: listTileStyle,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
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

  void addUsersToTeamFunction() {
    var json = [];
    for (var user in selectedUsers) {
      json.add({"id": user});
    }

    _daoTeamList.addUsersToTeam(_teamIdSelected, json).then((value) {
      setState(() {
        selectedUsers = [];
      });
      Navigator.pop(context, 'Adicionar');
    }).catchError((onError) {
      Future.delayed(
        const Duration(seconds: 0),
        () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => CustomAlertDialog(
            description:
                "${onError.message.toString()}.\n\nEntre em contato com o suporte.",
          ),
        ),
      );
    });
  }

  void addUsersToSquadFunction() {
    var json = [];
    for (var user in selectedUsers) {
      json.add({"id": user});
    }

    _daoSquadList.addUsersToSquad(_squadIdSelected, json).then((value) {
      setState(() {
        selectedUsers = [];
      });
      Navigator.pop(context, 'Adicionar');
    }).catchError((onError) {
      Future.delayed(
        const Duration(seconds: 0),
        () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => CustomAlertDialog(
            description:
                "${onError.message.toString()}.\n\nEntre em contato com o suporte.",
          ),
        ),
      );
    });
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;
  final String labelText;
  final IconData? icon;
  final int? linhas;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.autofocus,
    required this.labelText,
    this.icon,
    this.linhas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      maxLines: linhas,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório.';
        }
        return null;
      },
    );
  }
}
