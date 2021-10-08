import 'package:expense_app/screens/screens.dart';
import 'package:expense_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SettingsCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeThemePage(),
                    ),
                  );
                },
                icon: Icons.color_lens_rounded,
                title: 'Change Theme',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
