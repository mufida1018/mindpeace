import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Widget/back_button.dart';
//import 'package:video_player/video_player.dart';


class PlayMeditationScreen extends StatefulWidget {

  final data;
  final Color primaryColor;
  final Color secondayColor;
  final double aspectRation;
  final bool showFullScreen;




  const PlayMeditationScreen({Key key, this.data, this.primaryColor, this.secondayColor, this.aspectRation, this.showFullScreen}) : super(key: key);
  @override
  _PlayMeditationScreenState createState() => _PlayMeditationScreenState();
}

class _PlayMeditationScreenState extends State<PlayMeditationScreen> {



  var randNumber = 0;
  bool showLoader = true;

//  VideoPlayerController _controller;
  bool looping = false;
//  ChewieController  chewieController;
  BetterPlayerController _betterPlayerController;

  bool isPlaying = false;
  LoopMode isLoop = LoopMode.none;
  AssetsAudioPlayer _player = AssetsAudioPlayer();

  HelperFunction _helperFunction = HelperFunction();
  var audioDurationValue = 0.0;

  List relatedList = [];
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;



  @override
  void initState() {
    // TODO: implement initState
    print('${widget.data['videoLink']}');

    // getRandomNumber();


    if(widget.data['videoLink'] == ""){
      initPlayer();


    }else{
//      _controller = VideoPlayerController.network(widget.data['videoLink']);
//      chewieController = ChewieController(
//        allowedScreenSleep: false,
//        allowFullScreen: true,
//        autoInitialize: true,
//        autoPlay: true,
//        showControls: true,
//        videoPlayerController: _controller,
//        aspectRatio: 9/16,
//        deviceOrientationsAfterFullScreen: [
//          DeviceOrientation.portraitUp,
//        ],
//      );
//      chewieController.addListener(() {
//        if (chewieController.isFullScreen) {
//          SystemChrome.setPreferredOrientations([
//            DeviceOrientation.portraitUp,
//          ]);
//        }else{
//          SystemChrome.setPreferredOrientations([
//            DeviceOrientation.portraitDown,
//            DeviceOrientation.portraitUp,
//          ]);
//        }
//      });

      BetterPlayerDataSource _betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          '${widget.data['videoLink']}',
      );


      _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            aspectRatio: widget.aspectRation,
            handleLifecycle: true,
            allowedScreenSleep: false,
            autoPlay: true,
            deviceOrientationsOnFullScreen: [
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,

            ],

          fullScreenByDefault: false,
          fullScreenAspectRatio: 9/16,
          deviceOrientationsAfterFullScreen: [
            DeviceOrientation.portraitUp,
            // DeviceOrientation.landscapeRight,
            // DeviceOrientation.landscapeLeft,
            ]
          ),
          betterPlayerDataSource: _betterPlayerDataSource);
    }
    
    if(mounted){
      // getMeditationList();

    }
    super.initState();



  }


  initPlayer(){
    advancedPlayer = new AudioPlayer();
    advancedPlayer.setUrl(widget.data['audioLink']).whenComplete((){
//      advancedPlayer.resume();
      setState(() {
        showLoader = false;
//        isPlaying = true;
      });
    });
    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });

  advancedPlayer.onPlayerCompletion.listen((event) {
      advancedPlayer.seek(Duration(seconds: 0));
      advancedPlayer.pause();
      isPlaying = false;
      setState(() {

      });
  });
  setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.data['videoLink'] != "" ? _playVideo(context) : AudioServiceWidget(child: _playAudio(BuildContext)),
    );
  }

  Widget _playVideo (BuildContext context){
    return Stack(
        children:[
//          Chewie(
//            controller: chewieController,
//          ),
          BetterPlayer(

            controller: _betterPlayerController,

          ),

          Positioned(
            right: 5,
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black54,
              ),
              child: Center(
                child: IconButton(icon: FaIcon(FontAwesomeIcons.times, color: Colors.white70, size: 18,), onPressed: (){
                  Navigator.pop(context);
                }),
              ),
            ),
          )
        ]
    );
  }

  Widget _playAudio(BuildContext){
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);
    var current = _player.current.value;


      return Stack(

        children: [

          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider('${widget.data['imageLink']}'),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: Container(
                height: 250,
                width: width * 0.99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.4),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(child: Text(widget.data['title'], style: kTitleTextStyle.copyWith(color: Colors.white),)),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          IconButton(icon: Icon(CupertinoIcons.gobackward_10, color: widget.primaryColor,size: 35,), onPressed: (){
                            HapticFeedback.lightImpact();

                            advancedPlayer.seek(_position - Duration(seconds: 10));
                            setState(() {

                            });

                          }),

                          showLoader ? Container(width: 50, height: 50, child: SpinKitCircle(color: Colors.white,),):
                          isPlaying ? Padding(
                            padding: const EdgeInsets.only(left:8.0, right: 8.0),
                            child: IconButton(
                              icon: Icon(CupertinoIcons.pause_solid, color: widget.primaryColor, size: 35,),
                              onPressed: (){
                                HapticFeedback.lightImpact();

                                advancedPlayer.pause();
                                isPlaying = false;

                                setState(() {});
                              },

                            ),
                          ) : Padding(
                            padding: const EdgeInsets.only(left:8.0, right: 8.0),
                            child: IconButton(
                              icon: Icon(CupertinoIcons.play_arrow_solid, color: widget.primaryColor, size: 35,),
                              onPressed: (){
                                HapticFeedback.lightImpact();
                                advancedPlayer.resume();
                                isPlaying = true;
                                setState(() {});
                              },

                            ),
                          ),
                          IconButton(icon: Icon(CupertinoIcons.goforward_10,color: widget.primaryColor ,size: 35,), onPressed: (){
                            advancedPlayer.seek(_position + Duration(seconds: 10));

                            HapticFeedback.lightImpact();
                            setState(() {});
                          }),
                        ],
                      ),
                    ),


                        Padding(
                          padding: const EdgeInsets.only(left:8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Container(
                                width: width * 0.1,
                                  child: Text('${_position.inMinutes}:${_position.inSeconds % 60}', style: kDescTextStyle.copyWith(color: widget.primaryColor),),

                              ),

                              Container(
                                width: width * 0.7,
                                child: Slider(
                                  min: 0.0,
                                  max: _duration.inSeconds.toDouble(),
                                  value: _position.inSeconds.toDouble(),
                                  activeColor: widget.primaryColor,
                                   inactiveColor: widget.secondayColor,
                                  onChanged: (value){
                                    setState(() {
                                      seekToSecond(value.toInt());
                                      value = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                  child: Text('${_duration.inMinutes}:${_duration.inSeconds % 60}', style: kDescTextStyle.copyWith(color: widget.primaryColor),),
                              ),

                            ],
                          ),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: width * 0.8,
                        height: 2,
//                    color: Colors.black,
                      ),
                    ),

                  ],
        ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              left: 0,
              child: back_button(context: context, onPressed: (){
                advancedPlayer.stop();
                advancedPlayer.dispose();
              },))
        ],
      );
  }


  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  getRandomNumber(){
    Random rand = Random();
    randNumber = rand.nextInt(4);
    setState(() {});
  }


  @override
  void dispose() {
    // TODO: implement dispose
    if(widget.data['videoLink'] == ""){
        advancedPlayer.stop();
        advancedPlayer.dispose();
    }else{
//      _controller.dispose();
//      chewieController.dispose();
//      SystemChrome.setPreferredOrientations([
//        DeviceOrientation.landscapeRight,
//        DeviceOrientation.landscapeLeft,
//        DeviceOrientation.portraitUp,
//        DeviceOrientation.portraitDown,
//      ]);
    _betterPlayerController.dispose(forceDispose: true);
    }

    super.dispose();

  }
}


