import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/IAPScreens/purchase_button.dart';
import 'package:mindpeace/SettingsScreens/refund_policy_screen.dart';
import 'package:mindpeace/SettingsScreens/terms_and_conditions.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:purchases_flutter/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class UpsellScreen extends StatefulWidget {

  const UpsellScreen({Key key, this.offerings}) : super(key: key);
  final Offerings offerings;

  @override
  _UpsellScreenState createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  HelperFunction _helperFunction = HelperFunction();
  

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);
    var height = _helperFunction.getHeight(context);


    if(widget.offerings != null){
      print('offerings is not null');
      print(widget.offerings.current.toString());
      print('__');
      print(widget.offerings.toString());

      final offering = widget.offerings.current;

      if(offering != null){
        final monthly = offering.monthly;
        final yearly = offering.annual;
        if(monthly != null && yearly != null){
          return Scaffold(
            body: Container(
              width: width,
              height: height,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(icon: FaIcon(FontAwesomeIcons.times, size: 20,color: Colors.black.withOpacity(0.05,),), onPressed: (){
                              Navigator.pop(context);
                            },),

                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Become a", style: kTitleTextStyle,),
                          Text(' PRO ', style: kTitleTextStyle.copyWith(color: Colors.orangeAccent, fontWeight: FontWeight.bold),),
                          Text('member', style: kTitleTextStyle, )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.1,
                                child: FaIcon(FontAwesomeIcons.check, color: Colors.orangeAccent, size: 18,)
                            ),
                            Container(
                                width: width * 0.8,
                                child: Text('Access to premium content', style: kDescTextStyle.copyWith(fontWeight: FontWeight.w500),))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: width * 0.1,
                                child: FaIcon(FontAwesomeIcons.check, color: Colors.orangeAccent, size: 18,)
                            ),
                            Container(
                                width: width * 0.8,
                                child: Text('Access to new content', style: kDescTextStyle.copyWith(fontWeight: FontWeight.w500),))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: width * 0.1,
                                child: FaIcon(FontAwesomeIcons.check, color: Colors.orangeAccent, size: 18,)
                            ),
                            Container(
                                width: width * 0.8,
                                child: Text('Unrestricted access to the app', style: kDescTextStyle.copyWith(fontWeight: FontWeight.w500),))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Row(
                          children: [
                            Container(
                                width: width * 0.1,
                                child: FaIcon(FontAwesomeIcons.check, color: Colors.orangeAccent, size: 18,)
                            ),
                            Container(
                                width: width * 0.8,
                                child: Text('Meditate with the GURU', style: kDescTextStyle.copyWith(fontWeight: FontWeight.w500),))
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),

                      PurchaseButton(
                        package: yearly, backgroundColour: Colors.deepOrange,tag: 'Best Seller', textColour: Colors.white,
                      ),
                      PurchaseButton(
                        package: monthly,tag: '', textColour: Colors.black,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepOrange
                                ),
                              ),
                            ),

                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(left:4),
                                child: Text('Refund Policy', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.deepOrange),),
                              ),
                              onTap: (){
                                //Navigate to refund policy
                                pushNewScreen(context, screen: RefundPolicyScreen(), withNavBar: false);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.deepOrange
                                ),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.only(left:4.0),
                                child: Text('Terms & Conditions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.deepOrange),),
                              ),
                              onTap: (){
                                pushNewScreen(context, screen:TermsAndConditionsScreen(), withNavBar: false);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          );
        }else{

        }

      }
    }
  }
}
