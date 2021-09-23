import 'package:expense_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class TransactionsRepository {
  Future<List<Transaction>> loadTransactions() async {
    await Future.delayed(Duration(seconds: 1));
    return testTransactions;
  }

  Future<List<Transaction>> addTransaction(
      {@required List<Transaction> list, @required Transaction addT}) async {
    final newList = [...list];
    newList.add(addT);
    return newList;
  }

  Future<List<Transaction>> removeTransaction(
      {@required List<Transaction> list, @required String remTID}) async {
    final newList = [...list];
    newList.removeWhere((t) => t.id == remTID);
    return newList;
  }
}

final List<Transaction> testTransactions = [
  Transaction(
    id: Uuid().v4(),
    title: 'New Shoes',
    amount: 1150.00,
    date: DateTime.parse("2020-08-17 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Pants',
    amount: 2799.00,
    date: DateTime.parse("2020-08-18 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Watch',
    amount: 2150.00,
    date: DateTime.parse("2020-08-19 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Shirt',
    amount: 999.99,
    date: DateTime.parse("2020-08-20 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Clock',
    amount: 450.00,
    date: DateTime.parse("2020-08-21 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Pen',
    amount: 759.99,
    date: DateTime.parse("2020-08-22 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
  Transaction(
    id: Uuid().v4(),
    title: 'New Headphone',
    amount: 959.99,
    date: DateTime.parse("2020-08-23 20:18:04Z"),
    createdOn: DateTime.now(),
    imagePath: '',
  ),
];
