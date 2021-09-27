import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Widget/back_button.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uuid/uuid.dart';

class DailyJournalScreen extends StatefulWidget {
  
  final String feelingName;
  final String feelingImage;
  
  
  const DailyJournalScreen({Key key, this.feelingName, this.feelingImage}) : super(key: key);

  @override
  _DailyJournalScreenState createState() => _DailyJournalScreenState();
}

class _DailyJournalScreenState extends State<DailyJournalScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();




  HelperFunction _helperFunction = HelperFunction();

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);
    return GestureDetector(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Daily Journal', style: kSubTitleTextStyle,),
            centerTitle: false,
            iconTheme: IconThemeData(
              color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                            style: kSubTitleTextStyle,
                            children: [
                              TextSpan(text: 'What made you feel '),
                              TextSpan(text: widget.feelingName + " !",
                                  style: kSubTitleTextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ]
                        ),
                      ),
                      SizedBox(width: 10,),
                      Image.asset(widget.feelingImage, width: 30, height: 30,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 10, bottom: 10),
                  child: Stack(
                    children: [
                      TextField(
                        controller: titleController,
                        style: kSubTitleTextStyle.copyWith(color: Colors.black),
                        cursorColor: Colors.black.withOpacity(0.5),
                        autofocus: true,
                        maxLength: 40,
                        decoration: InputDecoration(
                            hintText: 'Reason in short',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,
                                  color: Colors.black.withOpacity(0.5),
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,
                                  color: Colors.black.withOpacity(0.5),
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10)),
                            ),
                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,

                            errorBorder: InputBorder.none,
                            fillColor: Colors.grey[100],
                            filled: true
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      Positioned(
                        bottom: -10,
                        right: 0,
                        child: Container(
                          width: 60,
                          height: 40,
                          child: Center(child: Text(titleController.text.length
                              .toString() + '/40',
                            style: kTitleTextStyle.copyWith(
                                fontSize: 18, color: Colors.black87),)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 2,
                                    spreadRadius: 2)
                              ]
                          ),

                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Journal', style: kSubTitleTextStyle,),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 10),
                  child: Stack(
                      children: [
                        TextField(
                          controller: messageController,
                          maxLines: 10,
                          style: kDescTextStyle,
                          cursorColor: Colors.black.withOpacity(0.5),
                          decoration: InputDecoration(
                              hintText: 'Add some notes ...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1,
                                    color: Colors.black.withOpacity(0.5),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1,
                                    color: Colors.black.withOpacity(0.5),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10)),
                              ),
                              errorBorder: InputBorder.none,
                              fillColor: Colors.grey[100],
                              filled: true
                          ),
                          onChanged: (value) {
                            setState(() {

                            });
                          },
                        ),
                        Positioned(
                          bottom: -5,
                          right: 0,
                          child: Container(
                            width: 60,
                            height: 40,
                            child: Center(child: Text(messageController.text
                                .length.toString(),
                              style: kTitleTextStyle.copyWith(
                                  fontSize: 18, color: Colors.black87),)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 2,
                                      spreadRadius: 2)
                                ]
                            ),

                          ),
                        )
                      ]
                  ),
                ),
                SizedBox(height: 100,),
                // Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: customRoundButton(
                      width: width * 0.8,
                      title: 'Add',
                      color: Colors.yellow[200],
                      textColor: nightColour,
                      onPressed: () {
                        if (titleController.text != "" &&
                            messageController.text != "") {
                          _helperFunction.hideKeyboard(context);
                          addNoteTodatabase();
                        } else {
                          _helperFunction.showToast(color: Colors.red,
                              title: 'All Fields are compulsory',
                              context: context);
                        }
                      },
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
        onTap: () {
          _helperFunction.hideKeyboard(context);
        }


    );
  }

  void addNoteTodatabase()async{
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var uid = await _helperFunction.getUid();
    var uuid = Uuid().v1().toString();

    var noteDatabase = {
      'title': titleController.text,
      'message': messageController.text,
      'timestamp': timestamp,
      'name' : widget.feelingName,
      'imagePath': widget.feelingImage,
      'userUid' : uid,
      'id': uuid,
    };

    FirebaseFirestore.instance.collection('journal').doc(uuid).set(noteDatabase).then((value){

     titleController.text = "";
     messageController.text = "";
     setState(() {});
     _helperFunction.showToast(context: context, color: Colors.green, title: 'Daily journal added successful');

    }).catchError((e){
      print('$e');
      _helperFunction.showToast(context: context, color: Colors.red, title: '$e');
    });
  }
}
