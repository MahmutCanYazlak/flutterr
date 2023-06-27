import 'package:flutter/material.dart';
import 'package:tanitim_rehberi_uygulamasi/route_generator.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_listesi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      title: 'Material App',
      //home: UrunListesi()
      onGenerateRoute: RouteGenerator.routeGenerator,//doğrudan tetiklemiyoruz ne zaman bir ongenerator rotası gelirse o zaman git bu fonk. tetikle
    );
  }
  

}