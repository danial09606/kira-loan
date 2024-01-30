import 'package:flutter/material.dart';
import 'package:loan_calculator/src/extension/string_extension.dart';

class MonthlyRepaymentWidget extends StatelessWidget {
  final String title;
  final String totalPaymentMonthly;
  final GlobalKey dataKey;

  const MonthlyRepaymentWidget({
    super.key,
    required this.title,
    required this.totalPaymentMonthly,
    required this.dataKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: dataKey,
      padding: const EdgeInsets.only(top: 20, bottom: 25, left: 10, right: 10),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'RM $totalPaymentMonthly'.getCurrencyFormat(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 93, 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
