import 'package:flutter/material.dart';
import 'package:mindpeace/Widget/appbar.dart';

class JobOffersScreen extends StatelessWidget {
  const JobOffersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar(
        title: 'Job Offers',
      ),
    );
  }
}
