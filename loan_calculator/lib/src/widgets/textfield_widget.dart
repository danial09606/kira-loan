import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String title;
  final TextInputType type;
  final TextEditingController controller;

  const FormTextField({
    super.key,
    required this.title,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 93, 11),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 7, 93, 11), width: 2.0),
          ),
          labelText: title,
        ),
        keyboardType: type,
        controller: controller,
      ),
    );
  }
}
