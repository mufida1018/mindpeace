import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';

class Settings_Row extends StatelessWidget {
  const Settings_Row({
    Key key,
    @required this.width, @required this.title, @required this.onPressed,
  }) : super(key: key);

  final double width;
  final String title;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          height: 75,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(title, style:kTitleTextStyle.copyWith(color: Colors.black, fontSize: 20) ,),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: 20,)
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: width,
                  height: 1,
                  color: Colors.black26,
                ),

              ],
            ),
          ),
        ),
        onTap: onPressed
    );
  }
}
