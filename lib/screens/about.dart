import 'package:expense_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String appName = "App Name";
  String packageName = "Package Name";
  String version = "Version";

  PackageInfo packageInfo;

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  Future<void> loadInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            RoundedImage(asset: 'assets/images/app_icon.png'),
            Text(
              appName,
              style: TextStyle(
                  fontSize: 32, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 32.0),
            Text(
              packageName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 32.0),
            Text(
              'Version: $version',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
