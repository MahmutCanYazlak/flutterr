import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    // todo: implement initState
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration.zero,
            to:const Duration(milliseconds: 200),
            tag: "opacity")
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from:const Duration(milliseconds: 250),
            to:const Duration(milliseconds: 500),
            tag: "width")
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from:const Duration(milliseconds: 500),
            to:const Duration(milliseconds: 750),
            tag: "height")
        .addAnimatable(
            animatable: EdgeInsetsTween(
                begin:const EdgeInsets.only(bottom: 16),
                end:const EdgeInsets.only(bottom: 75)),
            from:const Duration(milliseconds: 750),
            to:const Duration(milliseconds: 1000),
            curve: Curves.easeInCirc,
            tag: "padding")
        .addAnimatable (
            animatable:  BorderRadiusTween(
              begin:  BorderRadius.circular(4.0),
              end:  BorderRadius.circular(75.0),
            ),
            from: const Duration(milliseconds: 750),
            to: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tag: "borderRadius")
        .addAnimatable(
            animatable:  ColorTween(
              begin: Colors.indigo[100],
              end: Colors.orange[400],
            ),
            from: const Duration(milliseconds: 1000),
            to: const Duration(milliseconds: 1500),
            curve: Curves.ease,
            tag: "color")
        .animate(controller); //opacity için

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Next Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
              Hero(
                  tag: 'emre',
                  child: FlutterLogo(
                    size: 256,
                    textColor: Colors.red,
                    style: FlutterLogoStyle.stacked,
                  ),)
            ],
          ),
        ));
  }
}
