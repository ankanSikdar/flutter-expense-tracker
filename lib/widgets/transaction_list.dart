import 'package:expense_app/models/models.dart';
import 'package:expense_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == transactions.length) {
          return SizedBox(height: 75.0);
        }
        return TransactionItem(
            transaction: transactions[index],
            deleteTransaction: deleteTransaction);
      },
      itemCount: transactions.length + 1,
    );
  }
}
