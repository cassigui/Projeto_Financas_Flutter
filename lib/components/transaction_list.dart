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
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Nenhuma Transação Cadastrada!",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: constraints.maxHeight * 0.5,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ]);
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
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
                    trailing: MediaQuery.of(context).size.width > 580
                        ? Wrap(
                            children: [
                              SizedBox(
                                child: TextButton.icon(
                                  onPressed: () =>
                                      modal(context, tr.title, tr.value, tr.id),
                                  icon: Icon(Icons.edit_document),
                                  label: Text("Editar"),
                                ),
                              ),
                              SizedBox(
                                child: TextButton.icon(
                                  onPressed: () => onRemove(tr.id),
                                  icon: Icon(Icons.delete),
                                  label: Text("Excluir"),
                                ),
                              ),
                            ],
                          )
                        : Wrap(
                            children: [
                              SizedBox(
                                child: TextButton(
                                    onPressed: () => modal(
                                        context, tr.title, tr.value, tr.id),
                                    child: Icon(Icons.edit_document)),
                              ),
                              SizedBox(
                                child: TextButton(
                                  onPressed: () => onRemove(tr.id),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          )),
              );
            });
  }
}
