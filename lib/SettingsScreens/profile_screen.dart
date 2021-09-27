import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Widget/ask_name_pop.dart';
import 'package:mindpeace/Widget/settings_row_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String screenTitle = 'Profile';
  HelperFunction _helperFunction = HelperFunction();
  TextEditingController nameController = TextEditingController();
  String name = '';

  var userData;

  @override
  void initState() {
    getUserProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context, name);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: userData != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                   
                      settings_row_2(
                        title: 'Name',
                        description: userData['name'],
                        width: width,
                        buttonTitle: 'EDIT',
                        onPressed: () {
                            showDialog(context: context, builder: (_) => AskNameDialogue(
                              title: 'What shall we call you ?',
                              nameController: nameController,
                              buttonPressed: (){
                                updateName();
                              },
                              descriptions: '',
                              cancelButton: (){
                                nameController.text == "";
                                Navigator.pop(context);
                              },

                            ));
                        },
                      ),
                      settings_row_2(
                        title: 'Email',
                        description: userData['email'],
                        width: width,
                        buttonTitle: '',
                        onPressed: () {},
                      ),
                      settings_row_2(
                        title: 'Is Premium',
                        description: userData['isPremium'].toString(),
                        width: width,
                        buttonTitle: '',
                        onPressed: () {},
                      ),
                      settings_row_2(
                        title: 'Joining Date',
                        description:
                            _helperFunction.getDateStamp(userData['timestamp']),
                        width: width,
                        buttonTitle: '',
                        onPressed: () {},
                      ),
                      settings_row_2(
                        title: 'Referral Code',
                        description: userData['referralCode'],
                        width: width,
                        buttonTitle: '',
                        onPressed: () {},
                      ),
                      settings_row_2(
                        title: 'Membership End Date',
                        description: userData['membershipEndDate'],
                        width: width,
                        buttonTitle: '',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void updateName()async{
    if(nameController.text != ''){
      var name = nameController.text.trim().substring(0,1).toUpperCase() + nameController.text.trim().substring(1,nameController.text.length);
      print(name);
      var uid = await _helperFunction.getUid();
      FirebaseFirestore.instance.collection('user').doc(uid).update({'name': name}).then((value)async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', name);


        Navigator.pop(context);

      }).catchError((e){
        Navigator.pop(context);

        _helperFunction.showToast(title: 'Error updating name, try again later', color: Colors.red, context: context);
      });
    }else{
      _helperFunction.showToast(title: 'Name cannot be blank', color: Colors.red, context: context);
    }

  }

  void getUserProfileDetails() async {
    var uid = await _helperFunction.getUid();
    FirebaseFirestore.instance.collection('user').doc(uid).snapshots().listen((event) {
      if (event != null) {
        userData = event.data();
        print(userData);
        name = userData['name'];
        setState(() {});
      }
    });
  }
}
