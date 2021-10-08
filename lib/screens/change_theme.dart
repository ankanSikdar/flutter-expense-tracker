import 'package:flutter/material.dart';

class ChangeThemePage extends StatelessWidget {
  const ChangeThemePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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
          ],
        ),
      ),
    );
  }
}
