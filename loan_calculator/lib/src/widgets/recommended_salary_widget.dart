import 'package:flutter/material.dart';
import 'package:loan_calculator/src/extension/string_extension.dart';
import 'package:loan_calculator/src/widgets/tooltip.dart';

class RecommendedSalaryWidget extends StatelessWidget {
  final String title;
  final String description;
  final String salary;

  const RecommendedSalaryWidget({
    super.key,
    required this.title,
    required this.description,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 25, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TooltipSample(description: description),
              Text(
                '$title: ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Text(
            'RM $salary'.getCurrencyFormat(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 7, 93, 11),
            ),
          ),
        ],
      ),
    );
  }
}
