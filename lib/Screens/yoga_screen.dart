import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/all_yoga_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'all_meditation_screen.dart';

class YogaScreen extends StatefulWidget {
  @override
  _YogaScreenState createState() => _YogaScreenState();
}


class _YogaScreenState extends State<YogaScreen> {



  HelperFunction _helperFunction = HelperFunction();
  List yogaCategoriesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getYogaCategories();

    }
  }



  @override
  Widget build(BuildContext context) {

    var width = _helperFunction.getWidth(context);
    var hight = _helperFunction.getHeight(context);


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
          width: width,
          child: Center(child: Lottie.asset('lottie/yoga.json', height: 250, fit: BoxFit.fitHeight)),
        ),
            ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Yoga', style: kTitleTextStyle,),
        ),
            yogaCategoriesList != null ?
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: yogaCategoriesList.length,
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
                                    Text(yogaCategoriesList[index]['name'], style: kSubTitleTextStyle),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(yogaCategoriesList[index]['desc'],),

                                  ],
                                ),
                              ),
                            ),
                            SvgPicture.asset('svg/${yogaCategoriesList[index]['imageLink']}.svg',width: width * 0.25, fit: BoxFit.fitWidth,),
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
                          screen: AllYogaScreen(category: yogaCategoriesList[index]['name'] , desc:  yogaCategoriesList[index]['desc'] ,),
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

  void getYogaCategories(){
    FirebaseFirestore.instance.collection('yoga_category').snapshots().listen((snapshot) {
      if(snapshot != null){
        yogaCategoriesList = snapshot.docs;
        print(yogaCategoriesList[1]['imageLink']);
      }
      setState(() {});
    });
  }
}

