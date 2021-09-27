import 'package:flutter/material.dart';

class JobOffersScreen extends StatelessWidget {
  const JobOffersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Job Offers', style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
    );
  }
}
