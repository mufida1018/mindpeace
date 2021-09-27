import 'package:flutter/material.dart';

class LanguageScrees extends StatefulWidget {
  const LanguageScrees({Key key}) : super(key: key);

  @override
  _LanguageScreesState createState() => _LanguageScreesState();
}

class _LanguageScreesState extends State<LanguageScrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Language Scree', style: TextStyle(color: Colors.black),),
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
    );
  }
}
