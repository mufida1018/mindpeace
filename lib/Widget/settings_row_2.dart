import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';

class settings_row_2 extends StatelessWidget {
  const settings_row_2({
    Key key,
    @required this.title,
    @required this.width,
    @required this.buttonTitle,
    @required this.onPressed, 
    @ required this.description,
  }) : super(key: key);

  final String title;
  final String description;
  final double width;
  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
        
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: kSubTitleTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(description,
                      style: kDescTextStyle.copyWith(
                          color: Colors.grey[700], fontSize: 17)),
                ],
              ),
              // Spacer(),
              GestureDetector(
                  child: Text(buttonTitle,
                      style: kSubTitleTextStyle.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: onPressed),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width,
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
