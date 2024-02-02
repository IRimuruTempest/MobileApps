import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {

  @override
  State<LoadingWidget> createState() => _LoadingWidget();
}

class _LoadingWidget extends State<LoadingWidget> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeWidth: 4,
        ),
      ),
    );
  }
}