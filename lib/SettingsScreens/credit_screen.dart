import 'package:flutter/material.dart';

class CreditScreens extends StatelessWidget {
  const CreditScreens({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text('Credits', style: TextStyle(color: Colors.black),),
      ),

    );
  }
}
