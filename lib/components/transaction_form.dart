// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import "adaptative_button.dart";
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

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _selectedDate = pickedDate;
    });
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
              label: "Titulo",
              controller: _titleController,
              submitForm: (_) => _submitForm(),
            ),
            AdaptativeTextField(
                label: "Valor (R\$)",
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                submitForm: (_) => _submitForm(),
               ),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _showDatePicker,
                    child: Icon(Icons.date_range),
                  ),
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                              "Data: ${DateFormat("d/M/y").format(_selectedDate)}"),
                        ],
                      ))
                ],
              ),
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
