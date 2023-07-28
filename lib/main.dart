// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, unused_element, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import "package:i18n_extension/i18n_widget.dart";
import "dart:math";
import "../components/transaction_form.dart";
import "../components/transaction_list.dart";
import "../models/transaction.dart";
import "components/chart.dart";

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Finanças",
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          secondaryHeaderColor: Colors.blueGrey[900],
          scaffoldBackgroundColor: Colors.blue[50],
          fontFamily: "QuickSand",
          appBarTheme: AppBarTheme(
            color: Colors.blueGrey[900],
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
      home: I18n(child: MyHome()),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date, String? id) {
    if (id != null) {
      _removeTransaction(id);
    }
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _alterate(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction, "", "", '');
      },
    );
  }

  _openTransactionFormModalModifier(
      BuildContext context, String title, double value, id) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          _addTransaction,
          title,
          value.toString(),
          id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finances"),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _removeTransaction,
                _openTransactionFormModalModifier),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
