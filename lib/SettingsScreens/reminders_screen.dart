import 'package:flutter/material.dart';
import 'package:mindpeace/Widget/appbar.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({Key key}) : super(key: key);

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(
        title: 'Set Reminders',
      ),
    );
  }
}
