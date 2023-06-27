//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _img1 =
      "https://cdn.britannica.com/55/174255-050-526314B6/brown-Guernsey-cow.jpg";
  String _img2 =
      "https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.greenAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Admin's Panel"),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: Container(
          color: Colors.purple,
          child: Row(
              mainAxisSize: MainAxisSize.max, //normalde container çocuğu kadar yer kaplar çocuğu row bizde çocuğunun x eksenindeki kapladığı yeri min yaptık aksi taktirde row bir satırı komple kaplar ama biz içindekiler ne kadar yer kaplıyorlarsa sende o kadar yer kapla dedik fakat şimdilik bunu max yapıyoruz sebebi row un içindeki elemanlar arasındaki boşlukları alignment ayarı yapmak için oranın max olması gerekir
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //içindeki elemanları x eksenine göre alignment işlemi yapar

              //içindeki elemanları y eksenine göre alignment işlemi yapar fakat bunun için gidip containera height vermeliyz

              //crossAxisAlignment: CrossAxisAlignment.stretch,

              //Children içerisine birden çok widget koyabiliyorsun children widget tutan bir listetir
              children: FlexibleContainer //bulisteyi dışarı method olarak aktardık bu bir liste istediği için getter tipinde liste yaptı
              ),
        ),
      ),
    );
  }

  List<Widget> get ekranaSigmayanContainer {
    return [
      //içine widgetlarımızı yazarız
      Container(
        width: 100,
        height: 100,
        color: Colors.yellowAccent,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.orange,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.pinkAccent,
      ),
    ];
  }

//containerımız bir row içerisine sığmayınca levha hatası alıyorsun containerımız bir row içerisine sığdırmak için Expanded uyguluyoruz expanded demek şeklin boyutlarından feragat et ve satıra sığdıracak şekilde boyutlandır demek expanded diyince size mızın hiçbir önemi kalmıyor hepsi bir satıra sığacak şekilde boyutlandırılıyor ama biz diyelimki sarı cantainerın diğerlerinden 2 kat daha büyük olmasını istiyorum işte o zamanda flex değeri işin içine giriyor flex değeri default 1 dir
  List<Widget> get ExpandedContainer {
    return [
      Expanded(
        flex: 2,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.yellowAccent,
        ),
      ),
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ),
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      ),
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.orange,
        ),
      ),
      Expanded(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.pinkAccent,
        ),
      ),
    ];
  }

//Flexible da taşma sorununu ortadan kaldırmak için kullanılıyor expanded da height ve width in anlamı kalmıyor verilen alana elemanlarımızı sığdırmaya çalışıyor ama Flexibleda max verilen width height boyutu ol ama eğer verilen alana elemanlarımız sığmıyorsa o zaman küçüledebilirsin 

List<Widget> get FlexibleContainer {
    return [
      //içine widgetlarımızı yazarız
      Flexible(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.yellowAccent,
        ),
      ),
      Flexible(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
      Flexible(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ),
      
    ];
  }


  //body yerine yazacaksın 
  Widget Container_Dersleri() {
    //normalde fonksiyonumuz dönüş tipi Center dı fakt biz onu Widget yaptık sebebi Center sınıfının üstü Widgettır
    return Center(
      child: Container(
        //color: Colors.red,   //Container eğer çocuğu varsa çocuğu kadar yer kaplar ve arka planı kırmızı yaptı fakat decoration dada gidip containera renk vermeye çalıştığımızda hata alırız

        /*
          child: FlutterLogo(
            size: 200,
          ),
          */
        child:
            Text("can", style: TextStyle(color: Colors.green, fontSize: 129)),

        padding: EdgeInsets.all(
            20), //bunun sebebi shape de circle yaptığımızda yuvarlak logonun altında kalıyordu bizde dedikki padding ile containerı içindeki logo widgetından uzaklaştıralım

        //dekarasyon işlemleri için decoration parametresini kullanırız
        decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.rectangle, //şekil sağlar 
            border: Border.all(width: 4, color: Colors.blue), //çerçeve yapıyor 
            borderRadius: BorderRadius.all(
              Radius.circular(40), //border radius bizim borderımızın kenarlarını yumuşatmayı sağlıyor
            ),
            image: DecorationImage(
                image: NetworkImage(_img2),
                fit: BoxFit.scaleDown,
                repeat:
                    ImageRepeat.repeat), //fit resmin nasıl sığacağını ayarlar
            boxShadow: //boxShodow a baktığımız zaman bizden içinde boxShodow ların olduğu liste istiyor kaç tane yapacaksan hepsini listenin bir elemanıymış gibi vereceksin gölgelendirme sağlıyor 
                [
              BoxShadow(
                  color: Colors.green, offset: Offset(10, 10), blurRadius: 20),
              BoxShadow(
                  color: Colors.grey,
                  blurStyle: BlurStyle.normal,
                  offset: Offset(-10, -10),
                  blurRadius: 20)
            ]
            //decaration nun image özelliğini görebilmek için containera çocuk olarak atatığımız  FlutterLogo widgetını yorum satırı yapıyoruz
            ),
      ),
    );
  }
}
