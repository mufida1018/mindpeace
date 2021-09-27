import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/Screens/diet_screen.dart';
import 'package:mindpeace/Screens/home_screen.dart';
import 'package:mindpeace/Screens/medetation_screen.dart';
import 'package:mindpeace/Screens/sleep_screen.dart';
import 'package:mindpeace/Screens/yoga_screen.dart';
import 'package:mindpeace/Widget/custom_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavbarScreen extends StatefulWidget {
  @override
  _NavbarScreenState createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  Color bottomNavBarColor = Colors.white;
  PersistentTabController _controller;
  var selectedIndex = 0;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }


  var intNumber = 0;

  List<Widget> _screens = [
    HomeScreen(),
    MeditationScreen(),
    SleepScreen(),
    YogaScreen(),
    DietScreen()
  ];

  List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.home, size: 20,),
        title: 'Home',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.circle, size: 20,),
        title: 'Meditation',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey
    ),
    PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.moon, size: 20,),
        title: 'Sleep',
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
//        opacity: 0.0,
    ),
    PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.shapes, size: 20,),
        title: 'Yoga',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey
    ),
    PersistentBottomNavBarItem(
        icon: FaIcon(FontAwesomeIcons.blog, size: 20,),
        title: 'Tips',
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey

    ),
  ];

  @override
  Widget build(BuildContext context) {


    return
      PersistentTabView(
      context,
      controller:_controller,
      screens: _screens,
      items: _items,
      confineInSafeArea: true,
      onItemSelected: (int int){
        if(int == 2){
          bottomNavBarColor = nightColourCardColour;
        }else{
          bottomNavBarColor = Colors.white;
        }
        setState(() {

        });


      },
      backgroundColor: bottomNavBarColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.blue

      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );

  }

}
