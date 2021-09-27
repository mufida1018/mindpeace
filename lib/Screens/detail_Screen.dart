import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/play_meditation.dart';
import 'package:mindpeace/Screens/subscription_screen.dart';
import 'package:mindpeace/Widget/back_button.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DetailScreen extends StatefulWidget {
  final data;
  final Color primaryColor;
  final Color secondayColor;
  final Color backgroundColr;
  final double aspectRatio;
  final Color buttonColor;
  final Color playButtonTextColour;
  final Color playIconColor;
  final String collectionNodeName;

  const DetailScreen({Key key, this.data, this.primaryColor, this.secondayColor, this.backgroundColr, @required this.aspectRatio, this.buttonColor, this.playButtonTextColour, this.playIconColor, this.collectionNodeName}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  HelperFunction _helperFunction = HelperFunction();
  bool appBarTitleVisibility = false;

  List meditationList;
  List relatedList = [];
  ScrollController  _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListner);

    super.initState();
    if(mounted){
      getRelatedData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  _scrollListner(){
    print(_scrollController.position.pixels);

    if(_scrollController.position.pixels > 270){
      setState(() {
        appBarTitleVisibility = true;
      });
    }else{
      setState(() {
        appBarTitleVisibility = false;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);


    return Scaffold(
      backgroundColor: widget.backgroundColr,
      body: Container(
        height: height,
        child: Stack(
          children: [
            SingleChildScrollView(
                controller: _scrollController,

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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider('${widget.data['imageLink']}'

                                ),
                                // AssetImage('images/${widget.data['imageLink']}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                          Padding(
                            padding: const EdgeInsets.only(left:20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.data['isFree'] ? Container() : Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Icon(Icons.lock, color: Colors.black, size: 20,),
                                ),
                                Container(
                                    width: width *0.7,
                                    child: Text(widget.data['title'], style: kTitleTextStyle.copyWith(color: widget.primaryColor),)),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.solidHeart, size: 20, color: Colors.red,),
                                Padding(
                                  padding: const EdgeInsets.only(left:12.0, right: 20),
                                  child: Text(widget.data['likes'].length.toString(), style: kSubTitleTextStyle.copyWith(color: widget.primaryColor),),
                                ),
                              ],
                            ),
                          ),


                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
                      child: Text('By ${widget.data['author']}', style: kDescTextStyle.copyWith(fontSize: 14, color: widget.secondayColor),),
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
                    // Container(width: width, height: 100,)

                    Padding(
                      padding: const EdgeInsets.only(left:10.0, top: 8.0),
                      child: Text('Related', style: kTitleTextStyle.copyWith(color: widget.primaryColor),),
                    ),

                    // TODO: Related List ......................................
                   relatedList.length > 0 ?  Container(
                      width: width,
                      height: 250,
                      child: ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: relatedList.length,

                        itemBuilder: (context, index){
                          bool isFree = relatedList[index]['isFree'];
                          List likes = relatedList[index]['likes'];


                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Card(
                                  color: widget.backgroundColr,
                                  elevation: 0,
                                  child: Container(
                                      width: width * 0.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              child: Hero(
                                                tag: relatedList[index]['uid'],
                                                child: CachedNetworkImage(imageUrl:'${relatedList[index]['imageLink']}', width: width * 0.45, height: 125 ,fit: BoxFit.cover,
                                                  placeholder: (context, url)=> Image.asset(placeholder_image),
                                                ),
                                              )
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                isFree ? Container() : Icon(Icons.lock, color: Colors.black, size: 20,),
                                                SizedBox(width: 5,),
                                                Container(
                                                    width: width * 0.32,
                                                    child: Text(relatedList[index]['title'], style: kSubTitleTextStyle.copyWith(fontSize: 17, color: widget.primaryColor),)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.volume_up, color: widget.primaryColor, size: 20,),
                                                SizedBox(width: 5,),

                                                Text('${relatedList[index]['duration']} min', style: kDescTextStyle.copyWith(color: widget.primaryColor),),
                                                Spacer(),
                                                FaIcon(FontAwesomeIcons.solidHeart, size: 18, color: Colors.red,) ,
                                                SizedBox(width: 10,),
                                                Text('${likes.length}', style: kDescTextStyle.copyWith(fontSize: 18, color: widget.primaryColor),),
                                                SizedBox(width: 10,),

                                              ],
                                            ),
                                          ),

                                        ],
                                      )
                                  )
                              ),
                              onTap: (){
                                HapticFeedback.lightImpact();

                                  pushNewScreen(context, screen: DetailScreen(data: relatedList[index], aspectRatio: 9/16,
                                  primaryColor: Colors.black,
                                  secondayColor: Colors.black87,
                                  backgroundColr: Colors.white,
                                  playButtonTextColour: nightColourCardColour,
                                  playIconColor: nightColourCardColour,
                                  buttonColor: meditationCardColour,
                                  collectionNodeName: widget.collectionNodeName,
                                ),
                                  withNavBar: false,

                                );
                              },
                            ),
                          );

                        },
                      ),
                    ) : Container(),
                    Container(
                      height: 100,
                    ),
                  ],
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
                        image: CachedNetworkImageProvider(widget.data['imageLink']),
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
                              Center(child: Text('${widget.data['title']}', style: kSubTitleTextStyle.copyWith(color: widget.primaryColor),)),
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

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only( bottom:30.0, left: 20, right:20),
                child: CustomPlayRoundButton(
                  width: width * 0.8,
                  color: widget.buttonColor,
                  textColor: widget.playButtonTextColour,
                  icon: Icon(widget.data['isFree'] ? Icons.play_arrow_rounded : Icons.lock, color: widget.playIconColor,),
                  title: widget.data['isFree'] ? 'Play' : 'Start your Trial',
                  onPressed: (){
                    HapticFeedback.lightImpact();
                    widget.data['isFree'] ?
                    pushNewScreen(context, screen: PlayMeditationScreen(
                      aspectRation: widget.aspectRatio,
                      data: widget.data,
                      primaryColor: Colors.white,
                      secondayColor: Colors.white,
                      showFullScreen: false,
                    ), withNavBar: false) :
                        pushNewScreen(context, screen: SubscriptionScreen());

                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }




  void getRelatedData(){
    FirebaseFirestore.instance.collection(widget.collectionNodeName).where('category', isEqualTo: widget.data['category']).orderBy('timestamp', descending: true).get().then((value){
      if(value != null){
        var data = value.docs;
        relatedList = [];
        for(var i =0; i< data.length; i++){
          if(data[i]['uid'] != widget.data['uid']){
            relatedList.add(data[i]);
          }
        }
        setState(() {});
      }
    }).catchError((e){
      _helperFunction.showToast(context: context, title: e, color: Colors.red);
    });
  }



}
