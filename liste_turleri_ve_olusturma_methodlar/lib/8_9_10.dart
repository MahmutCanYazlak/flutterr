//ListView lerde olduğu gibi GridViewde de dinamik yapılar vs dinamik olmayan yapılar var dinamik yapı GridView.builder() dır

import 'package:flutter/material.dart';

class GridViewOrnek extends StatelessWidget {
  const GridViewOrnek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid View Örnek")),
      body: Center(
        //GRİDVİEW genelde count tercih edilir ListView e benzer bir  yapısı vardır. içindeki witgetları senin crossAxisCount a verdiğin değere göre sıralar  mesela sen 3 dediysen ve scrollDirection default vertical old. için bir satıra 3 eleman kor geri kalanını bir alt satıra geçirip ordan sıralar sen içerdeki widgetların boy değeri width falan versende onları dikkate almaz
        child: GridViewBuilderKullanimi(),
      ),
    );
  }

  GridView GridViewBuilderKullanimi() {
    //SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: X) bu GridView.Coun gibi bir satırda olması gereken eleman sayısını yazıyorsun
    //SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100) bu da GridView.extent gibi bir elemanın max boyutunu verir
    //itemCount listede kaç tane eleman olacağını söyler
    return GridView.builder(
      itemCount: 100,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        //GESTURE DETECTOR PROPERTİSİ(özelliği): normalde listelerde OnTop ile tıklnma olayını yakalayabiliyordun bu yapımıza baktığımız zaman bir tıklanma olayı atamak istediğimiz zaman içinde bir buton yok onTop özelliği de yok çünkü containerın içindesin işte o zaman ekran ile etkileşim olma durumunda yani ne ekran ile etkileştiği zaman bu çalışsın diye dediğimizyapıyı GestureDetector ın child kısmına koruz biz chil kısmana containerımızı koyduk. bu containerın (GestureDetector'ın childının bittiği kısma gidip on. yazdığımız zaman(yada işte child kısmı başlamadan önce yani childin kaplayacağı özellik olduğu için child sınırlarının dışına gidip on. yazdığında ) bütün olayaları görüyoruz uzun basılma durumu tek tıklanma çift tıklanma durumu vb.)
        return GestureDetector(
          onLongPress: () {
            debugPrint("uzun tıklanıldı $index ");
          },
          onDoubleTap: () {
            debugPrint("çift tıklanıldı $index ");
          },
          onHorizontalDragStart: (e) {
            debugPrint("buton kaydırıldı  $e ");
          },
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.red[100*((index+1)%8)],
                  title: Text("bir kez tıklandı $index"),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.red, width: 3, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      blurStyle: BlurStyle.inner,
                      color: Colors.blueGrey,
                      offset: Offset(7, 5))
                ],
                //shape: BoxShape.circle,  //borderRadius ile birlikte kullanılınca hata alıyoruz
                color: Colors.teal[100 * ((index + 1) % 8)],
                //GRADİENT renk geçişi sağlar bunu yaparsan eğer color özelliği deaktif oluyor
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.white,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                image: DecorationImage(
                    image: AssetImage("assets/image/saray.jpeg"),
                    scale:
                        3) //eğer widget isteseydi image.aset image.network yazardık ama  ImageProvider bekliyorsa doğrudan sınıfın kendi adını yazmalıyız AssetImage gibi
                ),
            margin: EdgeInsets.all(20),
            //color: Colors.teal[100 * ((index+1) %8)], //decoration ve burda iki farklı renk tanıyamayız proje patlar
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("index sayisi $index",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        );
      },
    );
  }

  GridView GridViewCountKullanimi() {
    return GridView.count(
      crossAxisCount:
          3, //gridview defaultta yukardan aşağıya doğru kaydırmaya sahip crossAxisCount: soldan sağa kaç tane eleman konulacak onu söyler
      scrollDirection: Axis
          .horizontal, //Scroll özelliğimizi bu sefer soldan sağa yaptık  soldan sağa yapınca mainAxis x ekseni crossAxis y  ekseni oldu ve scroll özelliğimiz aşağı doğru değil yana doğru olur
      primary: true, //kaydırma efektini açıp kapaya yarar pek önemli değil
      padding:
          EdgeInsets.all(10), //her elemanın etrafında 10 pixellik boşluk olsun
      crossAxisSpacing: 15, //iki sütun arasındaki boşluk
      mainAxisSpacing: 40, //iki satır arasındaki boşluk
      reverse: true, //elemanları tersten sıralar
      children: [
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
      ],
    );
  }

  //GridView.count a benzer fakat burda crossAxisCount:..Double.. yoktur maxCrossAxisExtent: ..Double.. vardır bunun anlamı şu: şimdi benim elemanlarım yukarıdan aşağıya doğru akıyorsa CrossAxisin soldan sağa doğru olmalı maxCrossAxisExtent:X ve buraya verdiğim değerde soldan sağa(scrollDirection:Axis.vertical ise) tek bir elemanın max büyüklüğü X olacak GridView.count a biz bir satıra X tane sığdır diyorduk bunda ise genişliğe göre ayarlıyoruz böylece her bir elemanın max genişliği X olacak şekilde ekrana sığdıracaktır
  Widget GridViewExtendKullanimi() {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      scrollDirection: Axis.vertical,
      primary: true,
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 15,
      mainAxisSpacing: 40,
      children: [
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text("deneme")),
      ],
    );
  }
}
