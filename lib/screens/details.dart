import 'dart:io';
import 'dart:ui';
import 'package:expense_app/extensions/extensions.dart';
import 'package:expense_app/models/models.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final Transaction _transaction;
  const DetailsPage({Key key, @required Transaction transaction})
      : _transaction = transaction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 54.0),
          child: Column(
            children: [
              DetailsRow(title: 'Title:', content: _transaction.title),
              DetailsRow(
                  title: 'Amount:',
                  content:
                      '${getCurrencySymbol()} ${_transaction.amount.toStringAsFixed(2)}'),
              DetailsRow(
                  title: 'Date:',
                  content:
                      '${DateFormat.yMMMMEEEEd().format(_transaction.date)}'),
              DetailsRow(
                  title: 'Added:',
                  content:
                      '${DateFormat.yMMMEd().format(_transaction.createdOn)} ${DateFormat.jm().format(_transaction.createdOn)}'),
              if (_transaction.imagePath.isNotEmpty)
                Container(
                  width: double.infinity,
                  child: Image.file(
                    File(_transaction.imagePath),
                    fit: BoxFit.fitWidth,
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final editedTransaction = await showModalBottomSheet(
            context: context,
            builder: (_) => NewTransaction.edit(
              transaction: _transaction,
            ),
            isScrollControlled: true,
          );
          if (editedTransaction != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(transaction: editedTransaction as Transaction),
              ),
            );
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String title;
  final String content;

  const DetailsRow({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            margin: EdgeInsets.only(right: 8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
