import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/play_meditation.dart';
import 'package:mindpeace/Widget/back_button.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CommonDetailScreen extends StatefulWidget {
  final data;
  final Color primaryColor;
  final Color secondayColor;
  final Color backgroundColor;
  final Color playbuttonColor;
  const CommonDetailScreen({Key key, this.data, this.primaryColor, this.secondayColor, this.backgroundColor, this.playbuttonColor}) : super(key: key);

  @override
  _CommonDetailScreenState createState() => _CommonDetailScreenState();
}

class _CommonDetailScreenState extends State<CommonDetailScreen> {

  HelperFunction _helperFunction = HelperFunction();
  bool appBarTitleVisibility = false;


  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);


    return Scaffold(
        backgroundColor:widget.backgroundColor,
        body: Container(
          height: height,
          child: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo){
                  if(scrollInfo.metrics.pixels  > scrollInfo.metrics.minScrollExtent + 290){
                    setState(() {

                      appBarTitleVisibility = true;
                    });
                  }else{

                    setState(() {
                      appBarTitleVisibility = false;
                    });
                  }
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Hero(
                        tag: widget.data['uid'],
                        child: Container(
                          width: width,
                          height: 300,
                          child: CachedNetworkImage(
                            imageUrl: widget.data['imageLink'], width: width, height: 300,
                            fit: BoxFit.cover,
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: width *0.7,
                                child: Text(widget.data['title'], style: kTitleTextStyle.copyWith(color: widget.primaryColor),)),
                            // Spacer(),
                            // InkWell(
                            //     child: FaIcon(FontAwesomeIcons.solidHeart, size: 20, color: Colors.red,),
                            //   onTap: (){
                            //
                            //   },
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left:12.0, right: 20),
                            //   child: Text(widget.data['likes'].length.toString(), style: kSubTitleTextStyle.copyWith(color: widget.primaryColor),),
                            // ),
                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
                        child: Text('${widget.data['category']}', style: kDescTextStyle.copyWith(fontSize: 14, color: widget.secondayColor),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Row(
                          children: [
                            Icon(Icons.volume_up, color: widget.primaryColor, size: 20,),
                            SizedBox(width: 5,),

                            Text('${widget.data['duration']} min', style: kDescTextStyle.copyWith(color: widget.primaryColor),)
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Text(widget.data['desc'], style: kDescTextStyle.copyWith(fontSize: 16, color: widget.secondayColor),),
                        ),
                      ),
                      Container(width: width, height: 100,)
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: Visibility(
                    visible: appBarTitleVisibility,
                    child: Container(
                      height: 100,
                      width: width,

                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.data['imageLink']),
                              fit: BoxFit.cover
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaY: 10,
                              sigmaX: 10
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(width: 70,),
                                Center(child: Text('${widget.data['title']}', style: kSubTitleTextStyle.copyWith(color: Colors.white),)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              Positioned(
                top: 15,
                left: 0,
                child: back_button(context: context),
              ),

              Positioned(
                bottom: 30,
                left: (width * 0.4) - 125,

                child: customRoundButton(
                  width: 350,
                  color: widget.playbuttonColor,
                  textColor: nightColour,
                  title: 'Play',
                  onPressed: (){
                    HapticFeedback.lightImpact();
                    pushNewScreen(context, screen: PlayMeditationScreen(
                      aspectRation: 9/16,
                      data: widget.data,
                      primaryColor: widget.primaryColor,
                      secondayColor: widget.secondayColor,
                      showFullScreen: false,
                    ), withNavBar: false);

                  },
                ),
              )


            ],
          ),
        )
    );
  }

  void LikeDisklikeVideo(){
    var uid = widget.data['uid'];
  }
}
