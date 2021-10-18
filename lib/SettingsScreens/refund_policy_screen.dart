import 'package:flutter/material.dart';
import 'package:mindpeace/Widget/appbar.dart';

class RefundPolicyScreen extends StatefulWidget {
  const RefundPolicyScreen({Key key}) : super(key: key);

  @override
  _RefundPolicyScreenState createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(
        title: 'Refund Policy',
      ),
      body: Center(
        child: Text('Refund Policy Screen'),
      ),
    );
  }
}
