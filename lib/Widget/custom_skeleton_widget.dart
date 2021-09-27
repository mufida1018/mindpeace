import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CustomSkeletonLoader extends StatelessWidget {
  const CustomSkeletonLoader({Key key, this.width}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Card(
          color: Colors.transparent,
          child: Row(
            children: [
              Text(''),
              Container(
                width: width * 0.45,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              )
            ],
          )
      ),
      baseColor: Colors.grey,
      highlightColor: Colors.white24,
    );
  }
}
