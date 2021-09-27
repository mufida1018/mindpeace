import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';

class LetsGetStarted extends StatelessWidget {
  final String name;

  const LetsGetStarted({Key key, this.name}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e6091),
      body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white.withOpacity(0.2), size: 20,),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },



                  ),
                ],
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 50),
                slidingBeginOffset: Offset(0, 2),
                child: Text('Hi ${name} !!', style: kTitleTextStyle.copyWith(color: Colors.white),),
                fadingDuration: Duration(milliseconds: 700),
                fadeIn: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  slidingBeginOffset: Offset(0, 2),
                  child: Text("So pleased to get to know you.",textAlign: TextAlign.center ,style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),),
                  fadingDuration: Duration(milliseconds: 700),
                  fadeIn: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  slidingBeginOffset: Offset(0, 2),
                  child: Text("Leave your mind peace to me. You just sit back and realx",textAlign: TextAlign.center ,style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),),
                  fadingDuration: Duration(milliseconds: 700),
                  fadeIn: true,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  slidingBeginOffset: Offset(0, 2),
                  child: customRoundButton(
                    color: Colors.white,
                    textColor: Color(0xff1e6091),
                    title: 'Get Started !',
                    onPressed: (){
                      
                    },
                  ),
                  fadingDuration: Duration(milliseconds: 700),
                  fadeIn: true,
                ),
              ),

            ],
          ),
      )
    );
  }
}
