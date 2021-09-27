import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({ Key key }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Friends', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
      ),
      body: Container(),
    );
  }
}