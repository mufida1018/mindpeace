import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/all_journal_screen.dart';
import 'package:mindpeace/Screens/daily_journal_screen.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key key}) : super(key: key);

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {


  HelperFunction _helperFunction = HelperFunction();
  Color selectedColor = Colors.white;
  int selectedIndex ;
  bool isButtonVisible = false;


  @override
  Widget build(BuildContext context) {
    var heigh = _helperFunction.getHeight(context);
    var width = _helperFunction.getWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Container(
              height: heigh,

              child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BackButton(),
                      ),
                      Text('How are you feeling today ?', style: kTitleTextStyle.copyWith(fontSize: 20),),
                    ],
                  ),

                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (2 / 2.5)
                  ),
                      itemCount: feelings.length,
                      itemBuilder: (context, index){
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: selectedIndex == index ? Colors.yellow[200] : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(feelings[index][feelingImage], width: 75, height: 75,),
                                  SizedBox(height: 5,),
                                  Text(feelings[index][feelingName]),
                                ],
                              ),
                            )

                          ),
                        ),
                        onTap: (){
                          selectedIndex = index;
                          isButtonVisible = true;
                          setState(() {

                          });
                        },
                      );
                      }),

                ],

              ),
          ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90.0),
                child: customRoundButton(
                  width: width * 0.8,
                  title: 'Add New Entry',
                  color: Colors.yellow[200],
                  textColor: nightColour,
                  onPressed: (){
                    if(isButtonVisible){
                      pushNewScreen(context, screen: DailyJournalScreen(
                        feelingImage: feelings[selectedIndex][feelingImage],
                        feelingName: feelings[selectedIndex][feelingName],

                      ),withNavBar: false);
                    }else{
                      _helperFunction.showToast(title: 'Choose how you are feeling', color: Colors.red, context: context);
                    }

                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: customRoundButton(
                  width: width * 0.8,
                  title: 'All Journals',
                  color: Colors.yellow[200],
                  textColor: nightColour,
                  onPressed: (){
                    pushNewScreen(context, screen: AllJournalScreen(), withNavBar: false);
                  },
                ),
              ),
            ),
        ]
        ),
      ),
    );
  }
}
