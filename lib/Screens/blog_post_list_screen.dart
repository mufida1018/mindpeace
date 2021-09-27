import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/display_blog_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BlogPostListScreen extends StatefulWidget {
  final String category;
  final String title;
  const BlogPostListScreen({Key key, this.category, this.title}) : super(key: key);

  @override
  _BlogPostListScreenState createState() => _BlogPostListScreenState();
}

class _BlogPostListScreenState extends State<BlogPostListScreen> {

  HelperFunction _helperFunction = HelperFunction();
  List blogList;



  @override
  void initState() {
    super.initState();
    if(mounted){
      // blogList

      getblogList();
    }
  }

  void getblogList() async {
    blogList = await _helperFunction.getBlogsData(widget.category);
    setState(() {
    });
    print(blogList);
  }




  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);


    return Scaffold(
            appBar: AppBar(
              title: Text(widget.title, style: kTitleTextStyle,),
              centerTitle: false,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
      body:blogList == null ? Center(child: CircularProgressIndicator()) : blogList.length > 0 ?  ListView.builder(
        itemCount: blogList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CachedNetworkImage(imageUrl: blogList[index]['thumbnail'],width: 100, height: 100, fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(placeholder_image),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: width -150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(blogList[index]['title'], style: kTitleTextStyle.copyWith(fontSize: 18),),
                            Text("Author:  ${blogList[index]['author']}", style: kSubTitleTextStyle.copyWith(fontSize: 14),),
                            Text("Tags:  ${blogList[index]['categories']}".toString().replaceAll('[', '').replaceAll(']', '').trim()),


                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              onTap: (){
                pushNewScreen(context, screen: DisplayBlogScreen(blogData: blogList[index]), withNavBar: false);
              },
            ),
          );
        },
      ) : Center(
        child: Text('No Blogs / Tips found')
      )
    );
  }
}
