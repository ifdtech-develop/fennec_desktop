import 'package:fennec_desktop/utils/colors.dart';
import 'package:flutter/material.dart';

import 'data_mock.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({Key? key}) : super(key: key);

  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
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
                          child: SingleChildScrollView(
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
                                                    text: element["clientName"],
                                                  ),
                                                ),
                                                DataCell(
                                                  TextWidget(
                                                    text: element["barCode"],
                                                  ),
                                                ),
                                                DataCell(
                                                  TextWidget(
                                                    text: element["cardNumber"],
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
