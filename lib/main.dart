import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' show Random;
import 'package:night_sky/star.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  var random = Random();

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          animationController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (Timer t) => setAnimation());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/sky.jpg',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            fit: BoxFit.fill,
          ),
//          Opacity(
//            opacity: 0.6,
//            child: Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              color: Colors.black,
//            ),
//          ),
          ...makeStar(MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height)
        ],
      ),
    );
  }

  List<Widget> makeStar(double width, double height) {
    double starsInRow = width / 50;
    double starsInColumn = height / 50;
    double starsNum = starsInRow != 0
        ? starsInRow * (starsInColumn != 0 ? starsInColumn : starsInRow)
        : starsInColumn;

    List<Widget> stars = [];

    for (int i = 0; i < starsNum; i++) {
      stars.add(Star(
        top: random.nextInt(height.floor()).toDouble(),
        right: random.nextInt(width.floor()).toDouble(),
        animationController: animationController,
      ));
    }

    return stars;
  }
}