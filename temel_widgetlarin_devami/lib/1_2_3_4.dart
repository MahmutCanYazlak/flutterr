//main dart dosyamız çok fazla karışık olduğu için projemizi parçalara böldük lib e sağ tıklayıp new file diyerek dart dosyası oluşturduk ve bunun flutter olduğunu belirtmek için flutterı import ettik 
import 'package:flutter/material.dart';


//STATELES WİDGET içerisinde build fonksiyonunu override etmeliyiz bunun sebebi  StatelessWidget ın abstract fonksiyon olması
//buil fonksiyonu içerisindeki yapılar sabit yapılardır kod çalışırken bunlar oluşur ve daha değişmez değişen yapıları yani ekrana konulan şey herhangi bir etkenle örneğim veritabanından verinin gelmesiyle butonun basılmasıyla değişiyorsa o yapı statelessWitget içine yazılmaz ama eğer değişmicekse biz onu stateles witget yaparız

class MyCounterPage extends StatefulWidget {
  const MyCounterPage({super.key});

  @override
  State<MyCounterPage> createState() => _MyCounterPageState();
}
class _MyCounterPageState extends State<MyCounterPage> {
  // CONTEXT YAPISI: widgetımızın nereye build edilmesi gerektiğini söylüyor aynı zamanda en aşağıdan en yukarıya doğru veri taşıma işlemlerinde de kullanılıyor yani context sayesinde üst yapılardaki verileri okumamızı sağlıyor
  int _sayac = 0 ; //sayacı burda tanımladık ki class içinde her yerde kullanabilelim
  @override
  //bu yapıyı main içerisinde çağıracaksan eğer clasımız Scaffoldu da barındırdığı için main de çağırırken home kısmına gidip class ismini yazacaksın
  Widget build(BuildContext context) { 
    debugPrint("MyhomePage çalıştı");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Temel Widget",
          textAlign: TextAlign.end,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Butona basılma sayısı", style: TextStyle(fontSize: 23)),
            Text(_sayac.toString(), style: Theme.of(context).textTheme.displayLarge) //context yapısı sayesinde MyApp deki theme ulaşıp temayı değiştik 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sayacArttir();
          debugPrint("butona basıldı basılma sayısı $_sayac");
        }, child: Icon(Icons.add),
      ),
    );
  }
  //normalde sayac++ yapıyoruz evet sayaç değerimizin arttığını Debug Console den de görüyoruz fakat emulatör üzerinden değerimiz artmıyor çünkü flutter arttığını bilmiyor her seferinde gidip hot reload yapmalıyız ki build yapısı çalışsın ama kullanıcı gidip hot reload yapmamaz onun için aşağıdaki setState yapısını kullanıyoruz
  //setState yapısı sayesinde ilgili widget ın build yapısı tekrar çalışıyor
  int sayacArttir() {
    //sayac değerinin nereye yazdığın pek önemli değil çünkü buranın çalışma mantığı fonksiyonun içindekileri yapar daha sonra gidip build yapısını çağırır
    setState(() {
     _sayac++ ; 
      
    });
     return _sayac;
  }
}