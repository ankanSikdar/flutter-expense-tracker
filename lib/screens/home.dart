import 'package:expense_app/blocs/transactions/transactions_bloc.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:expense_app/widgets/week_bar_chart.dart';
import 'package:expense_app/widgets/week_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => NewTransaction(),
      isScrollControlled: true,
    );
  }

  bool showBarChart = true;

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: Text('Expense Tracker'),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            if (state.status == TStatus.initial ||
                state.status == TStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return state.transactionsList.isEmpty
                ? Column(
                    children: [
                      Text(
                        'No Transactions Added Yet!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400.0,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/waiting.png',
                        ),
                      ),
                    ],
                  )
                : Column(
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
                              ? WeekBarChart(
                                  transactions: state.transactionsList)
                              : WeekPieChart(
                                  transactions: state.transactionsList,
                                ),
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.5,
                        child: TransactionList(
                          transactions:
                              state.transactionsList.reversed.toList(),
                          deleteTransaction: (String transactionID) {
                            context.read<TransactionsBloc>().add(
                                RemoveTransaction(
                                    transactionID: transactionID));
                          },
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
