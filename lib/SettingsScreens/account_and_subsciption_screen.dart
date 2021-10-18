import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;
import 'package:mindpeace/Widget/appbar.dart';


class AccountAndSubscriptionScreen extends StatefulWidget {
  const AccountAndSubscriptionScreen({Key key}) : super(key: key);

  @override
  _AccountAndSubscriptionScreenState createState() => _AccountAndSubscriptionScreenState();
}

class _AccountAndSubscriptionScreenState extends State<AccountAndSubscriptionScreen> {

  List imageList;
  String content;
  String title;
  String author;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(title: 'Accounts & Subscription',),
    );
  }


}
