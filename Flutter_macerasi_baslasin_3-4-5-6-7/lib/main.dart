//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(
      MyApp()); //MaterialApp() herşeyin temelidir ve runApp bir widget alır MaterialApp de bir widget olduğu için sorun yaşamayız
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MaterialApp birçok özellik barındırır ama zorunlu bir parametresi var oda home: bu şu anlama gelir sen bir uygulana geliştiriyorsun bu uygulamanın başlangıç noktası hangi widget olmalı diyor  sen buraya gidip text te yazabilirsin Text te bir widget
    //flutter bize Materialdisaigner ın ilkelerine bağlı olacak şekilde güzel bir widget sunar bize o da Scaffold widgetter Nasılki MaterialApp nasılki en temel Witgettı Scaffold witgetta appBar mı koyacan bak bende onunu yeri var diyor soldan sağa bir menü mü çıkartacan bende onun yeri var gibi bir uygulama geliştirirken ihityacımız olan şeyler Scaffold witgetında var
    //Genillikle bir uygulama geliştirirken MaterialApp i oluştururuz ondan sonra oluşan her sayfa için Scaffold oluştururuz
    //Scaffold un ise body gibi bir değeri var body ise bunun içine koyacağımız ana veriler mesela şu an biz text widget koyacağız
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Colors
            .yellow, //Scaffold umuza renk verdik container kavramını daha iyi anlamak için
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "başlık",
            style: TextStyle(
                backgroundColor: Colors.red, fontSize: 20, color: Colors.black),
          ), //appbar a bir yazı yazmak istiyorum title bir widget bekliyor ve ben text in bir widget olduğunu biliyordum
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
        ), //appBar preferdsize bekliyor preferedsize AppBar sınıfınınn üst sınıfı o yüzden AppBar() yazdık
        body: Center(
          heightFactor:3, //içindeki parentin byutuna bakar ve onun 3 katı yer kaplar
          widthFactor: 3,
          child: Container(
            //container da alignment demek alignmentın içindeki şeyin nerde olacağını belirliyor
            alignment: Alignment.center,
            //alignment: Alignment(1,1), //değerleri kendimiz girdik x ve y düzlemi bazında

            //alignment bizden AlignmentGeometry isityor fakar bu abstract class abstract classlardan nesne üretemiyorduk o yüzden bunu öyle kullanamyıruz onun yerine AlignmentGeometry den türetilmiş alt sınıflarını kullnıyoruz extends olmuş sınıfını kullancağız mesela dedikki Alignment diye bir şey var mı baktık ki var ona ctrl diyip tıklarsak bakıyoruz ki AlignmentGeometry den extends olmuş tam istedğim şey olmuş center a ctrl yapıp tıklarsakta bakıyoruzki bunlar bir sabit ve kurucu sonksiyonlarına değer gönderiyor bunu bende yapabilirim diyip center ı silip onun yerine değerler yazıp containerıma ekliyeceğim şeylerin nereye geleceğini söyleyebilirim

            width: 200,
            height: 200,
            constraints: BoxConstraints(
                maxHeight: 300,
                minHeight: 300,
                minWidth: 250,
                maxWidth:
                    250), //bu bize containerımızın kaplayacağı max ve min boyutları veriyor
            margin: EdgeInsets.all(
                10), //margin bir widget ın diğer witget lar ile olan araasındaki boşlukları belirtmek için kullanılır.EdgeInsetsGeometry istiyor ama EdgeInsetsGeometry bu abstract o yüzden bundan türetilmiş alt sınıflara bakmam gerekecek EdgeInsets bu ondan üretilmiş bir alt sınıf

            padding: EdgeInsets.all(
                40), //benim containerım içerisinde text widget ını tutuyor eğer container ile içindeki widget arasındaki mesafeyi ayarlamak için padding kullanırız

            color: Colors.pink,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red[300],
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
                alignment: Alignment.topRight,
                child: Text(
                  "ad" * 2,
                  textAlign: TextAlign.center,
                  //bu align işlemi satırda yazıyı ortalar ama ben containerin ortasına yazıyı getirmek için containerın kendisinde alignment işlemi yapmalıyız yukarda yaptığımız gibi
                  //Container öyle bir şey ki eğer içi boş olursa parentini kaplar ama eğer containerin içinde child varsa onu kaplar ama yukarda yaptığım gibi height weight verdiğimde fill özelliğinden çıkar verdiğim değerlerkadar yer kaplar ama bir istisna var eğer containerın alignmentı varsa ve içinde de çoğu olsa bile paretn ı kadar yer kaplar
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //buton oluşturuyoruz
          onPressed: () {
            //OnPressed isimlendirilmemiş fonksiyon basınca ne yapmalıyım anlamına geliyor
            debugPrint("tamadır");
          },
          backgroundColor: Colors.grey, //butonun rengi
          child: Icon(
            //buton bizim için widget onun içine icon eklemek için child kullandık
            Icons.access_alarm,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
