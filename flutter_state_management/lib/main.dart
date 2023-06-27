import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/4_state_notifier_kullanimi.dart';
import '2_riverpod_basics.dart';

void main() {
  //runApp(const MyApp());

  //!2.DERS 2.KISIM : uygulamamızın en kök yerini main kısmını yani providerScope diye bir widgetla sarlamamız gerek gidip onu sarmaladık
  runApp(const ProviderScope(
    child: StateMotifierKullanimi(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MyText(),
              MyCounterText(sayac: _counter),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(
          onArttir: () {
            setState(() {
              _counter++;
            });
          },
        ));
  }
}

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

// ignore: must_be_immutable
class  MyFloatingActionButton extends StatelessWidget {
  //floating action button işlem yapması için counter değerini buraya yollarız arttırıp arka olana geri yollarız. genelde biz şunu yaparız bir butona vs tıklanıldığında bunla ilgili bilgiyi üst sınıfımıza burda floatingActionButton _MyHomePage in alt sınıfı gibi düşünürsek _MyHomePage haber vermemiz gerekir bu buton tıklandı ne yapmak gerekiyorsa yap işte bu gibi durumlarda CallBack fonksiyonlardan yaralanırız. yukarı widgetlardan aşağıya değer göndermeyi kurucular üzerinden yapabiliriz ama aşağı widgetten yukarı widgeta eleman göndermek için CallBack fonksiyonlarıdan yaralanırız. widgetlarımızı ayırdık fakat okunması yazılmsı zor. bunların yerine state management yöntemlerinden biri olan //!RİVERPOD U KULLANACAĞIZ. bu sayfada callback ve kurucu üzerinden veri gönderme iişlemleri kalsın yeni bir sayfa açalım
  VoidCallback onArttir;
  MyFloatingActionButton({super.key, required this.onArttir});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onArttir();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

class MyCounterText extends StatelessWidget {
  final int sayac;
  const MyCounterText({super.key, required this.sayac});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$sayac',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
