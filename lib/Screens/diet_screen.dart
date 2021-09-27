import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:mindpeace/Screens/blog_post_list_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class DietScreen extends StatefulWidget {
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {

  HelperFunction _helperFunction = HelperFunction();

  // var mediumPostLink = "https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@shreebhagwat94";
  // var mindPeaceToken = "21a65705e316999c2c6260f7d5c202a3cb62be8e50eee84a79bd1acba0a08e7fe";
  // var mediumId = '1c67b51a7bbc3afb9e8f15ccaaa002a16357288a9288b1f681c6be42fe25eba7f';
  // var mediumHeader = {
  //   "Accept":   "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
  //   "Accept-Encoding"   :"gzip, deflate, br",
  //   "Accept-Language"   :"en-US,en;q=0.5",
  //   "Connection"    :"keep-alive",
  //   "Host"  :"api.medium.com",
  //   "TE"    :"Trailers",
  //   "Upgrade-Insecure-Requests":    "1",
  //   "User-Agent":   "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0"
  // };
  // var mindPeacePublicationId = 'c672a8017577';
  // var codeaamyPublicationId = '8b729901d69f';


  List blogsCategoryList;
  String content;
  String title;
  String author;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      getBlogsCategory();
    }
  }

  @override
  Widget build(BuildContext context) {

    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                child: Center(child: Lottie.asset('lottie/blogs_tips.json', height: 250, fit: BoxFit.fitHeight)),
              ),


              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Tips and Blogs', style: kTitleTextStyle,),
              ),

              blogsCategoryList != null ?
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: blogsCategoryList.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      child: Container(
                        width: width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Container(
                                  width: width * 0.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(blogsCategoryList[index]['name'], style: kSubTitleTextStyle),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(blogsCategoryList[index]['description'],),

                                    ],
                                  ),
                                ),
                              ),
                              SvgPicture.asset('svg/${blogsCategoryList[index]['imageLink']}.svg',width: width * 0.25, fit: BoxFit.fitWidth,),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: meditationCardColour,

                        ),
                      ),
                      onTap: (){
                        pushNewScreen(context, screen: BlogPostListScreen(category: '${blogsCategoryList[index]['category']}', title: '${blogsCategoryList[index]['name']}'),withNavBar: false);
                      },
                    ),
                  );
                },
              ): Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
      ),
    );

  }


  // void getMediumPost()async {
  //   var response = await http.get('https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@shreebhagwat94');
  //   print(response.statusCode);
  //   if(response.statusCode == 200){
  //     var data = json.decode(response.body);
  //
  //     // content = data['items'][1]['description'];
  //     // title = data['items'][1]['title'];
  //     // author = data['items'][1]['author'];
  //     postList = data['items'];
  //     setState(() {});
  //   }
  // }

  void getBlogsCategory(){
    FirebaseFirestore.instance.collection('blogs_tips_category').orderBy('num', descending: false).snapshots().listen((event) {
      if(event != null){
        blogsCategoryList = event.docs;
        print(blogsCategoryList.length);
        setState(() {});
      }
    });
  }
}
