import 'package:expense_app/widgets/details_title.dart';
import 'package:flutter/material.dart';

import 'package:expense_app/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contact@ankan.dev'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedImage(
                asset: 'assets/images/ankan.jpeg',
              ),
              SizedBox(height: 16.0),
              Text('Ankan Sikdar',
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: DetailsTitle(title: 'About Me'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Hello There! First of all I am very grateful to you for using my app. A little about myself. I was born in 1999 and I am an Engineer in Information Technology (Graduated in 2021) from Heritage Institute of Technology, Kolkata. I primarily spend most of my time learning and developing in Flutter. And I love sunsets, stargazing and solitude. Thats all I can think of for now. 😅',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  DetailsTitle(title: 'My Links'),
                ],
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Feel free to contact me regarding a bug, or any criticism that you might have. Or maybe just to talk about coding or life in general.',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
              ),
              DevLink(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                onPressed: () {
                  _launchUrl('https://github.com/ankanSikdar');
                },
              ),
              DevLink(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                onPressed: () {
                  _launchUrl('https://www.linkedin.com/in/ankansikdar/');
                },
              ),
              DevLink(
                icon: FontAwesomeIcons.facebook,
                label: 'Facebook',
                onPressed: () {
                  _launchUrl('https://www.facebook.com/ankanSikdar/');
                },
              ),
              DevLink(
                icon: FontAwesomeIcons.twitter,
                label: 'Twitter',
                onPressed: () {
                  _launchUrl('https://twitter.com/ankan_sikdar');
                },
              ),
              DevLink(
                icon: FontAwesomeIcons.instagram,
                label: 'Instagram',
                onPressed: () {
                  _launchUrl('https://www.instagram.com/ankan_sikdar/');
                },
              ),
              DevLink(
                icon: FontAwesomeIcons.solidEnvelope,
                label: 'Send Email',
                onPressed: () {
                  _launchUrl(
                      'mailto:contact@ankan.dev?subject=Reason%20you%20are%20contacting%20me&body=Hello%20Ankan%21');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
