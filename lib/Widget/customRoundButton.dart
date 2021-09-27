
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';

class customRoundButton extends StatelessWidget {

  customRoundButton({this.title, this.textColor,this.color, this.height, this.width, @required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: width,
        height: height,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: kSubTitleTextStyle.copyWith(color: textColor)
        ),
      ),
    );
  }
}


class customIconRoundButton extends StatelessWidget {

  customIconRoundButton({this.color, this.height, this.width, @required this.onPressed, this.icon});

  final Color color;
  final Function onPressed;
  final double width;
  final double height;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: width,
        height: height,
        child:icon
      ),
    );
  }
}


class CustomPlayRoundButton extends StatelessWidget {

  CustomPlayRoundButton({this.title, this.textColor,this.color, this.height, this.width, @required this.onPressed, this.icon});

  final Color color;
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10,),
            Text(
              title,
              textAlign: TextAlign.center,
              style: kSubTitleTextStyle.copyWith(color: textColor)
          ),
        ]
        ),
      ),
    );
  }
}


