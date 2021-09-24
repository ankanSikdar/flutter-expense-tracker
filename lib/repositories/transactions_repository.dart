import 'package:expense_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf;

class TransactionsRepository {
  static const tableName = 'transactions';
  String dbPath;
  sqf.Database db;

  Future<List<Transaction>> loadTransactions() async {
    dbPath = join(await sqf.getDatabasesPath(), 'transactions_data.db');

    final dbAlreadyExists = await sqf.databaseExists(dbPath);
    if (dbAlreadyExists) {
      db = await sqf.openDatabase(dbPath, version: 1);
      return await getAllTransactions();
    } else {
      db = await sqf.openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, amount TEXT, date INTEGER, createdOn INTEGER, imagePath TEXT)');
        },
      );
      return [];
    }
  }

  Future<List<Transaction>> getAllTransactions() async {
    final List<Map> tList = await db.query(tableName, orderBy: 'date');
    final List<Transaction> transactions =
        tList.map((tMap) => Transaction.fromMap(tMap)).toList();
    return transactions;
  }

  Future<List<Transaction>> addTransaction(
      {@required List<Transaction> list, @required Transaction addT}) async {
    await db.insert(tableName, addT.toMap(),
        conflictAlgorithm: sqf.ConflictAlgorithm.replace);
    return await getAllTransactions();
  }

  Future<List<Transaction>> removeTransaction(
      {@required List<Transaction> list, @required String remTID}) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [remTID]);
    return await getAllTransactions();
  }
}
