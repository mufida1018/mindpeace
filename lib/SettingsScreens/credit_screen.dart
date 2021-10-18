import 'package:flutter/material.dart';
import 'package:mindpeace/IAPScreens/in_app_purchase_screen.dart';
import 'package:mindpeace/Widget/appbar.dart';

class CreditScreens extends StatelessWidget {
  const CreditScreens({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(
        title: 'Credits' ,
      ),

      body: Center(
        child: ElevatedButton(
          child: Text('Purchase Screen'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => InAppPurchaseScreen()));
          },
        ),
      ),

    );
  }
}
