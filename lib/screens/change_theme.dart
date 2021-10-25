import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_app/widgets/widgets.dart';
import 'package:expense_app/blocs/app_blocs.dart';

class ChangeThemePage extends StatelessWidget {
  const ChangeThemePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SelectColorCard(
              color: Colors.green,
              onTap: () {
                themeCubit.toGreen();
              },
              title: 'Green',
            ),
            SelectColorCard(
              color: Colors.purple,
              onTap: () {
                themeCubit.toPurple();
              },
              title: 'Purple',
            ),
            SelectColorCard(
              color: Colors.red,
              onTap: () {
                themeCubit.toRed();
              },
              title: 'Red',
            ),
            SelectColorCard(
              color: Colors.blue,
              onTap: () {
                themeCubit.toBlue();
              },
              title: 'Blue',
            ),
          ],
        ),
      ),
    );
  }
}
