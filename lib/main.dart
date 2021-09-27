import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindpeace/Onboarding/onboarding_screen.dart';
import 'package:mindpeace/Screens/home_screen.dart';
import 'package:mindpeace/Screens/login_screen.dart';
import 'package:mindpeace/Screens/navbar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Mindpeace());
}

class Mindpeace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null ? NavbarScreen() : OnboardingScreen(),
    );
  }
}
