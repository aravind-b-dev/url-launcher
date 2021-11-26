
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNo extends StatefulWidget {
  const PhoneNo({Key? key}) : super(key: key);

  @override
  _PhoneNoState createState() => _PhoneNoState();
}

class _PhoneNoState extends State<PhoneNo> {
  String _phone = '';
  bool _hasCallSupport = false;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (String text) => _phone = text,
                decoration: const InputDecoration(
                    hintText: 'Input the phone number to launch')),
          ),
          ElevatedButton(
            onPressed: _hasCallSupport
                ? () => setState(() {
              _launched = _makePhoneCall(_phone);
            })
                : null,
            child: _hasCallSupport
                ? const Text('Make phone call')
                : const Text('Calling not supported'),
          ),
        ],
      ),
    );
  }
}
