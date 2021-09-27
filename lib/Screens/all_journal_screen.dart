import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/show_journal_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AllJournalScreen extends StatefulWidget {
  const AllJournalScreen({Key key}) : super(key: key);

  @override
  _AllJournalScreenState createState() => _AllJournalScreenState();
}

class _AllJournalScreenState extends State<AllJournalScreen> {


  HelperFunction _helperFunction = HelperFunction();
  List allJournalList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getAllJournalsData();
    }

  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Journal', style: kSubTitleTextStyle,),
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           allJournalList != null ? Container(
             height: height - 60,
             child: ListView.builder(
               shrinkWrap: true,
                itemCount: allJournalList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                  tag: allJournalList[index]['id'],
                                  child: Image.asset(allJournalList[index]['imagePath'], width: 60, height: 60,)),
                              SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: width - 110,
                                      child: Text(allJournalList[index]['title'], style: kTitleTextStyle.copyWith(fontSize: 18),)),
                                  Text(allJournalList[index]['message'].toString().length > 40 ? allJournalList[index]['message'].toString().substring(0,39)+" ...":allJournalList[index]['message'].toString()),
                                  SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      Text(allJournalList[index]['name'], style: TextStyle(color: Colors.deepOrangeAccent),),
                                      SizedBox(width: 10,),

                                      Text(_helperFunction.getTimeStamp(allJournalList[index]['timestamp']), style: kDescTextStyle.copyWith(color: Colors.black.withOpacity(0.5)),),
                                      SizedBox(width: 10,),
                                      Text(_helperFunction.getDateStamp(allJournalList[index]['timestamp']),style: kDescTextStyle.copyWith(color: Colors.black.withOpacity(0.5))),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      pushNewScreen(context, screen: ShowJournalScreen(journalData: allJournalList[index],index: index,), withNavBar: false);
                    },
                  );
                },
              ),
           ) : Center(
             child: CircularProgressIndicator(),
           )
          ],
        ),
      ),
    );
  }

  void getAllJournalsData()async{
    var uid = await _helperFunction.getUid();
    
    FirebaseFirestore.instance.collection('journal').where('userUid', isEqualTo: uid).orderBy('timestamp', descending: true).snapshots().listen((value){
      if(value != null){
        allJournalList = value.docs;
        setState(() {});
      }
    });

  }
}
