import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/all_sleep_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  HelperFunction _helperFunction = HelperFunction();
  
  
  List sleepCategoryList;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getSleepCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);


    return Scaffold(
      backgroundColor: nightColour,
      appBar: AppBar(
        backgroundColor: nightColour,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              child: Center(child: Lottie.asset('lottie/sleepy-cat.json', height: 250, fit: BoxFit.fitHeight)),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Sleep', style: kTitleTextStyle.copyWith(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Sleep Categories', style: kSubTitleTextStyle.copyWith(color: Colors.white),),
            ),
            sleepCategoryList != null ?
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sleepCategoryList.length,
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
                                    Text(sleepCategoryList[index]['name'], style: kSubTitleTextStyle.copyWith(color: Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(sleepCategoryList[index]['desc'],style: TextStyle(color: Colors.white),),

                                  ],
                                ),
                              ),
                            ),
                            SvgPicture.asset('svg/${sleepCategoryList[index]['imagePath']}.svg',width: width * 0.25, fit: BoxFit.fitWidth,),

                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: nightColourCardColour,

                      ),
                    ),
                    onTap: (){
                      print('${sleepCategoryList[index]['name']}');
                      pushNewScreen(context, screen: AllSleepScreen(
                        category: sleepCategoryList[index]['name'],
                        desc: sleepCategoryList[index]['desc'],


                      ),  withNavBar: false);
                    },
                  ),
                );
              },
            ):
                Center(
                  child: CircularProgressIndicator(),
                )

          ],
        ),
      ),

    );
  }
  
  void getSleepCategory(){
    FirebaseFirestore.instance.collection('sleep_category').orderBy('num', descending: false).snapshots().listen((event) {
        if(event != null){
          sleepCategoryList = event.docs;
        }
        setState(() {});
    });
  }
}
