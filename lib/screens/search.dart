import 'package:expense_app/blocs/app_blocs.dart';
import 'package:expense_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Transactions'),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.error) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state.status == SearchStatus.loaded) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Title',
                    ),
                    onChanged: (keyword) {
                      searchCubit.search(keyword);
                    },
                  ),
                ),
                Expanded(
                  child: state.transactions.isEmpty
                      ? Center(
                          child: Text('No Transactions To Show'),
                        )
                      : TransactionList(
                          transactions: state.transactions,
                          deleteTransaction: (String transactionID) {
                            context.read<TransactionsBloc>().add(
                                  RemoveTransaction(
                                      transactionID: transactionID),
                                );
                          },
                        ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
