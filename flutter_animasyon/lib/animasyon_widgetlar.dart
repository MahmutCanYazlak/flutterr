// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animasyon/main.dart';

class AnimasyonluWidgetlar extends StatefulWidget {
  const AnimasyonluWidgetlar({super.key});

  @override
  State<AnimasyonluWidgetlar> createState() => _AnimasyonluWidgetlarState();
}

class _AnimasyonluWidgetlarState extends State<AnimasyonluWidgetlar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Action Bubble Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(textDirection: TextDirection.rtl, child: MyHomePage(title: 'Floating Action Bubble Demo')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    
    super.initState();


  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      
      //Init Floating Action Bubble 
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[

          // Floating action menu item
          Bubble(
            title:"Settings",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.settings,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"Profile",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.people,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title:"Home",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.home,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => MyApp()));
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
        
        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon 
        iconData: Icons.ac_unit, 
        backGroundColor: Colors.white,
      )
    );
  }
}