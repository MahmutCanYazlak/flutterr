import 'package:flutter/material.dart';

class CardVeListtileKullanimi extends StatefulWidget {
  const CardVeListtileKullanimi({super.key});

  @override
  State<CardVeListtileKullanimi> createState() =>
      _CardVeListtileKullanimiState();
}

class _CardVeListtileKullanimiState extends State<CardVeListtileKullanimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Material App Bar")),
        body: Center(
          child: ListViewKullanimi(),
        ));
  }
  //eğer elamanlarımız ekrana sığmıyorsa bunun 2 yöntemi var 1)SingleChildScrolView: bu yöntemdede bir child tek alır 2)ListView: bu yöntem colomn ve row gibi children listesi alır birden fazla widget koyabilirsin fakat bu 2 yöntem pek tercih edilmez hafıza dostu değildir burda koymuş olduğun elemanlar haafızada yer tutar 3-5 elemanın var ve bunun ekrana sığmayacağını düşünürsen evet kullanabilirsin fakat eğer bir çok elemanın varsa kullanılması pek tercih edilmez elemanlar arasında aşağı indiğin zaman ekranda gözükmeyen yapılar hala yukarda yerinde tutulurlar flutter da kullanılacak bir örnek (o yapıda dinamik değil)görmek için yeni bir dart projesi oluşturalım ismide listview_kullanımı.dart olsun bu sayfadan sonra git ve ona bak

  //1.YOL
  ListView ListViewKullanimi() {
    return ListView(
      reverse: true,//içindeki childrenları tersten sıralar
          children: [
            Column(
              children: [
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
                tekListeElemani(),
              ],
            ),
            Text("deneme"),
            ElevatedButton(onPressed: () {
              
            }, 
            child: Text("merhabalar"))
          ],
        );
  }
  //2.YOL
  //SingleChildScrollView yeni widget ekrana sığmayan elemanlarımızı bunun içine yazarsak eğer aşağı doğru kayma özelliği kazandırır
  SingleChildScrollView SingleChildScrollKullanimi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
          tekListeElemani(),
        ],
      ),
    );
  }

  //Card ve divider birleşik bir yapı gibi düşünebiliriz bunun için bunu bir method haline getirdik
  Column tekListeElemani() {
    return Column(
      children: [
        //CARD yeni bir widget bize bir kart yapısı sunur
        Card(
          color: Colors.red.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //LİSTTİLE bir widgettır ve bu bir card yapısında ihityacımız olan şeyleri bize hazır bir şekilde sunuyor
          child: ListTile(
            //leading bizden bir widget bekliyor leading dediği bizim cardımızın sol baş tarafı
            leading: CircleAvatar(
                backgroundColor: Colors.amber.shade100, child: Icon(Icons.add)),
            title: Text("başlık kısmı"),
            subtitle: Text("alt başlık kısmı"),
            trailing: Icon(Icons
                .access_alarms_sharp), // trailing cardımızın sağ baş tarafı
          ),
        ),
        //DİVEDER iki eleman arasını bölen bölücüdür
        Divider(
          color: Colors.red,
          height: 15, //yukardaki yapı ile arasındaki boşluğu belirtiyor
          thickness: 5, //bölücünün kalınlığı
          indent: 20, //başlangıçta olan boşluk
          endIndent: 20, //sonda olan boşluk
        ),
        ElevatedButton(onPressed: () {
          
        }, child: Text("deneme") , style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12)),)
      ],
    );
  }
}
