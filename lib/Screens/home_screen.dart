import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Helper/quotes.dart';
import 'package:mindpeace/Screens/detail_Screen.dart';
import 'package:mindpeace/Screens/mood_tracker_screen.dart';
import 'package:mindpeace/Screens/quotes_screen.dart';
import 'package:mindpeace/Screens/settings_screen.dart';
import 'package:mindpeace/Widget/custom_skeleton_widget.dart';
import 'package:mindpeace/Widget/home_screen_routine_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  bool appBarTitleVisibility = false;
  List morningRoutine = [];
  HelperFunction _helperFunction = HelperFunction();
  String name = 'Mind Peace';
  var randomNumber = 0;
  var quoteRandomeNumber = 0;
  var breathingRandomNumber = 0;
  var sleepRandomNumber = 0;
  var meditationRandomNumber = 0;
  var affirmationRandomNumber = 0;
  var sleepStoryRandomNumber = 0;
  var yogaMorningRandomNumbber = 0;
  var fromTheGuruRandomNumber = 0;

  String greet = '';

  var breathingData;
  var sleepingData;
  var meditationData;
  var affirmationData;
  var sleepStoryData;
  var yogaMorningData;
  var fromTheGuruData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getUserName();
      checkIfUserIsNew();
      getDaysGreetTime();
      getBreathing();
      getMeditationData();
      getAffirmationData();
      getYogaData();
      getFromTheGuruData();
      getSleepingData();
      getSleepingStoryData();
      getRandomNumber();

    }
  }


  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo){

                  if(scrollInfo.metrics.pixels  > scrollInfo.metrics.minScrollExtent + 0){
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

//                          IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
//                            Navigator.pop(context);
//                          }),

                          // SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left:16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$greet,", style: kTitleTextStyle.copyWith(color: Colors.grey, fontSize: 23),),
                                Text(name != null ? name : 'MindPeace Users', style: kTitleTextStyle.copyWith(color: Colors.black),),
                              ],
                            ),
                          ),

                          IconButton(icon: Icon(Icons.person_outline_outlined, color: Colors.black, size: 30,), onPressed: ()async{
                              var name1 = await  pushNewScreen(context, screen: SettingsScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.scale);
                              name = name1;
                              setState(() {

                              });
                          }),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:50.0, left: 20),
                        child: Text('Morning Routine', style: kSubTitleTextStyle,),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [

                            //TODO: Breathing ///////////////////////////////////////////
                            breathingData !=null ? HomeScreenRoutineWidget(width: width, widgetData: breathingData, onPressed: (){
                              pushNewScreen(context, screen: DetailScreen(
                                data: breathingData,
                                primaryColor: Colors.black,
                                secondayColor: Colors.black87,
                                backgroundColr: Colors.white,
                                playButtonTextColour: nightColourCardColour,
                                playIconColor: nightColourCardColour,
                                buttonColor: meditationCardColour,
                                collectionNodeName: 'breathing',
                              ), withNavBar: false);
                            },) :
                            CustomSkeletonLoader(width: width,),
                            //TODO: Todays Meditation /////////////////////////////////////

                            meditationData != null ? HomeScreenRoutineWidget(width: width, widgetData: meditationData, onPressed: (){
                              pushNewScreen(context, screen: DetailScreen(
                                  data: meditationData,
                                  primaryColor: Colors.black,
                                  secondayColor: Colors.black87,
                                  backgroundColr: Colors.white,
                                playButtonTextColour: nightColourCardColour,
                                playIconColor: nightColourCardColour,
                                  buttonColor: meditationCardColour,
                                collectionNodeName: 'meditation',
                              ), withNavBar: false);
                            }) :
                            CustomSkeletonLoader(width: width,),

                            // TODO: Affirmation Data
                            affirmationData != null ?
                            HomeScreenRoutineWidget(width: width, widgetData: affirmationData, onPressed: (){
                              pushNewScreen(context, screen: DetailScreen(
                                  data: affirmationData,
                                  primaryColor: Colors.black,
                                  secondayColor: Colors.black87,
                                  backgroundColr: Colors.white,
                                playButtonTextColour: nightColourCardColour,
                                playIconColor: nightColourCardColour,
                                  buttonColor: meditationCardColour,
                                collectionNodeName: 'meditation',
                              ), withNavBar: false);
                            }) :
                            CustomSkeletonLoader(width: width,),


                            //TODO: Yoga Morning Data

                            yogaMorningData != null ?
                            HomeScreenRoutineWidget(width: width, widgetData: yogaMorningData, onPressed: (){
                              pushNewScreen(context, screen: DetailScreen(
                                  data: yogaMorningData,
                                  primaryColor: Colors.black,
                                  secondayColor: Colors.black87,
                                  backgroundColr:Colors.white,
                                  playButtonTextColour: nightColourCardColour,
                                  playIconColor: nightColourCardColour,
                                  buttonColor: meditationCardColour,
                                  aspectRatio: 16/9,
                                collectionNodeName: 'yoga',
                              ), withNavBar: false);
                            }) :
                            CustomSkeletonLoader(width: width,)
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Text("From The Guru", style: kSubTitleTextStyle,),
                      ),
                      fromTheGuruData != null ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: HomeScreenRoutineWidget(width: width, widgetData: fromTheGuruData, onPressed: (){
                            pushNewScreen(context, screen: DetailScreen(
                              data: fromTheGuruData,
                              primaryColor: Colors.black,
                              secondayColor: Colors.black87,
                              backgroundColr: Colors.white,
                                playButtonTextColour: nightColourCardColour,
                                playIconColor: nightColourCardColour,
                                buttonColor: meditationCardColour,
                              collectionNodeName: 'teacher',
                              aspectRatio: fromTheGuruData['aspectRatio'] == '9/16' ? 9/16 : 16 /9
                            ), withNavBar: false);
                          }),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ): CustomSkeletonLoader(width: width,),




                      //TODO: Todays Quote///////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Text("Today's Quote", style: kSubTitleTextStyle,),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width,

                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaY: 5,
                                                sigmaX: 5
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(quoteList[randomNumber][kQuote], style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.95)),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text("- ${quoteList[randomNumber][kAuthor]} - ",style: kSubTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic, ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                              image: AssetImage('images/quote_image${1}.jpg',),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          pushNewScreen(context, screen: QuotesScreen(
                            quoteNumber: randomNumber,
                          ), withNavBar: false);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0, left: 20),
                        child: Text('Daily Journal', style: kSubTitleTextStyle,),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0, top: 10, bottom: 10),
                              child: Row(

                                children: [

                                  Container(
                                    width: width * 0.7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('How are you feeling today ?', style: kTitleTextStyle.copyWith(fontSize: 20),),
                                        SizedBox(height: 20,),
                                        Text('Write down in your daily journal the way your feeling', style: kDescTextStyle,),
                                        SizedBox(height: 20,),


                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ),
                        ),
                        onTap: (){
                          pushNewScreen(context, screen: MoodTrackerScreen(), withNavBar: false);
                        },
                      ),


                      //TODO: Sleep Data /////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top:10.0, left: 20),
                        child: Text('Sleep Routine', style: kSubTitleTextStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              sleepingData !=null ? HomeScreenRoutineWidget(width: width, widgetData: sleepingData, onPressed: (){
                                pushNewScreen(context, screen: DetailScreen(
                                  data: sleepingData,
                                  primaryColor: Colors.white,
                                  secondayColor: Colors.white70,
                                  backgroundColr: nightColour,
                                  playIconColor: nightColour,
                                  playButtonTextColour: nightColour,
                                  buttonColor: Colors.white,
                                  collectionNodeName: 'sleep',
                                ), withNavBar: false);
                              }) :

                              CustomSkeletonLoader(width: width,),

                              sleepStoryData !=null ? HomeScreenRoutineWidget(width: width, widgetData: sleepStoryData, onPressed: (){
                                pushNewScreen(context, screen: DetailScreen(
                                  data: sleepStoryData,
                                  primaryColor: Colors.white,
                                  secondayColor: Colors.white70,
                                  backgroundColr: nightColour,
                                  playIconColor: nightColour,
                                  playButtonTextColour: nightColour,
                                  buttonColor: Colors.white,
                                  collectionNodeName: 'sleep',
                                ), withNavBar: false);
                              }) :
                              CustomSkeletonLoader(width: width,)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                    ],
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
                      padding: const EdgeInsets.only(left:20.0, top: 30),
                      child: Row(
                        children: [
                          Text('$greet,', style: kTitleTextStyle.copyWith(color: Colors.grey, fontSize: 18),),
                          SizedBox(width: 10,),
                          Text(name != null ? name : 'MindPeace Users', style: kTitleTextStyle.copyWith(fontSize: 18),),

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

  void checkIfUserIsNew()async{
    var pushId = "";
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var user = await FirebaseAuth.instance.currentUser;
    var uid = user.uid;
    FirebaseFirestore.instance.collection('user').where('email', isEqualTo: user.email).get().then((datasnapshot){
      if(datasnapshot.docs.length == 0){
        var userData  = {
          'name' : name,
          'email': user.email,
          'phoneNumber': '',
          'profilePhotoUrl': '',
          'uid': uid,
          'pushId': pushId,
          'isPremium': false,
          'membershipEndDate': '',
          'timestamp': timestamp,
          'referralCode': '',
          'referralUsed': false,
        };
        
        FirebaseFirestore.instance.collection('user').doc(uid).set(userData).then((value){

        }).catchError((e){
          _helperFunction.showToast(context: context, color: Colors.red, title: 'Failed to add data to database');
        });
      }else{

      }
    });

  }


  void saveUid(String uid)async{

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('uid', uid);
  }
  void getUserName()async{
    name = await _helperFunction.getUserName();
    print("The name of the user is $name");
    setState(() {});
  }

  void getRandomNumber() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');

    if(todayDate == dataFromSharedPreference){
      randomNumber = _pref.getInt('randomNumber') ?? 0;
      print("random Number $randomNumber");
      quoteRandomeNumber = _pref.getInt('quoteRandomeNumber') ?? 1;
      setState(() {});
    }else{
      _pref.setString('todaysDate', todayDate);
      var lenght = quoteList.length;
      Random rand = Random();
      randomNumber = rand.nextInt(lenght);
      quoteRandomeNumber = rand.nextInt(5) + 1;

      setState(() {});
      _pref.setInt("randomNumber", randomNumber);
      _pref.setInt('quoteRandomeNumber', quoteRandomeNumber);
      setState(() {});

    }


  }

  void getDaysGreetTime(){
    var time = DateTime.now().toString().substring(11,13);
    int intTime = int.parse(time);
    print(intTime);
    if(intTime > 4 && intTime < 12){
      greet = 'Good Morning';
    }else if(intTime >= 12 && intTime <=17 ){
      greet = "Good Afternoon";
    }else if(intTime > 17 && intTime <= 21){
      greet = "Good Evening";
    }else if(intTime > 21 && intTime <= 24){
      greet = 'Good Night';
    }
    setState(() {});

  }

  void getBreathing()async {

    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');

    if(todayDate == dataFromSharedPreference){
      breathingRandomNumber = _pref.getInt('breathingRandomNumber') ?? 0;
      print("Breathing random Number $breathingRandomNumber");
      FirebaseFirestore.instance.collection('breathing').get().then((value){
        if(value != null){
          var data = value.docs;
          breathingData = data[breathingRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting morning routine', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('breathing').get().then((value){
        if(value != null){
          var data = value.docs;
          int breathingLenght = data.length;
          print("$breathingLenght breathing length");
          Random rand = Random();
          breathingRandomNumber = rand.nextInt(breathingLenght);
          print("Breathing random Number $breathingRandomNumber");

          _pref.setInt("breathingRandomNumber", breathingRandomNumber);
          breathingData = data[breathingRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting morning routine', context);
      });
    }
    // print(" Breathing Data ${breathingData['title']}");
  }

  void getSleepingData()async {

    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');

    if(todayDate == dataFromSharedPreference){

      sleepRandomNumber = _pref.getInt('sleepRandomNumber') ?? 0;
      FirebaseFirestore.instance.collection('sleep').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Sound Peace').get().then((value){
        if(value != null){
          var data = value.docs;
          sleepingData = data[sleepRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting morning routine', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('sleep').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Sound Peace').get().then((value){
        if(value != null){
          var data = value.docs;
          var sleepingLenght = data.length;
          Random rand = Random();
          sleepRandomNumber = rand.nextInt(sleepingLenght);
          _pref.setInt("sleepRandomNumber", sleepRandomNumber);
          sleepingData = data[sleepRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting morning routine', context);
      });
    }
  }

  void getMeditationData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');


    if(todayDate == dataFromSharedPreference){
      meditationRandomNumber = _pref.getInt('meditationRandomNumber') ?? 0;
      FirebaseFirestore.instance.collection('meditation').where('isFree', isEqualTo: true).where('category', isEqualTo: 'General').get().then((value){
        if(value != null){
          var data = value.docs;

          meditationData = data[meditationRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Meditation Data', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('meditation').where('isFree', isEqualTo: true).where('category', isEqualTo: 'General').get().then((value){
        if(value != null){
          var data = value.docs;
          var meditationLength = data.length;
          Random rand = Random();
          meditationRandomNumber = rand.nextInt(meditationLength);
          _pref.setInt("meditationRandomNumber", meditationRandomNumber);
          meditationData = data[meditationRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Meditation Data', context);
      });
    }
  }

  void getAffirmationData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');


    if(todayDate == dataFromSharedPreference){
      affirmationRandomNumber = _pref.getInt('affirmationRandomNumber') ?? 0;
      FirebaseFirestore.instance.collection('meditation').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Affirmation').get().then((value){
        if(value != null){
          var data = value.docs;

          affirmationData = data[affirmationRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Affirmation Data', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('meditation').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Affirmation').get().then((value){
        print(value.docs);

        if(value != null){
          var data = value.docs;
          var meditationLength = data.length;
          Random rand = Random();
          affirmationRandomNumber = rand.nextInt(meditationLength);
          _pref.setInt("affirmationRandomNumber", affirmationRandomNumber);
          affirmationData = data[affirmationRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Affirmation Data', context);
      });
    }
  }




  void getYogaData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');


    if(todayDate == dataFromSharedPreference){
      yogaMorningRandomNumbber = _pref.getInt('yogaMorningRandomNumbber') ?? 0;
      FirebaseFirestore.instance.collection('yoga').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Morning').get().then((value){
        if(value != null){
          var data = value.docs;

          yogaMorningData = data[yogaMorningRandomNumbber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Affirmation Data', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('yoga').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Morning').get().then((value){
        print(value.docs);

        if(value != null){
          var data = value.docs;
          var meditationLength = data.length;
          Random rand = Random();
          yogaMorningRandomNumbber = rand.nextInt(meditationLength);
          _pref.setInt("yogaMorningRandomNumbber", yogaMorningRandomNumbber);
          yogaMorningData = data[yogaMorningRandomNumbber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Affirmation Data', context);
      });
    }
  }


  void getFromTheGuruData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');


    if(todayDate == dataFromSharedPreference){
      fromTheGuruRandomNumber = _pref.getInt('fromTheGuruRandomNumber') ?? 0;
      FirebaseFirestore.instance.collection('teacher').where('isFree', isEqualTo: true).get().then((value){
        if(value != null){
          var data = value.docs;

          fromTheGuruData = data[fromTheGuruRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting From the guru Data', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('teacher').where('isFree', isEqualTo: true).get().then((value){

        if(value != null){
          var data = value.docs;
          var meditationLength = data.length;
          Random rand = Random();
          fromTheGuruRandomNumber = rand.nextInt(meditationLength);
          _pref.setInt("fromTheGuruRandomNumber", fromTheGuruRandomNumber);
          fromTheGuruData = data[fromTheGuruRandomNumber];

          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting from the guru Data', context);
      });
    }
  }






  void getSleepingStoryData()async {

    SharedPreferences _pref = await SharedPreferences.getInstance();
    var todayDate = DateTime.now().toString().substring(0,10);
    String dataFromSharedPreference = _pref.getString('todaysDate');

    if(todayDate == dataFromSharedPreference){
      sleepStoryRandomNumber = _pref.getInt('sleepStoryRandomNumber') ?? 0;
      FirebaseFirestore.instance.collection('sleep').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Sleep Story').get().then((value){
        if(value != null){
          var data = value.docs;
          sleepStoryData = data[sleepStoryRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Sleep Story routine', context);
      });
      setState(() {});
    }else{
      FirebaseFirestore.instance.collection('sleep').where('isFree', isEqualTo: true).where('category', isEqualTo: 'Sleep Story').get().then((value){
        if(value != null){
          var data = value.docs;
          var sleepingLenght = data.length;
          Random rand = Random();
          sleepStoryRandomNumber = rand.nextInt(sleepingLenght);
          _pref.setInt("sleepStoryRandomNumber", sleepStoryRandomNumber);
          sleepStoryData = data[sleepStoryRandomNumber];
          setState(() {});
        }
      }).catchError((e){
        Toast.show('Error getting Sleep Story routine', context);
      });
    }
  }




}



