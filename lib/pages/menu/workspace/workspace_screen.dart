import 'package:fennec_desktop/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'data_mock.dart';

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
                                child: DataTable(
                                  dividerThickness: 0.05,
                                  columns: const [
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Transação',
                                        size: 16.0,
                                      ),
                                    ),
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
                                        text: 'Número do Cartão',
                                        size: 16.0,
                                      ),
                                    ),
                                    DataColumn(
                                      label: TextWidget(
                                        text: 'Valor da Operação',
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
                                                            "typeTransaction"],
                                                      ),
                                                    ), //Extracting from Map element the value
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "clientName"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text:
                                                            element["barCode"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "cardNumber"],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      TextWidget(
                                                        text: element[
                                                            "valueTransaction"],
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
                                ),
                              ),
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
            width: MediaQuery.of(context).size.width * 0.5,
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
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'PG Cartão R\$9,90',
                style: TextStyle(
                  color: ColorsProject.strongOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'Saldo Boleto R\$9,90',
                style: TextStyle(
                  color: ColorsProject.strongOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
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
