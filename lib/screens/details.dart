import 'dart:io';
import 'package:expense_app/extensions/extensions.dart';
import 'package:expense_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final Transaction transaction;
  const DetailsPage({Key key, @required this.transaction}) : super(key: key);

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
                transaction.title,
                style: TextStyle(
                  fontSize: 28.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 32.0),
              Text(
                '${getCurrencySymbol()} ${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Date: ${DateFormat.yMMMMEEEEd().format(transaction.date)}',
              ),
              Text(
                  'Created At: ${DateFormat.yMMMEd().format(transaction.createdOn)} ${DateFormat.jm().format(transaction.createdOn)}'),
              SizedBox(height: 16.0),
              if (transaction.imagePath.isNotEmpty)
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.file(
                    File(transaction.imagePath),
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
