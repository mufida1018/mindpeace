import 'package:flutter/material.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({Key key}) : super(key: key);

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
    );
  }
}
