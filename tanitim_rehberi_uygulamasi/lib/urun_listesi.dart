import 'package:flutter/material.dart';
import 'package:tanitim_rehberi_uygulamasi/data/model/urun.dart';
import 'package:tanitim_rehberi_uygulamasi/data/strings.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_item.dart';

class UrunListesi extends StatelessWidget {
  //Data klasörümüzde yer alan listeleri tek bir temiz liste haline getiriyoruz bunun içinde modal dosyasını oluşturup urun.dart dosyasını oluşturduk
  //NOT: buraya verdiğim liste sınıf oluşturulurken henüz hazır değil o yüzden bu listeyi ya bu sınıfın kurucusuna parametre olarak vereceğiz yani başka bir yerde bu sınıfı çağırdığım zaman oluşturup buna geçecem eğerki ben bu class içinde bu listeyi oluşturacaksam kurucu fonk. önündeki const yapısını silersin çünkü bu listenin içeriği bu sınıf oluşturulduktan sonra oluşacak ve kurucunun içindeki key leri kullanmicağımızdan sildik ve sistem bize TumBurclar initialized edilmeli diyor. List<Urun> TumUrunler = [];  bunu sınıfın en üstüne tanımladım ki sınıfın her yerinden ulaşayım ve ne zamanki bu sınıf oluşturulacak burdaki kurucu fonk. çalışcak orda da bunu boş listeye atatım şimdilk zaten bunun doldurulma işinide burda yapacam başına late ekleyerekte diyoruzki meraj etme sen bunu kullanmadan ben bunu initialized edecem ve bu initializedişlemi içinde veriKaynaginiHazirla() isminde fonksiyon yazdı bu şu işe yarayacak içinde Urun olan bir listeyi hazirlicak geriye dönderecek ve ben bunu sınıf için tanımladığım TumUrunler değişkeninin içine atacam böylece bu uygulamanını herhangi bir yerinde kullanabilecem
  late List<Urun> TumUrunler = [];

  UrunListesi() {
    TumUrunler = veriKaynaginiHazirla();
    print(TumUrunler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: true,
            pinned: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Ürun Listesi",
                style: TextStyle(color: Colors.orange),
                textAlign: TextAlign.center,
              ),
              background: Image.asset(
                "images/ayssoft.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: TumUrunler.length,
              (context, index) {
                return  UrunItem(TumUrunler[index]);
              },
              
            ),
          ),
        ],
      ),
    );
  }

  List<Urun> veriKaynaginiHazirla() {
    //burda bizim yaptığımız şey bu fonk çalıştğında içinde Urun olan bu listeyi geriye dönderiyor griye dönderilen bu yapı yukarda tumUrunler e atanıyor böylece tumUrunler de tüm ürünlerimizi saklamış oluyoruz
    List<Urun> gecici = [];
    for (int i = 0; i < 7; i++) {
      //bu for 7 kere çalışacak her çalıştıpında Urun nesnesi oluşturulacak ve her üretilen nesneyi gecici listemize atacağız bu for döngüsü bittiğinde oluşan for döngüsünü yukarıya yollicağız
      var urunAdi = Strings.URUN_ADLARI[i];
      var urunKodu = Strings.URUN_KODLARI[i];
      var urunOzellik = Strings.URUN_OZELLIKLERI[i];
      //ör : e_fatura1.png değerini oluşturmak  e-Fatura --> e-fatura --> e-fatura1.png
      var urunKucukResim =
          Strings.URUN_ADLARI[i].toLowerCase() + "${i + 1}.png";
      //ör : e_fatura1.png değerini oluşturmak  e-Fatura --> e-fatura --> e-fatura_buyuk1.png
      var urunBuyukResim =
          Strings.URUN_ADLARI[i].toLowerCase() + "_buyuk${i + 1}.png";

      Urun ekelenecekUrun =
          Urun(urunAdi, urunKodu, urunOzellik, urunKucukResim, urunBuyukResim);
      gecici.add(ekelenecekUrun);
    }
    return gecici;
  }
}
