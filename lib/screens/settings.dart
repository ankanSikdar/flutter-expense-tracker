import 'package:expense_app/screens/screens.dart';
import 'package:expense_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              SettingsCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeveloperPage(),
                    ),
                  );
                },
                icon: Icons.person,
                title: 'Developer Contact',
              ),
              SettingsCard(
                onTap: () async {
                  final url = 'https://expense-tracker-privacy.web.app';
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {
                    // * Getting Ready for Release
                    // print('Could not launch $url');
                  }
                },
                icon: Icons.local_parking_outlined,
                title: 'Privacy Policy',
              ),
              SettingsCard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AboutPage(),
                    ),
                  );
                },
                icon: Icons.info_rounded,
                title: 'About App',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
