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
  List<Object> get props {
    return [
      id,
      title,
      amount,
      date,
      createdOn,
      imagePath,
    ];
  }

  Transaction copyWith({
    String id,
    String title,
    double amount,
    DateTime date,
    DateTime createdOn,
    String imagePath,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      createdOn: createdOn ?? this.createdOn,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount.toString(),
      'date': date.millisecondsSinceEpoch,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'imagePath': imagePath,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      amount: double.tryParse(map['amount']) ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn']),
      imagePath: map['imagePath'],
    );
  }

  @override
  bool get stringify => true;
}
