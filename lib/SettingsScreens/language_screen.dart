import 'package:flutter/material.dart';
import 'package:mindpeace/Widget/appbar.dart';

class LanguageScrees extends StatefulWidget {
  const LanguageScrees({Key key}) : super(key: key);

  @override
  _LanguageScreesState createState() => _LanguageScreesState();
}

class _LanguageScreesState extends State<LanguageScrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(title: 'Languages',)
    );
  }
}
