import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Onboarding/lets_get_started.dart';
import 'package:mindpeace/Screens/home_screen.dart';
import 'package:mindpeace/Screens/login_screen.dart';
import 'package:mindpeace/Screens/navbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskingNameScreen extends StatefulWidget {

  @override
  _AskingNameScreenState createState() => _AskingNameScreenState();
}

class _AskingNameScreenState extends State<AskingNameScreen> with SingleTickerProviderStateMixin {
  HelperFunction _helperFunction = HelperFunction();
  TextEditingController _nameController = TextEditingController();

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
    _nameController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);
    _scale = 1 - _controller.value;


    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color(0xff1e6091),
        body: SingleChildScrollView(
          child: SafeArea(
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('It was nice meet you. \nTo start our journey ahead, \nLets get to know each other. \nWhat shall I call you?', textAlign: TextAlign.center ,style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 18)),
                ),
                SizedBox(height: 70,),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width * 0.8,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue[900].withOpacity(0.2)
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            style: kTitleTextStyle.copyWith(color: Colors.white),
                            controller: _nameController,
                            autofocus: true,
                            cursorColor: Colors.white.withOpacity(0.5),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: 'Your Name ...',
                                hintStyle: kSubTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5)),
                            ),
                            onChanged: (value){
                              setState(() {

                              });
                            },

                          ),
                        ),
                        _nameController.text.length > 0 ?
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 30,
                            child: Center(child: Text(_nameController.text.length.toString(), style: kTitleTextStyle.copyWith(fontSize: 18 ,color: Colors.black87),)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 2, spreadRadius: 2)
                              ]
                            ),

                          ),
                        ): Container(),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTapDown: _tapDown,
                        onTapUp: _tapUp,
                        child: Transform.scale(
                          scale: _scale,
                          child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.blue[900].withOpacity(0.2), blurRadius: 2, spreadRadius: 2)
                            ],
                            color: _nameController.text.length > 0 ? Colors.white : Colors.blue[900].withOpacity(0.3),
                          ),
                            child: Center(
                              child: Icon(Icons.keyboard_arrow_right,
                                color: _nameController.text.length > 0 ? Colors.black87 : Colors.blue[900],
                              ),
                            ),

                          ),
                        ),
                        onTap: (){
                          _helperFunction.hideKeyboard(context);
                          _nameController.text.length > 0 ? saveNameToStorage() :
                              _helperFunction.showToast(
                                title: 'Please Enter Name', color: Colors.blue[900].withOpacity(0.3), context: context
                              );
                        },
                      ),
                    ]  
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: ()=>_helperFunction.hideKeyboard(context),
    );


  }
  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void saveNameToStorage()async{
    var name = _nameController.text.trim();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('userName', name);
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen(
      name: _nameController.text,
    )));
  }
}
