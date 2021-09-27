import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class back_button extends StatelessWidget {
  const back_button({
    Key key,
    @required this.context, this.onPressed,
  }) : super(key: key);

  final BuildContext context;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey[50],
                  blurRadius: 3,
                  spreadRadius: 3
              )
            ]
        ),

        child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
          HapticFeedback.lightImpact();
          onPressed;

          Navigator.pop(context);
        }),
      ),
    );
  }
}