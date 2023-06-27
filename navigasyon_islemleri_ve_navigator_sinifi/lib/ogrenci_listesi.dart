import 'package:flutter/material.dart';

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({super.key});

  @override
  Widget build(BuildContext context) {
    //ON GENERATE ROUTE KULLANİMİ 3: SAYFALAR ARASI VERİ GÖNDERMEK İÇİN 3: main.dart dosyasında gönderdiğimiz veriyi ilgili sayfada çekme işlemi
    //VE bu veri çekme işlemini build içerisinde yapıyoruz çünkü o veriyi okuyabilmek için context e ihtiyaç duyuyor ve bu class içinde Stateles widget ta olduğumuz için contextin old. tek yer burasıbiz bunu buil de yazdığımız için build her çalıştığında bu liste tekrardan oluşacaktır
    int elemanSayisi = ModalRoute.of(context)!.settings.arguments
        as int; //as int ile gelen değerin integer olduğunu bildiğimizi belirtip bir değişkene atabiliriz ve ! bu ifade ile null olmayacağını belirttil
    List<Ogrenci> tumOgrenciler = List.generate(
        elemanSayisi,
        (index) =>
            Ogrenci(index + 1, "isim ${index + 1}", "soyisim ${index + 1}"));
    print("eleman sayisi alındı: $elemanSayisi");
    return Scaffold(
      appBar: AppBar(
        title: Text("Ogrenci listesi"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          
          return ListTile(
            //KURUCULAR İLE VERİ GÖNDERMEK 2: listemizde tıklanan elemanın verilerini ogrenci_detay.dart dosyamızda göstermeye çalışcağız
            onTap: () {
              var secilen = tumOgrenciler[index];
              Navigator.pushNamed(context, '/ogrenciDetay', arguments: secilen);
            },
            leading:
                CircleAvatar(child: Text(tumOgrenciler[index].id.toString())),
            title: Text(tumOgrenciler[index].ad),
            subtitle: Text(tumOgrenciler[index].soyad),
          );
        },
        itemCount: elemanSayisi,
      ),
    );
  }
}

class Ogrenci {
  final int id;
  final String ad;
  final String soyad;

  Ogrenci(this.id, this.ad, this.soyad);
}
