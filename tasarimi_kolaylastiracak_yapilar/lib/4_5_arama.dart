import 'package:flutter/material.dart';

class AramaSayfasi extends StatelessWidget {
  //5.DERS:  SAYFADA KALDIĞIMIZ YERDEN DEVAM ETME 2: aşağıdaki kodu diğer sayfadaki key değerimizi alıp bu sayfanınında üst sınıfına göndermek için düzenledik ve artık bu key burada kullanılabilir hale geliyor ve bunu yapınca arama kısmında kaldığımız yerde deavm etme çalışır fakat anasayfa kısmında sorun olacak onun için oraya gidip sorunu çözüyoruz
  const AramaSayfasi(Key k) : super(key: k);

  @override
  Widget build(BuildContext context) {
    //BUTTOM NAVİGATOR BAR VE SAYFALAR ARASI GEÇİŞ 4:
    return ListView.builder(
      itemExtent: 200,
      itemBuilder: (BuildContext context, int index) {
        //MATERİAL :bir öğede elevation , border radius gibi özellikleri yoksa onu MATARİAL WİDGeti ile sarmalayabilirsin
        return Container(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            color: index % 2 == 0 ? Colors.orangeAccent : Colors.indigoAccent,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        );
      },
    );
  }
}
