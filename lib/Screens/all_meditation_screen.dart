import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/detail_Screen.dart';
import 'package:mindpeace/Screens/play_meditation.dart';
import 'package:mindpeace/Widget/back_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AllMeditationScreen extends StatefulWidget {
  final String category;
  final String desc;


  const AllMeditationScreen({Key key, this.category, this.desc}) : super(key: key);
  @override
  _AllMeditationScreenState createState() => _AllMeditationScreenState();
}

class _AllMeditationScreenState extends State<AllMeditationScreen> {


  HelperFunction _helperFunction = HelperFunction();
  bool appBarTitleVisibility = false;

  List meditationList;
  var uid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.category);
    if(mounted){
      getUid();
      getAllMeditation();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
                      height: 100,
                      child: Row(
                        children: [
                          back_button(context: context),
                          SizedBox(width: 20,),
                          Text('${widget.category}',style: kTitleTextStyle,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('${widget.desc}', style: kSubTitleTextStyle.copyWith(fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                    ),
                    meditationList != null ?
                    GridView.builder(

                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (2/2.5)
                      ),
                      itemCount: meditationList.length,
                      itemBuilder: (context, index){
                        bool isFree = meditationList[index]['isFree'];
                        List likes = meditationList[index]['likes'];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Card(
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
                                            tag: meditationList[index]['uid'],
                                            child: CachedNetworkImage(imageUrl:'${meditationList[index]['imageLink']}', width: width * 0.45, height: 125 ,fit: BoxFit.cover,
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
                                              child: Text(meditationList[index]['title'], style: kSubTitleTextStyle.copyWith(fontSize: 17),)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.volume_up, color: Colors.black, size: 20,),
                                          SizedBox(width: 5,),

                                          Text('${meditationList[index]['duration']} min', style: kDescTextStyle,),
                                          Spacer(),
                                          GestureDetector(child:
                                          likes.contains(uid) ?
                                          FaIcon(FontAwesomeIcons.solidHeart, size: 18, color: Colors.red,) : FaIcon(FontAwesomeIcons.heart, size: 18, color: Colors.black,),
                                            onTap: (){
                                              if(likes.contains(uid)){
                                                FirebaseFirestore.instance.collection('meditation').doc(meditationList[index]['uid']).update({'likes': FieldValue.arrayRemove([uid])});
                                              }else{
                                                FirebaseFirestore.instance.collection('meditation').doc(meditationList[index]['uid']).update({'likes': FieldValue.arrayUnion([uid])});
                                              }
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(width: 10,),
                                          Text('${likes.length}', style: kDescTextStyle.copyWith(fontSize: 18),),
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

                              pushNewScreen(context, screen: DetailScreen(data: meditationList[index], aspectRatio: 9/16,
                                primaryColor: Colors.black,
                                secondayColor: Colors.black87,
                                backgroundColr: Colors.white,
                                playButtonTextColour: nightColourCardColour,
                                playIconColor: nightColourCardColour,
                                buttonColor: meditationCardColour,
                                collectionNodeName: 'meditation',
                              ),
                                withNavBar: false,

                              );
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
            top: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: appBarTitleVisibility,
              child: Container(
                  color: Colors.white,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                          Navigator.pop(context);
                        }),
                        SizedBox(width: 20,),
                        Center(child: Text('${widget.category}',style: kSubTitleTextStyle,)),
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
  void getAllMeditation(){
    FirebaseFirestore.instance.collection('meditation').where('category', isEqualTo: widget.category).orderBy('timestamp', descending: true).snapshots().listen((snapshot) {
      if(snapshot != null){
        meditationList = snapshot.docs;
        print(meditationList);
        setState(() {});
      }

    });
  }



  void getUid()async {
    uid = await _helperFunction.getUid();
    setState(() {

    });
  }
}
