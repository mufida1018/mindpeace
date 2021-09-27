import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mindpeace/Helper/constant.dart';

class DisplayBlogScreen extends StatefulWidget {
  final blogData;
  const DisplayBlogScreen({Key key, this.blogData}) : super(key: key);

  @override
  _DisplayBlogScreenState createState() => _DisplayBlogScreenState();
}

class _DisplayBlogScreenState extends State<DisplayBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.blogData['title'], style: kTitleTextStyle,),
                SizedBox(height: 10,),

                Text('Publication: Mind-Peace', style: kSubTitleTextStyle,),

                Text('Author: ${widget.blogData['author']}', style: kSubTitleTextStyle,),
                Text('Tags: ${widget.blogData['categories'].toString().replaceAll(']', '').replaceAll('[','')}', style: kSubTitleTextStyle,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 100, height: 1,color: Colors.black,),
                  ),
                ),

                Html(
                  shrinkWrap: true,
                  data: widget.blogData['description'],
                  onImageError: (exception, stackTrace) {
                    print(exception);
                  },
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
