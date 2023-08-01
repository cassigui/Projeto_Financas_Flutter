// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import "adaptative_button.dart";
import "adaptative_date_picker.dart";
import "adaptative_text_field.dart";

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime, String?) onSubmit;
  final String? textEdit;
  final String? valueEdit;
  final String? idEdit;

  const TransactionForm(
      this.onSubmit, this.textEdit, this.valueEdit, this.idEdit,
      {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  var _selectedDate = DateTime.now();

  late final _titleController;
  late final _valueController;
  late final id;

  _submitForm() {
    final title = _titleController.text;
    final value = _valueController.text ?? "";

    if (title.isEmpty || double.parse(value) <= 0) {
      return;
    }

    widget.onSubmit(title, double.parse(value), _selectedDate, widget.idEdit);
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.textEdit ?? "");
    _valueController = TextEditingController(
      text: widget.valueEdit.toString(),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: <Widget>[
            AdaptativeTextField(
              label: "Título",
              controller: _titleController,
              submitForm: (_) => _submitForm(),
              placeholder: "Insira um texto."
            ),
            AdaptativeTextField(
              label: "Valor",
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              placeholder: "Insira um valor numérico.",
              submitForm: (_) => _submitForm(),
            ),
            AdaptatitveDatePicker(
              selectedDate: _selectedDate,
              onDateChange: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                10,
                0,
                10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AdaptativeButton(
                    label: "Nova transação",
                    onPressed: _submitForm,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
