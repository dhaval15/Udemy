import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  AnimationController catAnimationController;
  Animation<double> catAnimation;
  AnimationController boxAnimationController;
  Animation<double> boxAnimation;

  @override
  void initState() {
    super.initState();
    catAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    catAnimation = Tween(begin: -50.0, end: -120.0).animate(CurvedAnimation(
      parent: catAnimationController,
      curve: Curves.easeIn,
    ));
    boxAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    boxAnimation =
        Tween(begin: pi * 0.6, end: pi * 0.4).animate(CurvedAnimation(
      parent: boxAnimationController,
      curve: Curves.easeInOut,
    ));
    boxAnimationController.addStatusListener((status) {
      if (boxAnimationController.status == AnimationStatus.completed)
        boxAnimationController.reverse();
      else if (boxAnimationController.status == AnimationStatus.dismissed)
        boxAnimationController.forward();
    });
    boxAnimationController.forward();
  }

  void onTap() {
    if (catAnimationController.status == AnimationStatus.completed) {
      catAnimationController.reverse();
      boxAnimationController.forward();
    } else if (catAnimationController.status == AnimationStatus.dismissed) {
      catAnimationController.forward();
      boxAnimationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                buildCat(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCat() => AnimatedBuilder(
        animation: catAnimation,
        child: Cat(),
        builder: (context, child) => Positioned(
          top: catAnimation.value,
          left: 0,
          right: 0,
          child: child,
        ),
      );

  Widget buildBox() => Positioned(
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (BuildContext context, Widget child) => Transform.translate(
            child: Transform.rotate(
              child: child,
              angle: (boxAnimation.value - (pi * 0.5)) / 200,
            ),
            offset: Offset(boxAnimation.value - (pi * 0.5), 0),
          ),
          child: Container(
            width: 300,
            height: 300,
            color: Colors.brown,
          ),
        ),
      );

  Widget buildLeftFlap() => Positioned(
        top: 2,
        left: 4,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (BuildContext context, Widget child) => Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          ),
          child: Container(
            height: 10,
            width: 100,
            color: Colors.brown,
          ),
        ),
      );
  Widget buildRightFlap() => Positioned(
        top: 2,
        right: 4,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (BuildContext context, Widget child) => Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          ),
          child: Container(
            height: 10,
            width: 100,
            color: Colors.brown,
          ),
        ),
      );
}
