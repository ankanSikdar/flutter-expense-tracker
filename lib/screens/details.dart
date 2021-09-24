import 'dart:io';
import 'package:expense_app/extensions/extensions.dart';
import 'package:expense_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final Transaction _transaction;
  const DetailsPage({Key key, Transaction transaction})
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Text(
                _transaction.title,
                style: TextStyle(
                  fontSize: 28.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 32.0),
              Text(
                '${getCurrencySymbol()} ${_transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Date: ${DateFormat.yMMMMEEEEd().format(_transaction.date)}',
              ),
              Text(
                  'Created At: ${DateFormat.yMMMEd().format(_transaction.createdOn)} ${DateFormat.jm().format(_transaction.createdOn)}'),
              SizedBox(height: 16.0),
              if (_transaction.imagePath.isNotEmpty)
                Container(
                  height: 200,
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
    );
  }
}
