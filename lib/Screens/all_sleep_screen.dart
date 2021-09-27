import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/detail_Screen.dart';
import 'package:mindpeace/Screens/medetation_screen.dart';
import 'package:mindpeace/Screens/play_meditation.dart';
import 'package:mindpeace/Widget/back_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AllSleepScreen extends StatefulWidget {
  final String category;
  final String desc;

  const AllSleepScreen({Key key, this.category, this.desc}) : super(key: key);


  @override
  _AllSleepScreenState createState() => _AllSleepScreenState();
}

class _AllSleepScreenState extends State<AllSleepScreen> {


  HelperFunction _helperFunction = HelperFunction();
  bool appBarTitleVisibility = false;
  List sleepList;
  var uid = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if(mounted){
      getUid();
      getAllSleep();
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);

    return Scaffold(
      backgroundColor: nightColour,
      body: Stack(
        children: [
          SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo){
                if(scrollInfo.metrics.pixels  > scrollInfo.metrics.minScrollExtent + 50){
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            back_button(context: context),
                            SizedBox(width: 20,),
                            Text('${widget.category}',style: kTitleTextStyle.copyWith(color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top:10),
                        child: Text(widget.desc, style: kDescTextStyle.copyWith(color: Colors.white.withOpacity(0.8)),),
                      ),

                      sleepList != null ?
                      GridView.builder(

                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (2/3)
                        ),
                        itemCount: sleepList.length,
                        itemBuilder: (context, index){
                          bool isFree = sleepList[index]['isFree'];
                          List likes = sleepList[index]['likes'];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Card(
                                  color: nightColour,
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
                                                  tag: sleepList[index]['uid'],
                                                  child: CachedNetworkImage(imageUrl: '${sleepList[index]['imageLink']}', width: width * 0.45, height: 125 ,fit: BoxFit.cover,
                                                  placeholder: (context, url) => Image.asset(placeholder_image) ,
                                                  ))


                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                isFree ? Container() : Icon(Icons.lock, color: Colors.white, size: 20,),
                                                SizedBox(width: 5,),
                                                Container(
                                                    width: width * 0.32,
                                                    child: Text(sleepList[index]['title'], style: kSubTitleTextStyle.copyWith(color: Colors.white,fontSize: 17),)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.person, color: Colors.white.withOpacity(0.3), size: 20,),
                                                SizedBox(width: 5,),

                                                Text('${sleepList[index]['author']}', style: kDescTextStyle.copyWith(color: Colors.white.withOpacity(0.3)),)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0, top: 4.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.volume_up, color: Colors.white.withOpacity(0.3), size: 20,),
                                                SizedBox(width: 5,),

                                                Text('${sleepList[index]['duration']} min', style: kDescTextStyle.copyWith(color: Colors.white.withOpacity(0.3)),),
                                                Spacer(),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:8.0,right:8.0 ),
                                                  child: GestureDetector(child:
                                                  likes.contains(uid) ?
                                                  FaIcon(FontAwesomeIcons.solidHeart, size: 18, color: Colors.red,) : FaIcon(FontAwesomeIcons.heart, size: 18, color: Colors.white.withOpacity(0.3),),
                                                    onTap: (){
                                                      if(likes.contains(uid)){
                                                        FirebaseFirestore.instance.collection('sleep').doc(sleepList[index]['uid']).update({'likes': FieldValue.arrayRemove([uid])});
                                                      }else{
                                                        FirebaseFirestore.instance.collection('sleep').doc(sleepList[index]['uid']).update({'likes': FieldValue.arrayUnion([uid])});
                                                      }
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Text('${likes.length}', style: kDescTextStyle.copyWith(color: Colors.white.withOpacity(0.3)),),
                                                SizedBox(width: 5,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  )
                              ),
                              onTap: (){
                                pushNewScreen(context, screen: DetailScreen(
                                  data: sleepList[index],
                                  primaryColor: Colors.white,
                                  secondayColor: Colors.grey,
                                  backgroundColr: nightColour,
                                  playButtonTextColour: nightColourCardColour,
                                  playIconColor: nightColourCardColour,
                                  buttonColor: meditationCardColour,
                                  aspectRatio: 16/9,
                                  collectionNodeName: 'sleep',
                                ), withNavBar: false);

                                HapticFeedback.lightImpact();

                              },
                            ),
                          );
                        },
                      ) : CircularProgressIndicator(),
                    ]
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Visibility(
              visible: appBarTitleVisibility,
              child: Container(
                  color: nightColour,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
                          Navigator.pop(context);
                        }),
                        SizedBox(width: 20,),
                        Center(child: Text('${widget.category}',style: kSubTitleTextStyle.copyWith(color: Colors.white),)),
                      ],
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  void getAllSleep(){
    FirebaseFirestore.instance.collection('sleep').where('category', isEqualTo: widget.category).orderBy('timestamp', descending: true).snapshots().listen((snapshot) {
      if(snapshot != null){
        sleepList = snapshot.docs;
        print(sleepList);
        setState(() {});
      }

    });
  }



  void getUid()async{
    uid = await _helperFunction.getUid();
  }

}
