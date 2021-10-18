import 'package:flutter/material.dart';
import 'package:mindpeace/Widget/appbar.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key key}) : super(key: key);

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(
        title: 'Terms & Conditions',
      ),
      body: Center(
        child: Text('Terms and Condition Screen'),
      ),
    );
  }
}
