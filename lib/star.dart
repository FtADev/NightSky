import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  final top;
  final right;
  final animationController;

  const Star({Key key, this.top, this.right, this.animationController}) : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      right: widget.right,
      child: ScaleTransition(
        alignment: Alignment.center,
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        child: Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
