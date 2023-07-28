// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;
  final modal;

  const TransactionList(this.transactions, this.onRemove, this.modal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            height: 400,
            decoration: BoxDecoration(),
            child: transactions.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nenhuma Transação Cadastrada!",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 240,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx, index) {
                      final tr = transactions[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).secondaryHeaderColor,
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FittedBox(
                                child: Text(
                                  "R\$${tr.value}",
                                ),
                              ),
                            ),
                          ),
                          title: Text(tr.title,
                              style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Text(
                            DateFormat("d MMM y").format(tr.date),
                          ),
                          trailing: Wrap(
                            children: [
                              SizedBox(
                                width: 40,
                                child: TextButton(
                                    onPressed: () => modal(
                                        context, tr.title, tr.value, tr.id),
                                    child: Icon(Icons.edit_document)),
                              ),
                              SizedBox(
                                width: 40,
                                child: TextButton(
                                    onPressed: () => onRemove(tr.id),
                                    child: Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
      ],
    );
  }
}
