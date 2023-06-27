import 'package:flutter/material.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_detay.dart';
import 'package:tanitim_rehberi_uygulamasi/urun_listesi.dart';

import 'data/model/urun.dart';

class UrunItem extends StatelessWidget {
  //bir tane listemin elemanı için o anki urun listesine ihtiyaç duyuyorum o yüzden bu sınıfın kurucu fonksiyonuna mutlaka şunu diyoz yani burası çalıştırılacaksa mutlaka final olarak tanımlamış olduğum Urun veri tipinde değişkenimi tanımlasın
  final Urun listelenenUrun ;
  const UrunItem( this.listelenenUrun ,{super.key});

  @override
  Widget build(BuildContext context) {
    var myTextStyle =   Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {

              /*ONGENERATOR YAPMAK İÇİN KAPATTIK
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UrunDetay(listelenenUrun);
                },
                ),
                );
              */
              Navigator.pushNamed(context, "/urunDetay" ,arguments: listelenenUrun );
             
            },           
            leading: Image.asset("images/"+listelenenUrun.kucukResim , fit:BoxFit.cover ,),
            title: Text(listelenenUrun.urunAdi , style: myTextStyle.headline5 ,  ),
            subtitle: Text(listelenenUrun.urunKod, style: myTextStyle.subtitle1,),
            trailing: Icon(Icons.arrow_forward_ios , color: Colors.orange,),
          ),
        ),
      ),
    );
  }
}