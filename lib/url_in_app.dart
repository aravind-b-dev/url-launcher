
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlInsideApp extends StatefulWidget {
  const UrlInsideApp({Key? key}) : super(key: key);

  @override
  _UrlInsideAppState createState() => _UrlInsideAppState();
}

class _UrlInsideAppState extends State<UrlInsideApp> {
  Future<void>? _launched;
  String toLaunch = 'https://www.google.com/';

  Future<void> _launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => setState(() {
              _launched = _launchInWebViewOrVC(toLaunch);
            }),
            child: const Text('Launch in app'),
          ),
        ],
      ),
    );
  }
}
