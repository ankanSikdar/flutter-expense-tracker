import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final DateTime createdOn;
  final String imagePath;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.createdOn,
    @required this.imagePath,
  });
}
