import 'package:flutter/material.dart';

class kAppBar extends StatelessWidget with PreferredSizeWidget{
  const kAppBar({Key key, this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.black),),
      centerTitle: false,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
