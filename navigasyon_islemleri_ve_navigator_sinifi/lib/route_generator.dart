import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/main.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/ogrenci_detay.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/ogrenci_listesi.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/red_page.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/yellow_page.dart';

class RouteGenerator
{
  //bu yapı onGenerateRoute in üzerine uzun gelince vardı ordan aldık bizden beklediği yapı bu yani bizde burda bu yapıyı oluşturduk bundan dolayı doğrudan gidip onGenerateRoute karşısında bu sınıfımızda ki bu fonksiyonu çağırabiliriz
  static Route<dynamic>? routeGenerator(RouteSettings settings)
  {
     // settings.name ->gidilen rota
     // settings.arguments-> yeni gidelecek rotaya eğer veri yollayacaksak kullanacağımız yapı

    //bir fonksiyonumuz var ve gidilebilecek bir sürü rota var iç içe if else yerine Switch kullanalım

    switch(settings.name)
    {
      case '/':
        return _routeOlustur(AnaSayfa() , settings);

      case '/yellowPage':
        return _routeOlustur(YellowPage(), settings);


      case '/redPage':
        return _routeOlustur(RedPage(), settings);


      case '/ogrenciListesi':
        return _routeOlustur(OgrenciListesi(), settings);
        
      //KURUCULAR İLE VERİ GÖNDERMEK 3:
      case '/ogrenciDetay':
        var parametredekiOgrenci = settings.arguments as Ogrenci ; //burda arguments object tipinde veri verir biz burda as Ogrenci idyerek ben burdan gelecek olan verinin Ogrenci olduğunu biliyorum diyorsun 
        return _routeOlustur(OgrenciDetay(secilenOgrenci: parametredekiOgrenci), settings);


      default:
       return MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("404")),
          body: Center(child: Text("sayfa bulunamadı")),
        );
      }
      );

    }

  }

   //kodlarımızda hep bu kısım tekrar ediyordu değişen tek şey ise gidilecek olan widget yapısıydı. ondan dolayı bunu fonks. çevirdik gilecek olan widgetı parametre olarak alırım ve bu geriye istediğiimiz rotayı geri dönderir. routeGenerator() fonk. tipi Route<dynamic>? olduğundan bununda tipi öyle ve routeGenerator() static olduğu için static yapı içinde düz fonksiyon çağıramıyorduk ondan dolayı bunuda static yaptık
  static Route<dynamic>? _routeOlustur(Widget gidilecekWidget , RouteSettings settings)
  {
    if(TargetPlatform==TargetPlatform.android)
        {
          return MaterialPageRoute(
            builder: (context) => gidilecekWidget, 
            settings: settings); ////ON GENERATE ROUTE KULLANİMİ 3: SAYFALAR ARASI VERİ GÖNDERMEK İÇİN 2:settings:settings veri gönderme işlemi için kullanıldı settings: settings.argument yazadabilirdik ama settings daha genel bir yapı
        }
        else if(TargetPlatform==TargetPlatform.iOS)
        {
          return CupertinoPageRoute(
            builder: (context) => gidilecekWidget,
            settings: settings);

        }
        else
        {
          return MaterialPageRoute(builder: (context) => gidilecekWidget , 
          settings: settings); //web uygulaması falansa
        }
  }
}