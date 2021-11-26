
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebUrl extends StatefulWidget {
  const WebUrl({Key? key}) : super(key: key);

  @override
  _WebUrlState createState() => _WebUrlState();
}

class _WebUrlState extends State<WebUrl> {
   String toLaunch = 'https://www.google.com/';

  Future<void>? _launched;

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
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
              _launched = _launchInBrowser(toLaunch);
            }),
            child: const Text('Launch in browser'),
          ),
        ],
      ),
    );
  }
}
