import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:expense_app/widgets/week_bar_chart.dart';
import 'package:expense_app/widgets/week_pie_chart.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 1150.00,
      date: DateTime.parse("2020-08-17 20:18:04Z"),
    ),
    Transaction(
      id: 't2',
      title: 'New Pants',
      amount: 2799.00,
      date: DateTime.parse("2020-08-18 20:18:04Z"),
    ),
    Transaction(
      id: 't3',
      title: 'New Watch',
      amount: 2150.00,
      date: DateTime.parse("2020-08-19 20:18:04Z"),
    ),
    Transaction(
      id: 't4',
      title: 'New Shirt',
      amount: 999.99,
      date: DateTime.parse("2020-08-20 20:18:04Z"),
    ),
    Transaction(
      id: 't5',
      title: 'New Clock',
      amount: 450.00,
      date: DateTime.parse("2020-08-21 20:18:04Z"),
    ),
    Transaction(
      id: 't6',
      title: 'New Pen',
      amount: 759.99,
      date: DateTime.parse("2020-08-22 20:18:04Z"),
    ),
    Transaction(
      id: 't7',
      title: 'New Headphone',
      amount: 959.99,
      date: DateTime.parse("2020-08-23 20:18:04Z"),
    ),
  ];

  void _addNewTransaction({String title, double amount, DateTime date}) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(
        addTransaction: _addNewTransaction,
      ),
      isScrollControlled: true,
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  bool showBarChart = true;

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: Text('Expense Tracker'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  int sensitivity = 8;
                  if (details.primaryVelocity > sensitivity ||
                      details.primaryVelocity < -sensitivity) {
                    setState(() {
                      showBarChart = !showBarChart;
                    });
                  }
                },
                child: showBarChart
                    ? WeekBarChart(transactions: _userTransactions)
                    : WeekPieChart(
                        transactions: _userTransactions,
                      ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: TransactionList(
                transactions: _userTransactions.reversed.toList(),
                deleteTransaction: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
