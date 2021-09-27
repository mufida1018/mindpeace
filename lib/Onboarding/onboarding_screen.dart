import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Onboarding/asking_name_screen.dart';
import 'package:mindpeace/Screens/login_s.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  HelperFunction _helperFunction = HelperFunction();
  double _scale;
  AnimationController _controller;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);
    _scale = 1 - _controller.value;



    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(0xff1e6091),
        child: Column(
          children: [
            SizedBox(height: 50,),


            DelayedDisplay(
              delay: Duration(milliseconds: 50),
              slidingBeginOffset: Offset(0, 2),
              child: Text('Hi there !', style: kTitleTextStyle.copyWith(color: Colors.white),),
              fadingDuration: Duration(milliseconds: 700),
              fadeIn: true,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 300),
              slidingBeginOffset: Offset(0, 2),
              child: Text("I'm Mind Peace Guru",style: kTitleTextStyle.copyWith(color: Colors.white) ,),
              fadingDuration: Duration(milliseconds: 700),
              fadeIn: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DelayedDisplay(
                delay: Duration(milliseconds: 300),
                slidingBeginOffset: Offset(0, 2),
                child: Text("My task is to keep your \nmind calm and at peace",textAlign: TextAlign.center ,style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),),
                fadingDuration: Duration(milliseconds: 700),
                fadeIn: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DelayedDisplay(
                delay: Duration(milliseconds: 325),
                slidingBeginOffset: Offset(0, 2),
                child: Image.asset('images/mind_guru.png', height: height * 0.3, fit: BoxFit.fitHeight,),
                fadingDuration: Duration(seconds: 2),
                fadeIn: true,
              ),
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DelayedDisplay(
                delay: Duration(seconds: 1),
                slidingBeginOffset: Offset(0, 2),
                child: GestureDetector(
                  onTapDown: _tapDown,
                  onTapUp: _tapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: customRoundButton(
                      color: Colors.white,
                      textColor:  Color(0xff1e6091),
                      width: width * 0.7,
                      height: 70,
                      title: 'GET PEACE!',
                    ),
                  ),
                  onTap: (){
                    HapticFeedback.lightImpact();

                    Navigator.push(context, MaterialPageRoute(builder: (_) => AskingNameScreen()));
                  },
                ),
                fadingDuration: Duration(milliseconds: 700),
                fadeIn: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DelayedDisplay(
                delay: Duration(milliseconds: 1100),
                slidingBeginOffset: Offset(0, 2),
                child: GestureDetector(

                    onTap: (){
                      HapticFeedback.lightImpact();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginSc()));

                    },
                    child: Text('I already have a account'.toUpperCase(), style: kSubTitleTextStyle.copyWith( fontSize: 18,color: Colors.white.withOpacity(0.4)),)),
                fadingDuration: Duration(milliseconds: 700),
                fadeIn: true,
              ),
            ),

            SizedBox(height: 30,),

          ],
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

