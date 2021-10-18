import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Helper/helper_function.dart';
import 'package:mindpeace/Onboarding/onboarding_screen.dart';
import 'package:mindpeace/SettingsScreens/account_and_subsciption_screen.dart';
import 'package:mindpeace/SettingsScreens/credit_screen.dart';
import 'package:mindpeace/SettingsScreens/invite_friends_screen.dart';
import 'package:mindpeace/SettingsScreens/job_offers_screen.dart';
import 'package:mindpeace/SettingsScreens/language_screen.dart';
import 'package:mindpeace/SettingsScreens/notification_screen.dart';
import 'package:mindpeace/SettingsScreens/privay_policy.dart';
import 'package:mindpeace/SettingsScreens/profile_screen.dart';
import 'package:mindpeace/SettingsScreens/reminders_screen.dart';
import 'package:mindpeace/SettingsScreens/terms_and_conditions.dart';
import 'package:mindpeace/Widget/customRoundButton.dart';
import 'package:mindpeace/Widget/custom_alert.dart';
import 'package:mindpeace/Widget/settings_row.dart';
import 'package:package_info/package_info.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  HelperFunction _helperFunction = HelperFunction();


  String name = "";
  String email = "";
  String buildNumber = '';
  String versionNumber = '';

  bool appBarTitleVisibility = false;

  @override
  void initState() {
    // TODO: implement initState
    getUserName();
    getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = _helperFunction.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >
                    scrollInfo.metrics.minScrollExtent + 170) {
                  setState(() {
                    appBarTitleVisibility = true;
                  });
                } else {
                  setState(() {
                    appBarTitleVisibility = false;
                  });
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, name);
                                  }),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                name,
                                style: kTitleTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                              // IconButton(icon: Icon(Icons.settings, color: Colors.black,), onPressed: (){
                              //   Navigator.pop(context);
                              // }),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.amber,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  color: Colors.amber[100],
                                  image: DecorationImage(
                                    image: AssetImage('images/mind_guru.png'),
                                    fit: BoxFit.scaleDown,
                                  )),
                            ),
                            onTap: () async {
                              var name1 = await pushNewScreen(context,
                                  screen: ProfileScreen(), withNavBar: false);
                              name = name1;
                              setState(() {

                              });

                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: width,
                        height: 1,
                        color: Colors.black26,
                      ),
                    ),
                    Container(
                      child: Text('Settings',
                          style: kTitleTextStyle.copyWith(color: Colors.black)),
                    ),
                    Settings_Row(
                        width: width,
                        title: 'Accounts & Subscription',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AccountAndSubscriptionScreen()));
                        }),
                    Settings_Row(
                        width: width,
                        title: 'Invite friends',
                        onPressed: () {
                          pushNewScreen(context,
                              screen: InviteFriends(), withNavBar: false);
                        }),
                    Settings_Row(
                        width: width, title: 'Notification', onPressed: () {
                      pushNewScreen(context, screen: NotificationScreen(), withNavBar: false);

                    }),
                    Settings_Row(
                        width: width, title: 'Reminders', onPressed: () {
                      pushNewScreen(context, screen: RemindersScreen(), withNavBar: false);

                    }),
                    Settings_Row(
                        width: width, title: 'Language', onPressed: () {
                      pushNewScreen(context, screen: LanguageScrees(), withNavBar: false);

                    }),
                    Settings_Row(
                        width: width, title: 'Support', onPressed: () {}),
                    Settings_Row(
                        width: width,
                        title: 'Terms and Conditions',
                        onPressed: () {
                          pushNewScreen(context, screen: TermsAndConditionsScreen(), withNavBar: false);

                        }),
                    Settings_Row(
                        width: width,
                        title: 'Privacy Policy',
                        onPressed: () {
                          pushNewScreen(context, screen: PrivacyPolicyScreen(), withNavBar: false);

                        }),
                    Settings_Row(
                        width: width, title: 'Credits', onPressed: () {
                          pushNewScreen(context, screen: CreditScreens(), withNavBar: false);
                    }),
                    Settings_Row(
                        width: width, title: 'Job Offers', onPressed: () {
                      pushNewScreen(context, screen: JobOffersScreen(), withNavBar: false);

                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Logged in as',
                      style: kSubTitleTextStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Text(
                          '$email',
                          style: kSubTitleTextStyle,
                        ),
                      ),
                    ),
                    Text(
                      'Version $buildNumber ($versionNumber)',
                      style: kSubTitleTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: customRoundButton(
                        title: 'Log out',
                        textColor: Colors.white,
                        color: Colors.amber,
                        width: width * 0.8,
                        // height: 75,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext) {
                                return CustomAlert(
                                  title: 'Log Out',
                                  descriptions:
                                      'Are you sure you want to log Out',
                                  buttonPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OnboardingScreen()),
                                        (route) => false);
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: appBarTitleVisibility,
                child: Container(
                  color: Colors.white,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Text(
                          'Settings',
                          style:
                              kSubTitleTextStyle.copyWith(color: Colors.black),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUserName() async {
    name = await _helperFunction.getUserName();
    email = await _helperFunction.getUserEmail();
    setState(() {});
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      buildNumber = packageInfo.buildNumber;
      versionNumber = packageInfo.version;
    });
  }
}
