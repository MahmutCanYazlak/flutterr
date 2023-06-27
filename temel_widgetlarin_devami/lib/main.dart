//HOT RELOAT: built yapılarını tetikler onları çalıştırı
//HOT RESTAT: main fonksiyonunu da çalıştırır

//eğer biz gidip materialApp i main içinde yazarsak ovveride yapısından gelen buil fonksiyonu kalkacağı için hot reloat çalışmicak hot restat atman gerekecek

import 'package:flutter/material.dart';
import 'package:temel_widgetslarin_devami_1/5_6.dart';
import 'package:temel_widgetslarin_devami_1/1_2_3_4.dart';
import 'package:temel_widgetslarin_devami_1/7.dart';
import 'package:temel_widgetslarin_devami_1/8.dart';
import 'package:temel_widgetslarin_devami_1/9.dart';

void main() {
  debugPrint("Main çalıştı");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("Myapp çalıştı");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          outlinedButtonTheme:
              OutlinedButtonThemeData(style: OutlinedButton.styleFrom()),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)))),

      title:
          "Flutter", //bazı telefonlarda açık sekmeleri göster dediğimiz zaman arka planda ya uygulamanın iconu ya da bu yazı çıkar
      home: Scaffold(
        appBar: AppBar(title: Text("Buton Örnekleri"), elevation: 0 ,actions: [PopupMenuKullanimi()]),
        body: TemelButonlar(),
        
      ),
    );
  }
}
