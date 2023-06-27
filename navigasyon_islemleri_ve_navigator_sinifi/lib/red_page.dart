import 'dart:math';

import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  RedPage({super.key}); //_rasgeleSayi değişkenini üretmek için const yapısını sildiik
  int _rasgeleSayi = 0;

  @override
  Widget build(BuildContext context) {
    //WİLL POP SCOPE widgetı sayesinde telefonun geri gitme tuşu veya default gelen appbar daki geri git butonuna bastığımız zaman çalışan kısımdır normalde geri git butonuna bastığımızda random sayı üretilip ana sayfaya gönderiliyordu ama biz telefonun geri git tuşu ile geri gidersek null değer gönderir ana sayfaya işte bu gibi durumlarda willPopSpace kullanırız bunun içinede child olarak ana Scaffold yapımızı koruz willPopScope onWillPop propertysini alır bu ise isimlendirilmemiş bir fonksiyon geri dönüş tipi ise FUTURE içeren bir bool yapısı future lerde değer döndermeyi return Future.value(true); bu şekilde yaparız bu yapı sayesinde telefonunu geri tuşu ile geri gelindiğinde bir alert işlemi göserilebilir veritabanından bağlantı kesilebilir vs.
    return WillPopScope(
      onWillPop: () {
        debugPrint("Will Pop Scope çalıştı");
        if(_rasgeleSayi==0)
        {
           _rasgeleSayi= Random().nextInt(100);
           Navigator.of(context).pop(_rasgeleSayi);
        }
       
        return Future.value(true);
      },
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Red Page",
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
                onPressed: () {
                  _rasgeleSayi = Random().nextInt(100);
                  debugPrint("üretilen sayi: $_rasgeleSayi");
                  //bu sayfadaki bir değeri bu sayfanın çağırıldığı sayfada kullanmak istersek eğer pop(..) içine göndereceğimiz değeri yazarız bunu ana sayfada yakalamak için ise Navigator.of(context).push() yapısına baktığımızda pop methodunda geçilen değeri burda yakalayabiliyoruz diyor
                  Navigator.of(context).pop(_rasgeleSayi);
                },
              child: Text("Geri Git"),
            ),

                ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  print("evet pop olabilir");
                } else {
                  print("hayır olamaz");
                }
              },
              child: Text("Can Pop kullanımı"),
            ),
            
            //PUSH NAMED KULLANIMI 3
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.yellow.shade600),
              onPressed: () {
               Navigator.pushNamed(context, '/yellowPage');
              },
              child: Text("goto yellow page"),
            )
          ],
        )),
        appBar: AppBar(
          automaticallyImplyLeading:
              false, //yeni açılan sayfanın üstündeki geri gitme buyonunu kaldırır
          title: Text("Red Page"),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
