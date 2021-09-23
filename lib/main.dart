import 'package:expense_app/blocs/app_bloc_observer.dart';
import 'package:expense_app/blocs/transactions/transactions_bloc.dart';
import 'package:expense_app/repositories/transactions_repository.dart';
import 'package:expense_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = AppBlocObserver();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TransactionsRepository(),
      child: BlocProvider<TransactionsBloc>(
        create: (context) => TransactionsBloc(
          transactionsRepository: context.read<TransactionsRepository>(),
        )..add(GetTransactions()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          home: MyHomePage(),
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Poppins',
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
