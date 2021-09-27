import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Widget/custom_alert.dart';

class ShowJournalScreen extends StatefulWidget {
  final journalData;
  final int index;
  const ShowJournalScreen({Key key, this.journalData, this.index,}) : super(key: key);

  @override
  _ShowJournalScreenState createState() => _ShowJournalScreenState();
}

class _ShowJournalScreenState extends State<ShowJournalScreen> {
  
  HelperFunction _helperFunction = HelperFunction();
  
  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text('Daily Journal', style: kSubTitleTextStyle,),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: (){

            showDialog(
                context: context,
                builder: (BuildContext) {
                  return CustomAlert(
                    title: 'Delete Journal',
                    descriptions:
                    'Are you sure you want delete the journal !',
                    buttonPressed: ()  {
                      FirebaseFirestore.instance.collection('journal').doc(widget.journalData['id']).delete().then((value) {
                        _helperFunction.showToast(context: context, color: Colors.green, title: 'Journal note deleted');
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }).catchError((e){

                      });
                    },
                  );
                });
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Hero(
                tag: widget.index,
                child: Center(child: Image.asset(widget.journalData['imagePath'], width: 100, height: 100,))),
            Center(child: Text(widget.journalData['name'], style: kSubTitleTextStyle,)),
            SizedBox(height: 30,),
            Center(
              child: Container(
                width: width * 0.5,
                height: 2,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_helperFunction.getDateStamp(widget.journalData['timestamp']),style: kSubTitleTextStyle.copyWith(color: Colors.grey[400], fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_helperFunction.getWeekdayFromTimestamp(widget.journalData['timestamp']), style: kSubTitleTextStyle.copyWith(color: Colors.grey[400], fontSize: 15)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_helperFunction.getTimeStamp(widget.journalData['timestamp']),style: kSubTitleTextStyle.copyWith(color: Colors.grey[400], fontSize: 15)),
                  ),



                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left:20.0, top: 8, bottom: 10),
              child: Text(widget.journalData['title'], style: kTitleTextStyle.copyWith(fontSize: 20),),
            ),

            Padding(
              padding: const EdgeInsets.only(left:20.0, top: 5, bottom: 10, right: 20),
              child: Text(widget.journalData['message'], style: kDescTextStyle,),
            )
          ],
        ),
      ),
    );
  }


}
