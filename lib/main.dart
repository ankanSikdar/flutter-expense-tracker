import 'package:expense_app/blocs/app_blocs.dart';
import 'package:expense_app/repositories/repositories.dart';
import 'package:expense_app/screens/screens.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TransactionsBloc>(
            create: (context) => TransactionsBloc(
              transactionsRepository: context.read<TransactionsRepository>(),
            )..add(GetTransactions()),
          ),
          BlocProvider(
            create: (context) => GoogleAdsCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: ExpenseTrackerApp(),
      ),
    );
  }
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          home: MyHomePage(),
          theme: state.theme,
        );
      },
    );
  }
}
