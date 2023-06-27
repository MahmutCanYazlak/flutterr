import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Ödevi"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
          [
            dartRowunuOlustur(),
            Expanded(child:dersleriColumnOlustur(),),
            
          ]),
        ),
      ),
    );
  }

  Column dersleriColumnOlustur() {
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: ContainerOlustur("E", Colors.orange.shade200,margin: 15)),
              Expanded(child: ContainerOlustur("R", Colors.orange.shade300,margin: 15)),
              Expanded(child: ContainerOlustur("S", Colors.orange.shade400,margin: 15)),
              Expanded(child: ContainerOlustur("L", Colors.orange.shade500,margin: 15)),
              Expanded(child: ContainerOlustur("E", Colors.orange.shade600,margin: 15)),
              Expanded(child: ContainerOlustur("R", Colors.orange.shade700,margin: 15)),
              Expanded(child: ContainerOlustur("I", Colors.orange.shade800,margin: 15)),


            ],
          );
  }

  Row dartRowunuOlustur() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ContainerOlustur("D", Colors.orange.shade100),
              ContainerOlustur("A", Colors.orange.shade200),
              ContainerOlustur("R", Colors.orange.shade300),
              ContainerOlustur("T", Colors.orange.shade400),
            ],
          );
  }

  Container ContainerOlustur(String harf, Color renk , {double margin= 0}) {
    return Container(
      height: 75,
      width: 75,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: margin),
      color: renk,
      child: Text(
        harf,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget UzunYol() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              color: Colors.orange.shade100,
              child: Text(
                "D",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              color: Colors.orange.shade200,
              child: Text(
                "A",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              color: Colors.orange.shade300,
              child: Text(
                "R",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              color: Colors.orange.shade100,
              child: Text(
                "T",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Colors.orange.shade200,
                  width: 75,
                  height: 75,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "E",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade300,
                  width: 75,
                  height: 75,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "R",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade400,
                  width: 75,
                  margin: EdgeInsets.only(top: 10),
                  height: 75,
                  alignment: Alignment.center,
                  child: Text(
                    "S",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade500,
                  width: 75,
                  margin: EdgeInsets.only(top: 10),
                  height: 75,
                  alignment: Alignment.center,
                  child: Text(
                    "L",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade600,
                  width: 75,
                  height: 75,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "E",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade700,
                  width: 75,
                  height: 75,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "R",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.orange.shade800,
                  width: 75,
                  margin: EdgeInsets.only(top: 10),
                  height: 75,
                  alignment: Alignment.center,
                  child: Text(
                    "İ",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
