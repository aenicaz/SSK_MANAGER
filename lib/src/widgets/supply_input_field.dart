import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupplyInputField extends StatelessWidget {
  const SupplyInputField(
      {Key? key,
      required this.controller,
      required this.textHint,
      required this.isNumeric})
      : super(key: key);
  final TextEditingController controller;
  final String textHint;
  final isNumeric;

  @override
  Widget build(BuildContext context) {
    if (!isNumeric) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextFormField(
            decoration: InputDecoration(hintText: textHint),
            controller: controller,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(hintText: textHint),
            controller: controller,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
