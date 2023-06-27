import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/all_providers.dart';


//!3.DERS 1.KISIM BU DOSYADAKİ BÜTÜN PROVİDERSLERİ SİLİP ORTAK BİR DOSYAYA TAŞIDIK ÇÜNKÜ ONLAR GLOBAL İSTEDİĞİ YERDEN ERİŞİLEBİLİRSER BUNDAN DOLAYI ORTAK BİR YERDE TOPLADIK


class RiverpodBasics extends StatelessWidget {
  const RiverpodBasics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo uygulamasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //title: 'Riverpod' sildik provider tanımladık diye
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // required this.title sildik provider tanımladığımkız için artık bu değeri dışarıdan almaya gerek yok
  const MyHomePage({super.key});

  //final String title; providerden dolayı yorum satırı yaptık gerek kalmıyor 

 // int _counter = 0; provider dan sonra gerek kalmadı 
  @override
  Widget build(BuildContext context) {
    debugPrint("MyHomePage build tetiklendi");
    return Scaffold(
        appBar: AppBar(
          //!2.DERS 4.KISIM
          //todo: 1.yol
          //yukarda tanımladığım providerları widgetlarımda kullanma yöntemi: provider bize Consumer() diye widget sunar bunun anlamı tüketici demek provider sağlayıcı demek bize burda string bir değer sağlıyor consumerda onu tüketmeye yarıyor ve bu bizden builder yapısı bekliyor builder widget bekliyor onun içinde de context ,ref, child var.      ref: oluşturduğumuz providerlara erişmek için kullanırız.ref ile başka providerlara erişebiliriz    child: burda okuduğumuz değerlerle ortaya koyacağımız yapılar için kullanacağımız şey
          title: Consumer(
            builder: (context, ref, child) {
              var title = ref.watch(titleprovider);//yukarda tanımladığımız titleProvider ın bize returnladığı değere eriştik
              return Text(title);
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:const <Widget>[
               MyText(),
              MyCounterText(),
            ],
          ),
        ),
        floatingActionButton:const MyFloatingActionButton());
  }
}

//!2.DERS 5.KISIM
//todo: 2.yol
class MyText extends ConsumerWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("MyText build tetiklendi");
    return Text(ref.watch(textProvider));
  }
}

// ignore: must_be_immutable
class  MyFloatingActionButton extends ConsumerWidget {
  
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    debugPrint("MyFloatingActionButton build tetiklendi");
    return FloatingActionButton(
       //!2.DERS 8.KISIM
       //bu butona tıklanıldığında sayac değerimizi okuyup onuda bir arttırmamız gerek collBack fonksiyonlarda collBack demek uygulama çalıştıktan sonra bilgi veren 
      onPressed: () {
        var deger = ref.read(sayacStateProvider.state).state++;//burda okuduğum değer provider ın kendisi değil içinde tuttuğu veri sonrsında da bunun state nide bir arttır diyoruz
        //todo: bizim sayaç uygulamamzıdaki state dediğimiz veri benim uygulamamın durumu sayacımdır yani burdaki int degerdir. ve bu statemiz immutable  yani fianl değişmez butona bastığımızda değişiyor evet ama bu her bir etkileşimde her seferde ağacımıza yeni bir sayac objesi vereceğiz yani sayacım 5 6 olud güncellemiceğiz içinde 6 olan yeni bir nesne vereğiz. ve bu kodlarımızı arttırma azaltma internete çıkma vb ayrı bir dosyada ele alacağız böylece bakımı hata çıkarsa onarılması kolaylaşacak 
        
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

class MyCounterText extends ConsumerWidget {
  const MyCounterText({super.key});
  @override
  Widget build(BuildContext context ,WidgetRef ref ) {
  debugPrint("MyCounterText build tetiklendi");
    //!2.DERS 7.KISIM
    var sayac = ref.watch(sayacStateProvider);
    return Text(sayac.toString(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
