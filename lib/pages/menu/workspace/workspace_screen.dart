import 'package:fennec_desktop/components/appbar.dart';
import 'package:fennec_desktop/components/bottom_navigation_bar.dart';
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
                                DataColumn(label: Text('Transação')),
                                DataColumn(label: Text('Nome do Cliente')),
                                DataColumn(label: Text('Código de Barras')),
                                DataColumn(label: Text('Número do Cartão')),
                                DataColumn(label: Text('Valor da Operação')),
                                DataColumn(label: Text('Status')),
                              ],
                              rows:
                                  listOfRows // Loops through dataColumnText, each iteration assigning the value to element
                                      .map(
                                        ((element) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(element[
                                                    "typeTransaction"])), //Extracting from Map element the value
                                                DataCell(Text(
                                                    element["clientName"])),
                                                DataCell(
                                                    Text(element["barCode"])),
                                                DataCell(Text(
                                                    element["cardNumber"])),
                                                DataCell(Text(element[
                                                    "valueTransaction"])),
                                                DataCell(
                                                    Text(element["status"])),
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
