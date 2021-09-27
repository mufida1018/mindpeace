import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';

class AskNameDialogue extends StatelessWidget {
  final String title, descriptions, text;
  final String imagePath;
  final Function buttonPressed;
  final Function cancelButton;
  final TextEditingController nameController;
  final String uid;



  AskNameDialogue({Key key, this.title, this.descriptions, this.text, this.imagePath, this.buttonPressed, this.cancelButton, this.nameController, this.uid}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    HelperFunction _helperFunction = HelperFunction();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialoguePadding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: dialoguePadding,top: dialogueAvatarRadius
                  + dialoguePadding, right: dialoguePadding,bottom: dialoguePadding
              ),
              margin: EdgeInsets.only(top: dialogueAvatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(dialoguePadding),
                  boxShadow: [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                        blurRadius: 10
                    ),
                  ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(title,style: kSubTitleTextStyle.copyWith(fontSize: 20),),
                  SizedBox(height: 15,),
                  Text(descriptions,style: TextStyle(fontSize: 14),),
                  SizedBox(height: 22,),
                  TextField(
                    controller: nameController,
                    style: kSubTitleTextStyle,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Name",
                      hintStyle: kSubTitleTextStyle,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      focusColor: kPrimaryColour,
                    ),
                    onSubmitted: (value){
                      print(value);
                    },

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('Cancel', style: kSubTitleTextStyle,),
                          ),
                          onTap: cancelButton
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Save', style: kSubTitleTextStyle,),
                        ),
                        onTap: buttonPressed
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: dialoguePadding,
              right: dialoguePadding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: dialogueAvatarRadius,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(dialogueAvatarRadius)),
                    child: Lottie.asset('lottie/brain.json')
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }

}