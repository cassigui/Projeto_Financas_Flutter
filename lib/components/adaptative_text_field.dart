// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:io";

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String placeholder;
  final Function(String) submitForm;

  AdaptativeTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.submitForm,
      required this.placeholder,
      this.keyboardType = TextInputType.text
      });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(
            bottom: 10
          ),
          child: CupertinoTextField(
            placeholder: label,
            keyboardType: keyboardType,
            onSubmitted: submitForm,
            controller: controller,
            padding: EdgeInsets.symmetric(
              horizontal : 6,
              vertical : 12,
            ),
          ),
        )
        : TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            onFieldSubmitted: submitForm,
            decoration: InputDecoration(
                labelText: label,
                hintText: placeholder,
                labelStyle: TextStyle(color: Colors.black)));
  }
}
