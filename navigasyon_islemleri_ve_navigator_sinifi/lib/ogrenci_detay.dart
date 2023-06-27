import 'package:flutter/material.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/ogrenci_listesi.dart';

class OgrenciDetay extends StatelessWidget {
  //KURUCULAR İLE VERİ GÖNDERMEK 1: buid içine gidip ModalRoute ile o veriyi almaktansa sınıf oluşturulduğunda ben bunu değer olarak gezsem bunun için bu satırı yazıp kurucu fonksiyonda yazıyorum yani bu widget oluşturulurken mutlaka buna isimlendirilmiş bir şekilde secilenOgrenci nin yollanması gerektiğini söyledik fakat henüz buraya veri göndermedik veri göndermek için ogrenci_listsi.dart dosyasında listemize gidip onTap() fonksiyonunda veri gönderelim
  final Ogrenci secilenOgrenci; 
  const OgrenciDetay({required this.secilenOgrenci , super.key});

  @override
  Widget build(BuildContext context) {
    //ModalRoute ile de veriyi alabiliriz bunun olma sebebi biz OgrenciDetay sayfasını açtığımıda route_generator.dart a gidip MaterialPageRoute settings: settings diyoruz ya işte ondan dolayı biz o veriyi burda bu yöntemle yakalayabiliyoruz eğerki ModalRoute ile veriyi yakalicaksak  MaterialPageRoute da gidip settings: settings demek zorundayız ama kurucular ile veri gönderiyorsak en yukardaki yöntem o zaman gidip  MaterialPageRoute da  (settings: settings ) kısmını yorum satırı yapabilirsin yani bu ogrenci_detay.dart kısmının çalışması MaterialPageRoute daki settings bağlı değil çünkü biz burda ilgili verimizi kurucularla yapıyoruz bunuda route_generator.dart dosyasındaki routeGenerator() fonksiyonundaki return _routeOlustur(OgrenciDetay(secilenOgrenci: parametredekiOgrenci), settings); kodu sayesinde oluyor bu şu demek ne zamaki OgrenciDetay sayfasını açacaksın içine secilenOgrenci değerini koy diyoruz
    var secilen = ModalRoute.of(context)!.settings.arguments as Ogrenci ;
    print('secilen ogrenci : $secilen');
    return Scaffold(
      appBar: AppBar(title: Text("Ogrenci Detay")),
      body: Center(child: Column( children: [
        
        Text(secilenOgrenci.id.toString()),
        Text(secilenOgrenci.ad),
        Text(secilenOgrenci.soyad),

        //POP UNTİL VE  PUSH NAMED AND REMOVE UNTİL KULLANIMI 1: kullanımını göremk için eklenmiş bir buton yellow page sayfasına git
        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/yellowPage');
          
        }, child: Text("sarı sayfaya git"),
        style: ElevatedButton.styleFrom(primary: Colors.yellow)),

      ]),),
    );
  }
}