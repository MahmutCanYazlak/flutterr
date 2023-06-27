import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liste_turleri_ve_olusturma_methodlar/1.dart';
import 'package:liste_turleri_ve_olusturma_methodlar/11_12_13_14.dart';
import 'package:liste_turleri_ve_olusturma_methodlar/2_3_4_5.dart';
import 'package:liste_turleri_ve_olusturma_methodlar/6.dart';
import 'package:liste_turleri_ve_olusturma_methodlar/8_9_10.dart';

//ignore_for_file: prefer_const_constructors

void main(List<String> args) {
  runApp(MyApp());
  configLoading(); //aşağıdaki fonksiyonu burda çağırdık 

}

//DIŞARDAKİ BİR YAPIYI KULLANMAK İÇİN. BİZİM DÖKÜMANTASYONUMUZUN GİTHUB KODLARINA BAKTIĞIMIZDA ADAMLAR COSTUMİZE İŞLEMLERİ İÇİN BU ŞEKİLDE YAPMIŞLAR BİZDE ONA İSTİNADEN BU ŞEKİLDE YAPTIK
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom //burası default dark geliyor kodları yazıp çalıştırdığımızda değişiklik olmadığını gördük dökümantasyona baktığımızda diyorki eğer sen text color backroundColor u falan değiştireceksen bunun dark değil custom olması gerektiğini söylüyor bize 
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.white   
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true; //bu fasle geldi tüm projemizde çalışsın diye true yaptık

    //bu fonksiyonda .. nın anlamı her seferinde EasyLoading.instance.ÖZELLİK yazmana gerek kalmıyor bir kere yazıyon .. ile devamı gelceğini belirtiyon
}


class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark), //gece modu yapmaya yarıyor
      debugShowCheckedModeBanner: false,
      home: CustomScrollVeSliversKullanimi(),
      //DIŞARDAKİ BİR YAPIYI PROJEMİZDE KULLANMAK İÇİN. BUNU İNTERNETTEN ALDIK 
      builder: EasyLoading.init(), //builder normalde isimlendirilmemiş fonksiyon ister parametre olarak ta context ve widget ister biz bunlar yerine  EasyLoading.init() yazdıysak demek ki bu yapı bize böyle bir şey dönderiyormuş bunu yaptıktan sonra artık projemizde bunu kullanabiliriz 
    );
  }

}