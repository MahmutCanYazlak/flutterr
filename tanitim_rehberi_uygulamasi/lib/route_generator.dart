import 'package:flutter/material.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_detay.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_listesi.dart';

import 'data/model/urun.dart';

class RouteGenerator
{
  static Route<dynamic>? routeGenerator(RouteSettings settings){
    switch(settings.name)
    {
      case "/" :
      return MaterialPageRoute(builder: (context) => UrunListesi(),);

      case "/urunDetay":
      return MaterialPageRoute(builder: (context) {
        final Urun secilen = settings.arguments as Urun;
        return UrunDetay(secilen);
      },);
    }
  }
}