import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';

class HomeScreenRoutineWidget extends StatelessWidget {
  const HomeScreenRoutineWidget({
    Key key,
    @required this.width, @required this.widgetData, @required this.onPressed,
  }) : super(key: key);

  final double width;
  final widgetData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              Container(
                  width: width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(widgetData['title'], style: kTitleTextStyle.copyWith(fontSize: 20),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.volumeUp, color: Colors.black87, size: 15,),
                          SizedBox(width: 5,),
                          Text(widgetData['category'], style: kSubTitleTextStyle.copyWith(fontSize: 16, color: Colors.deepOrangeAccent),)
                        ],
                      ),
                      SizedBox(height: 5,),

                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.clock, color: Colors.black87, size: 15,),
                          SizedBox(width: 5,),
                          Text("${widgetData['duration']} Min", style: kSubTitleTextStyle.copyWith(fontSize: 16, color: Colors.black87),)
                        ],
                      ),
                    ],
                  )
              ),
              Spacer(),
              Hero(
                tag: widgetData['uid'],
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    // width: width * 0.35,
                    // color: Colors.amber,
                    child: CachedNetworkImage(imageUrl: widgetData['imageLink'],
                      width: width * 0.35,
                      height: width * 0.3,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(placeholder_image),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        onTap: onPressed
    );
  }
}
