import 'package:expense_app/blocs/app_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            GestureDetector(
              onTap: () {
                themeCubit.toRed();
              },
              child: Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  child: Text(
                    'Red',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                themeCubit.toPurple();
              },
              child: Card(
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  child: Text(
                    'Red',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
