//DATE_FORMAT PAKETİ : tarihleri formatlamak için bir pakaet var pup dev den onu indireceğiz. date_format

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TarihSaatOrnek extends StatefulWidget {
  const TarihSaatOrnek({super.key});
  @override
  State<TarihSaatOrnek> createState() => _TarihSaatOrnekState();
}

class _TarihSaatOrnekState extends State<TarihSaatOrnek> {

  @override
  Widget build(BuildContext context) {

  //bu tarih saat ifadeleri kullanıcının tel. kayıtlı saatten geliyor
  //TARİH İŞLEMLERİ
  DateTime suan= DateTime.now();
  //3 ay öncesini belirlemek için
  DateTime ucAyOncesi = DateTime(2023,suan.month-3,);
  //20 gün sonrası için 
  DateTime yirmiGunSonrasi = DateTime(2023,suan.month,suan.day+20);
  

  //SAAT İŞLEMLERİ
  TimeOfDay suankiSaat = TimeOfDay.now();


    return Scaffold(
      appBar: AppBar(title: Text("Date Time picker"),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                //showDatePicker yapısı içinde dateTime olan future yapısı dönderiyor yani kullanıcı bir değer seçeçek ve biz o şeçimi beklememiz gerek then yapısı ile bunu yapalım
                showDatePicker(context: context, initialDate:suan , firstDate: ucAyOncesi, lastDate: yirmiGunSonrasi).then((SecilenTarih) {
                  debugPrint(SecilenTarih.toString());
                  debugPrint(SecilenTarih!.toIso8601String());
                  debugPrint(SecilenTarih.millisecondsSinceEpoch.toString());//1970 den sonraki zamanını milisaniye dönüştürererk bize eklenmesi yani başlangıç değerini 1970 alıyor ve şuanki tarih ile 1970 tarihi arasındaki milisaniye farkını bize verir
                  debugPrint(SecilenTarih.toUtc().toIso8601String());
                  debugPrint(SecilenTarih.add(Duration(days: 20)).toString());//girilen tarihe bir aralık ekledik
                  //yukarıda yaptıklarımız kullnıcının girdiği DateTime ı string ifadeye  çeviren yapılardı tam tersi de olabilirdi o zaman parse kullanırdık  aşağıda parse örneği var parametre olarak string bir ifade verip onu DateTime.parse ile DateTıme çevireceğiz
                  var yeniDate = DateTime.parse(SecilenTarih.add(Duration(days: 20)).toString());
                  debugPrint(yeniDate.toString());
                  //DATE_FORMAT PAKETİ İLE YAZDIRMA:
                  debugPrint(formatDate(SecilenTarih, [dd, '-', M, '-', yyyy]));

                   });
              },
              child: Text("Tarih seç"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),


            ElevatedButton(
              onPressed: () {
                //bu da bir future yapısı ve kullanıcının giridiği değeri öğrenmek için then yapısnı kullanıyoruz
                 showTimePicker(context: context, initialTime: suankiSaat).then((secilenSaat){
                  debugPrint(secilenSaat!.format(context));
                  debugPrint(secilenSaat.hour.toString() +":"+secilenSaat.minute.toString());

                 });
              },
              child: Text("Saat seç"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
