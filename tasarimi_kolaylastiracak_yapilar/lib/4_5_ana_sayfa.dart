import 'package:flutter/material.dart';
import 'package:flutter_dersleri_bolum2/models/5_veri.dart';

class AnaSayfa extends StatefulWidget {
  //5.DERS:  SAYFADA KALDIĞIMIZ YERDEN DEVAM ETME 2: aşağıdaki kodu diğer sayfadaki key değerimizi alıp bu sayfanınında üst sınıfına göndermek için düzenledik ve artık bu key burada kullanılabilir hale geliyor
  //!  5.DERS:  SAYFADA KALDIĞIMIZ YERDEN DEVAM ETME 3 ve artık bu k değerinde o anda ki scrool un index i var artık bir şey yapmaya gerek yok sayfalar arası geçiş yaptığımızda sayfa kaldıüı yerden devam edecek bu şekilde arama kısmı çalışyor fakat ana sayfa kısmı çalışmıyor bunu sebebi arama sayfasında açık olan elemanın scroldaki yeri index i int olarak saklanırken burda ise bool ifadeler söz konusu yani expanded olup olmamayacağı bool ifadelerce saklanıyor .bunun için expansionTile tanımladığımız yere gidiyoruz
  const AnaSayfa(Key k) : super(key: k);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Veri> tumVeriler = [];
  @override
  void initState() {
    super.initState();
    tumVeriler = [
      Veri("Biz Kimiz", "Biz kimimizin içeriği buraya gelecek", false),
      Veri("Biz Neredeyiz", "Biz neredeyizin içeriği buraya gelecek", false),
      Veri("Misyonumuz", "Misyonumuzun içeriği buraya gelecek", false),
      Veri("Vizyonumuz", "Vizyonumuzun içeriği buraya gelecek", false),
      Veri("iletişim", "iletişim içeriği buraya gelecek", false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tumVeriler.length,
      itemBuilder: (BuildContext context, int index) {
        //EXPANSİONTİLE yeni bir widget ListTile gibi ama burda açılıp kapanma durumu var
        return ExpansionTile(
          //!5.DERS:  SAYFADA KALDIĞIMIZ YERDEN DEVAM ETME 4 : ve buraya her bir elemanın bir birinden ayrıt etmek için bir anahtar daha geçmemiz lazım bu key i burda doğrudan parametre içinde oluşturuyoruz ve burda key leri birbirinden ayrıt etmek için listWiew.builder ın index değerini kullanabiliriz ve böylece her birine ayrı bir key tanımlamış oluyoruz.
          key: PageStorageKey("$index"),
          initiallyExpanded: tumVeriler[index]
              .expanded!, //initiallyExpanded: ilk açılışta ExpansionTile açık mı olacak kapalımı olacak
          title: Text(" ${tumVeriler[index].baslik}"),
          children: [
            Container(
              color:
                  index % 2 == 0 ? Colors.red.shade200 : Colors.yellow.shade300,
              height: 100,
              width: double.infinity, //olabildiğince yayıl
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(tumVeriler[index].icerik!),
              ),
            )
          ],
        );
      },
    );
  }
}
