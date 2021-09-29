import 'package:expense_app/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf;

class TransactionsRepository {
  static const _tableName = 'transactions';
  String _dbPath;
  sqf.Database _db;

  Future<List<Transaction>> loadTransactions() async {
    _dbPath = join(await sqf.getDatabasesPath(), 'transactions_data.db');
    try {
      final dbAlreadyExists = await sqf.databaseExists(_dbPath);
      if (dbAlreadyExists) {
        _db = await sqf.openDatabase(_dbPath, version: 1);
        return await getAllTransactions();
      } else {
        _db = await sqf.openDatabase(
          _dbPath,
          version: 1,
          onCreate: (db, version) {
            return db.execute(
                'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, title TEXT, amount TEXT, date INTEGER, createdOn INTEGER, imagePath TEXT)');
          },
        );
        return [];
      }
    } catch (e) {
      throw Exception('Unable to create/get database.');
    }
  }

  Future<List<Transaction>> getAllTransactions() async {
    try {
      final List<Map> tList = await _db.query(_tableName, orderBy: 'date');
      final List<Transaction> transactions =
          tList.map((tMap) => Transaction.fromMap(tMap)).toList();
      return transactions;
    } catch (e) {
      throw Exception('Unable to get transactions.');
    }
  }

  Future<List<Transaction>> addTransaction(
      {@required List<Transaction> list, @required Transaction addT}) async {
    try {
      await _db.insert(_tableName, addT.toMap(),
          conflictAlgorithm: sqf.ConflictAlgorithm.replace);
      return await getAllTransactions();
    } catch (e) {
      throw Exception('Unable to get add transaction.');
    }
  }

  Future<List<Transaction>> removeTransaction(
      {@required List<Transaction> list, @required String remTID}) async {
    try {
      await _db.delete(_tableName, where: 'id = ?', whereArgs: [remTID]);
      return await getAllTransactions();
    } catch (e) {
      throw Exception('Unable to get delete transaction.');
    }
  }

  Future<List<Transaction>> filterTransactions(
      {@required String keyword}) async {
    try {
      final filtered = await _db
          .query(_tableName, where: 'title LIKE ?', whereArgs: ['%$keyword%']);
      final list = filtered.map((e) => Transaction.fromMap(e)).toList();
      return list;
    } catch (e) {
      throw Exception('Unable to filter transactions.');
    }
  }

  Future<bool> updateTransaction({@required Transaction transaction}) async {
    try {
      await _db.update(_tableName, transaction.toMap(),
          where: 'id = ?', whereArgs: [transaction.id]);
      return true;
    } catch (e) {
      throw Exception('Unable to update transaction.');
    }
  }
}
