import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Screen', style: TextStyle(color: Colors.black),),
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
    );
  }
}
