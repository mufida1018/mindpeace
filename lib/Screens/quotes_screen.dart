import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Helper/quotes.dart';
import 'package:swipedetector/swipedetector.dart';


class QuotesScreen extends StatefulWidget {
  final int quoteNumber;

  const QuotesScreen({Key key, this.quoteNumber}) : super(key: key);
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  var unSplashApi = "https://api.unsplash.com/";
  var accessKey = "8yLmgvkrUyLpzuRAN-caTLHMZuU8yMuL_wzrw7Eh57k";
  var trial = "https://api.unsplash.com/photos/?client_id=YOUR_ACCESS_KEY";
  List imageList;
  HelperFunction _helperFunction = HelperFunction();
  var imageNumber = 0;
  var quoteNumber1;
  var trialNumber = 0;
  var blur = false;
  CarouselController buttonCarouselController = CarouselController();


  @override
  void initState() {
    // TODO: implement initState
    initNumber();
    super.initState();
    getImagesFromUnsplash();

  }

  void initNumber(){
    quoteNumber1 = widget.quoteNumber;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);
    return Scaffold(
      body: imageList != null ? Container(
        width: width,
        height: height,
        child: Stack(
          children: [
         AnimatedSwitcher(
           duration: Duration(seconds: 1),
           child: BlurHash(
             key: ValueKey(imageList[imageNumber]['blur_hash']),
             hash: imageList[imageNumber]['blur_hash'],
             duration: Duration(milliseconds: 1000),
             curve: Curves.easeInOut,
             image: imageList[imageNumber]['urls']['regular'],
             imageFit: BoxFit.cover,
           ),
         ),

            Container(
              width: width,
              height: height,
              color: Colors.black.withOpacity(0.4),
              child: CarouselSlider.builder(itemCount: quoteList.length, carouselController: buttonCarouselController,itemBuilder: (context, index1, index2){

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(quoteList[index1][kQuote], style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.95)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10,),
                        Text("- ${quoteList[index1][kAuthor]} -", style: kSubTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontStyle: FontStyle.italic, ),
                          textAlign: TextAlign.center,
                        ),
                      ]
                  ),
                );
              }, options: CarouselOptions(
                onPageChanged: (index, value){
                    HapticFeedback.lightImpact();
                    Random rand = Random();
                    imageNumber = rand.nextInt(imageList.length);
                  setState(() {

                  });
                },
                initialPage: quoteNumber1,
                pageSnapping: true,
                enlargeCenterPage: true,
                scrollDirection: Axis.vertical,
              )),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text("@${imageList[imageNumber]['user']['username']}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      onTap: (){
                          var profileUrl = imageList[imageNumber]['user']['links']['html'];
                        _helperFunction.launchInWebViewWithJavaScript(profileUrl);
                      },
                    ),
                    Text('  on  ',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        var unsplashUrl = 'https://unsplash.com';
                        _helperFunction.launchInWebViewWithJavaScript(unsplashUrl);
                      },
                      child: Text('Unsplash',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 20.0),
                    child: Text('@IntegratedThoughtsQuotes',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                  onTap: (){
                    var url = "https://t.me/IntegratedThoughtsQuotes";
                    _helperFunction.launchInWebViewWithJavaScript(url);
                  },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.5))),
                  ),
                ),
                onTap: (){
                  HapticFeedback.lightImpact();
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ): Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/quote_image1.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,

            ),
            child: Center(child: CircularProgressIndicator())
          ),
        ),
      )
    );
  }


  void getImagesFromUnsplash()async{
    var response = await http.get('https://api.unsplash.com/search/photos?per_page=30&query=forest&order_by=relevant&client_id=$accessKey');
    print(response.statusCode);
    if(response.statusCode == 200){
      var data = json.decode(response.body);
      print(data);
      imageList = data['results'];
      print(imageList[0]['user']['username']);
      setState(() {});
    }
  }
}
