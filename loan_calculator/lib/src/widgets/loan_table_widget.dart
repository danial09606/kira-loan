import 'package:flutter/material.dart';
import 'package:loan_calculator/src/extension/string_extension.dart';
import 'package:loan_calculator/src/model/model.dart';

class LoanTableWidget extends StatelessWidget {
  final List<LoanData> plots;

  const LoanTableWidget({
    super.key,
    required this.plots,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40, left: 10, right: 10),
      child: constructTable(),
    );
  }

  Widget constructTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.green[100]),
        columnSpacing: 40,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            left: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        columns: const [
          DataColumn(
            label: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'YEARS',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                'PRINCIPLE',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                'INTEREST',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'BALANCE',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        rows: [
          ...plots.map(
            (data) => DataRow(
              cells: [
                DataCell(
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.years,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      data.principal.getCurrencyFormat(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      data.interest.getCurrencyFormat(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                DataCell(
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data.balance.getCurrencyFormat(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
