import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class HelperFunction {

  double getWidth(BuildContext context){
    var widht = MediaQuery.of(context).size.width;
    return widht;
  }

  double getHeight(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    return height;
  }

  String getTimeStamp(String timeStamp){
    var stamp = int.parse(timeStamp);
    var date = DateTime.fromMillisecondsSinceEpoch(stamp);
    var timeFormat = DateFormat("h:mm aa").format(date);
    return timeFormat.toString();
  }

  String getDateStamp(String timeStamp){
    var stamp = int.parse(timeStamp);
    var date = DateTime.fromMillisecondsSinceEpoch(stamp);
    var dateFormat = DateFormat('dd-MM-yyyy').format(date);
    return dateFormat.toString();
  }

  String getWeekdayFromTimestamp(String timestamp){
    var stamp = int.parse(timestamp);
    var date = DateTime.fromMillisecondsSinceEpoch(stamp);
    var dateFormat = DateFormat('EEEE').format(date);
    return dateFormat.toString();
  }

  void showToast({BuildContext context, Color color, String title}) {
    Toast.show(title, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: color);
  }

  Future<bool> isConnectedToInternet(BuildContext context) async {
    var connectivtyResult = await (Connectivity().checkConnectivity());
    if(connectivtyResult == ConnectivityResult.mobile){
      return true;
    }else if(connectivtyResult == ConnectivityResult.wifi){
      return true;
    }else if(connectivtyResult == ConnectivityResult.none){
      showToast(color: Colors.red, context: context, title: 'No internet Connection !!!');
      return false;
    }
  }

  void hideKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }


  Future <String> getUid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = await prefs.getString('uid');
    if(uid != null){
      return uid;
    }else{
      var uid1 = FirebaseAuth.instance.currentUser.uid;
      prefs.setString('uid', uid1);
      return uid1;
    }

  }

  Future<String> getUserName()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name;
    var sName = prefs.getString('userName')??"";

    if(sName == null || sName == ""){
      print('inside the if block where name = null and name is blank');
      var uid = await getUid();
      await FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
        print('inside firebase then block');
        if(value != null){
          var data = value.data();
          var fName = data['name'];
          print('Printing name from firebase $fName');
          name = fName;
        }
      });
      prefs.setString('userName', name);
      return name;
    }else{
      print('Where the name is from shared pref');

      return sName;
    }
  }
  Future<String> getUserEmail()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email;
    var sEmail = prefs.getString('userEmail')??"";
    if(sEmail == null || sEmail == ""){
      var uid = await getUid();
     await FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
        if(value != null){
          var data = value.data();
          var fEmail = data['email'];
          email = fEmail;
        }
      });
      prefs.setString('userEmail', email);
      return email;
    }else{
      return sEmail;
    }
  }

  Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List> getBlogsData(String categories) async {
    var newList = [];
    var response = await http.get('https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@shreebhagwat94');
    print(response.statusCode);
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      List items = data['items'];
      for(var i = 0; i < items.length; i++){
        if(items[i]['categories'].contains(categories)){
          newList.add(items[i]);
        }

      }
    }
    return newList;
  }





}