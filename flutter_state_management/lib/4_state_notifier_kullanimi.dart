import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/3_sayac_manager.dart';
import 'package:flutter_state_management/5_future_builder.dart';
import 'package:flutter_state_management/all_providers.dart';

//!4.DERS 1.KISIM: 3.derste oluşturmuş olduğumuz stateNotifierProvider ı kullancağız burada ilk başta all_proviers.dart dosyasına gidip yeni bir provider tanımı yapıyoruz 

class StateMotifierKullanimi extends StatelessWidget {
  const StateMotifierKullanimi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo uygulamasi',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    debugPrint("MyHomePage build tetiklendi");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Consumer(
            builder: (context, ref, child) {
              //!4.DERS 3.KISIM appbar ımızı text kısmını  4.ders 2.kısım da oluşturduğumuz klasik providerdan çektik 
              var title = ref.watch(titleprovider2);
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
              CiftMiWidget(),
              ButtonGit(),
            ],
          ),
        ),
        floatingActionButton:const MyFloatingActionButton());
  }
}

class ButtonGit extends StatefulWidget {
  const ButtonGit({super.key});

  @override
  State<ButtonGit> createState() => _ButtonGitState();
}

class _ButtonGitState extends State<ButtonGit> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>const FutureBuilderKullanimi()));

    },  child:const Text("future Builder"));
  }
}

//!5.DERS 2.KISIM
class CiftMiWidget extends ConsumerWidget
{
  const CiftMiWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("ÇiftMi widget tetiklendi");
     return Text(ref.watch(CiftMiProvider) ? "ÇİFT" : "TEK");
  }

}

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
      onPressed: () {
        // ref.read(sayacNotiferProvider) Bu bize SayacModel i verir
        //arttirma azaltma methodlarını SayacManger sınıfında olduğundan bu sınıfa erişmek için .notifier kullanılır çünkü biz bu provider ı tanımlarken dedikki senin statein yani ben seni izlediğim de SayacModel i ver ama businies Logic kosların SayacManager in içinde burdaki değişiklikleri bana söyle ondan dolatı notifier diyoruz ve bunu diyince de StateNotifierProvider ı tanımladığımızdaki 1.parametre olarak yazdığımız sınıfı verecek
        ref.read(sayacNotiferProvider.notifier).arttir();        
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

  //!4.DERS 4.KISIM artık burda değerimizi sayacProvider dan değilde oluşturduğumuz sayacNotiferProvider den alıyoruz bunun içinde gidip all_providers.dart kısmına bu dosyanın provider ını oraya oluşturuyoruz
    var sayac = ref.watch(sayacNotiferProvider);//artık sayac değişkenin veri türü sınıfı olan SayacModel türünde yani bir nesne aslında  sayac diyip 
    return Text(sayac.sayacDegeri.toString(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
