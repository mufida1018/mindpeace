import 'dart:convert';
import 'dart:math';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Screens/navbar_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginSc extends StatefulWidget {
  const LoginSc({Key key}) : super(key: key);

  @override
  _LoginScState createState() => _LoginScState();
}

class _LoginScState extends State<LoginSc> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showLoader = false;

  HelperFunction _helperFunction = HelperFunction();

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }


  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);



    return GestureDetector(
      child: Scaffold(
          backgroundColor: Color(0xff1e6091),

          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white.withOpacity(0.2), size: 20,),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 50),
                    slidingBeginOffset: Offset(0, 2),
                    child: Text('Hi, welcome back!!', style: kTitleTextStyle.copyWith(color: Colors.white),),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,
                  ),

                  DelayedDisplay(
                    delay: Duration(milliseconds: 550),
                    slidingBeginOffset: Offset(0, 2),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: width * 0.8,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue[900].withOpacity(0.2)
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                style: kTitleTextStyle.copyWith(color: Colors.white),
                                controller: emailController,
                                cursorColor: Colors.white.withOpacity(0.5),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: kSubTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5)),
                                ),
                                onChanged: (value){
                                  setState(() {

                                  });
                                },

                              ),
                            ),
                            emailController.text.length > 0 ?
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40,
                                height: 30,
                                child: Center(child: Text(emailController.text.length.toString(), style: kTitleTextStyle.copyWith(fontSize: 18 ,color: Colors.black87),)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 2, spreadRadius: 2)
                                    ]
                                ),

                              ),
                            ): Container(),

                          ],
                        ),
                      ),
                    ),
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 600),
                    slidingBeginOffset: Offset(0, 2),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: width * 0.8,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue[900].withOpacity(0.2)
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                style: kTitleTextStyle.copyWith(color: Colors.white),
                                controller: passwordController,
                                obscureText: true,
                                autofocus: false,
                                cursorColor: Colors.white.withOpacity(0.5),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: kSubTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5)),
                                ),
                                onChanged: (value){
                                  setState(() {

                                  });
                                },

                              ),
                            ),
                            passwordController.text.length > 0 ?
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40,
                                height: 30,
                                child: Center(child: Text(passwordController.text.length.toString(), style: kTitleTextStyle.copyWith(fontSize: 18 ,color: Colors.black87),)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 2, spreadRadius: 2)
                                    ]
                                ),

                              ),
                            ): Container(),

                          ],
                        ),
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DelayedDisplay(

                      delay: Duration(milliseconds: 650),
                      slidingBeginOffset: Offset(0, 2),
                      fadingDuration: Duration(milliseconds: 700),
                      fadeIn: true,
                      child: ArgonButton(
                        height: 70,
                        width: width * 0.7,
                        color: Colors.white,
                        borderRadius: 5.0,
                        child: Text('Login', style: kSubTitleTextStyle.copyWith(color: Color(0xff1e6091)),),
                        loader: Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitRotatingCircle(
                            color: Color(0xff1e6091),
                            // size: loaderWidth ,
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          if(emailController.text == "" && passwordController.text == ""){
                            stopLoading();
                            _helperFunction.showToast(context: context, color: Colors.red, title: "Email ID or Password cannot be blank!");

                          }else{

                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((value){
                              if(value != null){
                                // saveUid(value.user.uid);
                                stopLoading();
                                navigateToNextScreen(context, NavbarScreen());
                              }
                            }).catchError((e){
                              stopLoading();
                              _helperFunction.showToast(context: context, color: Colors.red, title: 'Failed to login in try again');
                            });
                          }
                          stopLoading();

                        },
                      ),
                    ),
                  ),

                  DelayedDisplay(
                    delay: Duration(milliseconds: 610),
                    slidingBeginOffset: Offset(0, 2),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Container(width: width * 0.3, color: Colors.white, height: 1,),
                          Text('OR', style: kTitleTextStyle.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 18),),

                          Container(width: width * 0.3, color: Colors.white, height: 1,),

                        ],
                      ),
                    ),
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 630),
                    slidingBeginOffset: Offset(0, 2),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _signInButton(),
                    ),
                  ),
                  DelayedDisplay(
                    delay: Duration(milliseconds: 650),
                    slidingBeginOffset: Offset(0, 2),
                    fadingDuration: Duration(milliseconds: 700),
                    fadeIn: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _appleSignInButton(),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
      onTap: () => _helperFunction.hideKeyboard(context),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        googleSignIn();

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appleSignInButton(){
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25 , 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('svg/apple_logo.svg', height: 35.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Apple',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Colors.black,
            border: Border.all(color: Colors.grey)
        ),
      ),
      onTap: (){
        signInWithApple();
      },
    );
  }

  // Future RegisterWithEmailAndPassword(){
  //   if(emailController.text == "" && passwordController.text == ""){
  //     _helperFunction.showToast(context: context, color: Colors.red, title: "Email ID or Password cannot be blank!");
  //
  //   }else{
  //     setState(() {
  //       showLoader = true;
  //     });
  //     FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((value){
  //       if(value != null){
  //         saveUid(value.user.uid);
  //         setState(() {
  //           showLoader = false;
  //         });
  //         navigateToNextScreen(context, NavbarScreen());
  //       }
  //     }).catchError((e){
  //       setState(() {
  //         showLoader = false;
  //       });
  //       _helperFunction.showToast(context: context, color: Colors.red, title: 'Failed to create new user, Try again');
  //     });
  //   }
  // }


  void googleSignIn()async{
    print("Google Sing In Button Pressed");
    setState(() {
      showLoader = true;
    });

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      // saveUid(user.uid);
      navigateToNextScreen(context, NavbarScreen());
    }
  }

  void signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    FirebaseAuth.instance.signInWithCredential(oauthCredential).then((value){
      if(value != null){
        // saveUid(value.user.uid);
        navigateToNextScreen(context, NavbarScreen());
      }
    });

  }

  void navigateToNextScreen(BuildContext context, Widget screen,){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));

  }
}
