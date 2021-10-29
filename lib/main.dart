import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expense_app/blocs/app_blocs.dart';
import 'package:expense_app/repositories/repositories.dart';
import 'package:expense_app/screens/screens.dart';

void main() async {
  // Google Fonts License
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // * Getting Ready for Release
  // Bloc.observer = AppBlocObserver();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(new MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({
    @required this.sharedPreferences,
  });

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
            create: (context) => ThemeCubit(
              preferences: sharedPreferences,
            ),
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
