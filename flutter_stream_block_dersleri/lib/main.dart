import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stream_block_dersleri/1_sayac_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key, required this.title});

  final String title;
  final SayacViewModel sayacViewModel = SayacViewModel(); //?sınıftan nesne ürettik ki sınıf içindeki Mystream değişkenine erişelim ve bunu yazınca doğrudan sayac widgetıma değer atanıyor atma yeri steta tanımlarken kurucu üxerinden değer ataması yapıyor

  @override
  Widget build(BuildContext context) {
    print("build methodu tettiklendi");//!Stream yapısını kullandığımız zaman bir değişim durumunda stete min hepsi güncellenmiyor en başta bir kere build methodu çalışır ekrana widgetlar basılır ve daha sonra StreamBuilder ile sarmaladığımız  yerleri stream ile dinleyip değişiklikte sadece streamBuilder ile sarmaladığımız kısım tekrar basılır
    return Scaffold(
      appBar: AppBar(
        //todo: ilk gidip sayac değerimi arttırdım daha sonra gidip appBar içinde de  bu değeri gösterilm dedik fakat hata aldık  bu hatanın sebebi iki yerde streami dinleme sebebimizdi düzeltmek için gidip controllere broadcast eklemesi yaptık ama yine hata alıdk bunun sebebi ise broadcast streamler eventleri bufferlamaz bu şu demek 1_sayac_view_model.dart dosyasında kurucu üzerinden sink ile ilk değeri atatıyorduk fakat buid tekiklenmeden biz bu sink ile kurucu üzerinden ilk değerimizi sayac=0 atadığımızda bu yayın yapıyor sinke sayac 0 olarak eklendi diye ama henüz build tetiklenmediği için bu yayını dinleyen herhangi bir yapı olmadağı için bundan dolayıda bu değer bufferlanmadığından görülmüyor ve hata alıyotuz klasik streamController da bufferlandığı için herhangi bir sorun yaşamamıştık bunu çözmek iin gidip 1_sayac_view_model.dart dosyasına sayac= 0 olduğunu atadığımız yeni bir fonksiyon yazıyoruz init() isimli ve gelip bu StreamBuilder ın initialData kısmına o init fonskiyonunu çağırıyoruz
        title: StreamBuilder(
          stream: sayacViewModel.myStream,
          initialData: sayacViewModel.init(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(snapshot.hasData ? snapshot.data.toString() : "veri yok" );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          //MyStream.listen() dediğimizde setState bir daha kullanmak zorundayız direkt olarak flutter bize StreamBuilder widgetini kullanırız  
          StreamBuilder<int>(
            stream: sayacViewModel.myStream, //sürekli olarak bu streami takip et lşstenerla dinliyormuşuz gibi yeni değerler geliyor ve ekrana yansıtılıyor
            initialData: sayacViewModel.init(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                child: Text(
              snapshot.hasData ? snapshot.data.toString() : "deger yok",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
              );
            },
          ),
            
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              sayacViewModel.arttir();
              
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              sayacViewModel.azalt();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.minimize_outlined),
          ),
        ],
      ),
    );
  }
}


