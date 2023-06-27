import 'package:flutter/material.dart';

class GlobalKeyKullanimi extends StatelessWidget {
  GlobalKeyKullanimi({super.key});
  //1//normalde sayaç uygulamamızda ana yapımız staefulWidget olur ve bir değişken tanımlar ve setState ile ekrardan bu build yapısını tekrar tekrar en baştan hepsini çizdiriyorduk halbu ki tek değişen şey sayaç değerini gösteren text kısmı güncelleniyor
  //2//yukardan aşağıya doğru veri gönderirken kurucu fonksiyonları kullanabilriz  aşğıdan yukarıya ver gönderirken ise globalKey kullanabiliriz bu globalKey oluşturduğuumz widgetları tanımlayan benzersiz amahatarlar tc no gibi burda da oluşturduğumuz widget a bir key değeri veriyoruz ve o key i kullanarak o widgeta veta state ne erişebiliyoruz burda yapımız StatelesWidget olsun ekranıma bir kez yazılsın her buidde tekrar tekrar güncellenmesin ve ben gidip sayaç değerim için apayrı bir widget oluşturabilirim stateful olacak şekilde SayacWidget isiminde widget oluşturduk ekranda görünen elemanları ne kadar farklı widgetlara bölersek performnas konusunda da o kadar iyi olur
  //4//GlobalKey tanımlama <..> ne tür bir state tutacağını yazıyon buraya
  final sayacWidgetKey=GlobalKey<_SayacWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gloabal Key Kullanimi"),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Text("Butona Basılma Miktarı" , style: TextStyle(fontSize: 25)),
          //5//4 de global Key i oluşturduk fakat oluşan yapıdan SayacWidget ın haberi yok sisitem bir tc oluşturdu fakar gidip can ile ilişkilendirmedi gibi bunu ilişkilendirmemiz lazım oluşturduğumuz bu key SayacWidget tarafından kullanılacak dedik sürekli olarak bir widget oluşturduğumuzda constracture de bir key değeri geliyordu ya işte kullanacağımız yer burası. SayacWidget sınıfında const SayacWidget({super.key}); burdaki super.key e bir alt satırda o widgetı çağırırken isimlendirilmiş parametre olarak bu key değerini gönderiyoruz. artık ben bu key değeri üzerinden SayacWidget ın stete ne yani içine erişebilecem demek kş artık bana lazım olan arttir() fonk. erişebilecem aksi taktirde floatinActionButton dan arttir() eişmemin bir yolu yok
          SayacWidget(key:sayacWidgetKey),
        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //3//aşağıda tanımladığım arttir() methoduna burdan erişmek isityorum işte sorun burda başlıyor burada globalKey kullanılabilir
        //6//sayacWidgetKey.currentState demek : bu key e atatığım widgete eriş onun şu anki state ne (durum , veri) eriş 
        sayacWidgetKey.currentState!._arttir();
        //8//eğer ki bu SayacWidget ı başka bir dart dosyasına taşıyıp burda onun GlobalKey üzerinden state yapısına erişeceksen _ olmamalı yoksa erişemezsin 
      },
      child: Icon(Icons.add)),
    );
  }
}


class SayacWidget extends StatefulWidget {
  const SayacWidget({super.key});

  @override
  State<SayacWidget> createState() => _SayacWidgetState();
}

class _SayacWidgetState extends State<SayacWidget> {
  int sayac = 0 ;
  void _arttir()
  {
   
    sayac++;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Text(sayac.toString(), style: Theme.of(context).textTheme.displayLarge);
  }
}