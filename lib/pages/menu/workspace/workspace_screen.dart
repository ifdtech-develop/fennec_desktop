import 'package:fennec_desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

Future<List> getAllTransactions() async {
  final dao = WorkspaceDAO();
  var transactions = await dao.getAllTransactions();
  return transactions;
}

Future<Map<String, dynamic>> getTotal() async {
  final dao = WorkspaceTotalDAO();
  var transactions = await dao.TotalTransactions();
  return transactions;
}

late String value1 = 'RS 90,00';
late String value2 = 'RS 90,00';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({Key? key}) : super(key: key);

  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  late String userFirstLetter = '';
  late String userName = '';
  late String userPhone = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name')!;
      userPhone = prefs.getString('phone')!;
      userFirstLetter = prefs.getString('name')!.substring(0, 1);
    });
  }

<<<<<<< HEAD
=======
  // var transactions;

// get a List from a Future<list>getAllTransactions()

// late var listDash = WorkspaceDAO().getAllTransactions().then((value) => value.forEach((element) => print(element))) as List;

  late var transaction = getAllTransactions();

>>>>>>> 7c78a0c (Backoffice getting data from backend)
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ClipRRect(
          //borda do container cortada e o texto some ao passar por ela
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      color: const Color(0xFFE4E4E4),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              UserInfoHeader(
                                userFirstLetter: userFirstLetter,
                                userName: userName,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
<<<<<<< HEAD
                                child: DataTable(
                                  dividerThickness: 0.05,
                                  columns: const [
                                  
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Nome do Cliente',
                                        size: 16.0,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Código de Barras',
                                        size: 16.0,
                                      ),
                                    ),
                               
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Valor do Boleto',
                                        size: 16.0,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Valor do Cartão',
                                        size: 16.0,
                                      ),
                                    ),
                                      DataColumn(
                                      label: TextWidget(
                                        text: 'Valor da Taxa',
                                        size: 16.0,
                                      ),
                                    ),
                
                                      DataColumn(
                                      label: TextWidget(
                                        text: 'Tipo',
                                        size: 16.0,
                                      ),
                                    ),
                                      DataColumn(
                                      label: TextWidget(
                                        text: 'Autenticação',
                                        size: 16.0,
                                      ),
                                    ),
                                       DataColumn(
                                      label: TextWidget(
                                        text: 'Status',
                                        size: 16.0,
                                      ),
                                    ),
                                  ],
                                  rows:
                                      listOfRows // Loops through dataColumnText, each iteration assigning the value to element
                                          .map(
                                            ((element) => DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "nome"],
                                                      ),
                                                    ), //Extracting from Map element the value
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "barCode"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text:
                                                            element["valorBoleto"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "valorCartao"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "valorTaxa"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text: element["tipo"],
                                                      ),
                                                    ),
                                                       DataCell(
                                                      TextWidget(
                                                        text: element["autenticacao"],
                                                      ),
                                                    ),
                                                       DataCell(
                                                      TextWidget(
                                                        text: element["status"],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )
                                          .toList(),
=======
                                child: FutureBuilder(
                                  future: getAllTransactions(),
                                  builder:
                                      (context, AsyncSnapshot<List> snapshot) {
                                    if (snapshot.hasData) {
                                      List listDash = snapshot.data as List;
                                      return DataTable(
                                        dividerThickness: 0.05,
                                        columns: const [
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Nome do Cliente',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Data do Pagamento',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Valor do Cartão',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Valor do Boleto',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Valor da Taxa',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Parcelas',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Tipo',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Autenticação',
                                              size: 16.0,
                                            ),
                                          ),
                                          DataColumn(
                                            label: TextWidget(
                                              text: 'Status',
                                              size: 16.0,
                                            ),
                                          ),
                                        ],
                                        rows:
                                            // put data from future
                                            // transaction

                                            listDash
                                                .map(
                                                  ((element) => DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                          "nome"]
                                                                      .split(
                                                                          " ")
                                                                      .first +
                                                                  " " +
                                                                  (element["nome"]
                                                                              .split(
                                                                                  " ")
                                                                              .length >=
                                                                          2
                                                                      ? element[
                                                                              "nome"]
                                                                          .split(
                                                                              " ")
                                                                          .elementAt(
                                                                              1)
                                                                      : ""),
                                                            ),
                                                          ), //Extracting from Map element the value
                                                          DataCell(
                                                            TextWidget(
                                                              text: DateFormat(
                                                                      'dd/MM/yyyy HH:mm')
                                                                  .format(DateFormat(
                                                                          "yyyy-MM-dd'T'hh:mm:ss'Z'")
                                                                      .parse(element[
                                                                          "create_date"])),
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "valorCartao"],
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "valorBoleto"],
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "valorTaxa"],
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "installments"],
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "tipo"],
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                      "paynetauthorizationCode"]
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          DataCell(
                                                            TextWidget(
                                                              text: element[
                                                                  "status"],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                                .toList(),
                                      );
                                    } else {
                                      // make a loading screen with a full height container
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.values[2],
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.blue),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
>>>>>>> 7c78a0c (Backoffice getting data from backend)
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  final String userFirstLetter;
  final String userName;

  const UserInfoHeader({
    Key? key,
    required this.userFirstLetter,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.450,
            child: Row(
              children: [
                SizedBox(
                  width: 55.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                      height: 55.0,
                      child: Center(
                        child: Text(
                          userFirstLetter,
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
                  child: Text(
                    userName,
                    style: const TextStyle(
                      color: ColorsProject.greyColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                  future: getTotal(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic>? data = snapshot.data;
                      // get totalBoleto from data
                      String totalBoleto = data!["totalBoleto"];
                      String totalCartao = data["totalCartao"];
                      value1 = totalCartao;
                      value2 = totalBoleto;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PG Cartão $value1',
                              style: const TextStyle(
                                color: ColorsProject.strongOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'PG Boleto $value2',
                              style: const TextStyle(
                                color: ColorsProject.strongOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'PG Cartão R\$ 0',
                              style: TextStyle(
                                color: ColorsProject.strongOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Saldo Boleto R\$ 0',
                              style: TextStyle(
                                color: ColorsProject.strongOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;

  const TextWidget({
    Key? key,
    required this.text,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: ColorsProject.greyColor,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
