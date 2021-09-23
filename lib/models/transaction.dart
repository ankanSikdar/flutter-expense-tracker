import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Transaction extends Equatable {
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

  @override
  List<Object> get props => [id, title, amount, date, createdOn, imagePath];
}
