import 'package:flutter/material.dart';

class TooltipSample extends StatelessWidget {
  final String description;

  const TooltipSample({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 6),
      child: Tooltip(
        message: description,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        triggerMode: TooltipTriggerMode.tap,
        showDuration: const Duration(seconds: 5),
        child: const Icon(
          Icons.info,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
