import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{

  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState(){
    super.initState();

    boxController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    boxAnimation = Tween(begin: 0.0, end: 3.14).animate(
        CurvedAnimation(
          parent: boxController,
          curve: Curves.linear,
        )
    );

    catController = AnimationController(
      duration: Duration(milliseconds:  200),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end : -80.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn,
      ),
    );
    boxAnimation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        boxController.repeat();

      }
    });
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    }
    else if(catController.status == AnimationStatus.dismissed){
      catController.forward();
    }
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, chlid){
        return Positioned(
          child: chlid,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox(){
    return Container(
      height: 200,
      width: 200,
      color: Colors.amber,
    );
  }

  Widget buildFlap(){
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width:  125.0,
          color: Colors.teal,
        ),
        builder: (context, child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildFlap(),
              ],
            ),
          ),
          onTap: onTap
      ),
    );
  }

}