import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/all_meditation_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {


  HelperFunction _helperFunction = HelperFunction();

  List meditationCategoryList;
  var randomMeditation;


  var svgList = ['meditation','yagna' ,'calm', 'lotus', 'peace','lotus-position'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getMeditationCategory();

    }
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var hight = _helperFunction.getHeight(context);



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
              Container(
                width: width,
                child: Center(child: Lottie.asset('lottie/meditation_3.json', height: 250, fit: BoxFit.fitHeight)),
              ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Meditations', style: kTitleTextStyle,),
            ),
            meditationCategoryList != null ?
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: meditationCategoryList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: Container(
                      width: width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Container(
                                width: width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(meditationCategoryList[index]['name'], style: kSubTitleTextStyle),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(meditationCategoryList[index]['desc'],),

                                  ],
                                ),
                              ),
                            ),
                            SvgPicture.asset('svg/${svgList[index]}.svg',width: width * 0.25, fit: BoxFit.fitWidth,),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: meditationCardColour,

                      ),
                    ),
                    onTap: (){
                    pushNewScreen(
                      context,
                      screen: AllMeditationScreen(category: meditationCategoryList[index]['name'] , desc:  meditationCategoryList[index]['desc'] ,),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino
                    );
                    },
                  ),
                );
              },
            ): Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      )
    );
  }

  void getMeditationCategory(){
    FirebaseFirestore.instance.collection('meditation_category').orderBy('num', descending: false).snapshots().listen((snapshot) {
        if(snapshot != null){
          meditationCategoryList = snapshot.docs;
        }
        setState(() {});
    });
  }
}