import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/repositories/transactions_repository.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepository transactionsRepository;

  TransactionsBloc({@required TransactionsRepository transactionsRepository})
      : this.transactionsRepository = transactionsRepository,
        super(TransactionsState.initial()) {
    on<TransactionsEvent>(
        (TransactionsEvent event, Emitter<TransactionsState> emit) async {
      if (event is UpdateTransactions) {
        emit(state.copyWith(
            transactionsList: event.transactions, status: TStatus.loaded));
      }
      if (event is GetTransactions) {
        emit(state.copyWith(status: TStatus.loading));
        final transactions = await transactionsRepository.loadTransactions();
        add(UpdateTransactions(transactions: transactions));
      }

      if (event is AddTransaction) {
        emit(state.copyWith(status: TStatus.loading));
        final transactions = await transactionsRepository.addTransaction(
            list: state.transactionsList, addT: event.transaction);
        add(UpdateTransactions(transactions: transactions));
      }

      if (event is RemoveTransaction) {
        emit(state.copyWith(status: TStatus.loading));
        final transactions = await transactionsRepository.removeTransaction(
            list: state.transactionsList, remTID: event.transactionID);
        add(UpdateTransactions(transactions: transactions));
      }
    });
  }
}
