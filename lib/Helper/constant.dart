import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double dialoguePadding =20;
const double dialogueAvatarRadius =45;

const nightColour = Color(0xff001d3d);
const nightColourCardColour = Color(0xff0e2e52);

const meditationCardColour = Color(0xfffaf3dd);

const kPrimaryColour = Colors.orange;



var kTitleTextStyle = GoogleFonts.nunito(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

var kSubTitleTextStyle = GoogleFonts.nunito(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: Colors.black,
  );

const kDescTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

const textFieldDecoration = InputDecoration(
  prefixIcon: Icon(Icons.email),
  hintText: "Email",
  hintStyle: kDescTextStyle,
  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
  focusColor: kPrimaryColour,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color: kPrimaryColour),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: kPrimaryColour, width: 2),
  ),

);


var placeholder_image = "images/beach.jpg";

var feelingName = 'feelingName';
var feelingImage = 'feelingImage';

var feelings = [
  {
    feelingName : 'Happy',
    feelingImage : 'images/happy.png'
  },
  {
    feelingName : 'Normal',
    feelingImage: 'images/normal.png'
  },
  {
    feelingName: 'Helpful',
    feelingImage: 'images/helpful.png'
  },
  {
    feelingName : 'Sad',
    feelingImage : 'images/sad.png'
  },
  {
    feelingName: 'Angry',
    feelingImage : 'images/angry.png'
  },
  {
    feelingName: 'Depressed',
    feelingImage : 'images/depressed.png'
  },
  {
    feelingName: 'Frustrated',
    feelingImage: 'images/frusted.png'
  },

  {
    feelingName: 'Scared',
    feelingImage: 'images/sacared.png'
  },
  {
    feelingName: 'Anxious',
    feelingImage: 'images/anxious.png'
  }
];
