import 'package:flutter/material.dart';

import 'animasyon_widgetlar.dart';
import 'new_page.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

void main() => runApp(MyApp());

//1- Ticker => saat gibi. flutterda ekranımız sn 60 kare yenileniyor. yani bu ticker sn de 60 kare olacak şekilde çalışıyor ve sürekli olarak benim ekranıma sinyaller yolluyor yani x ms geçti yenile , x ms geçti yenile işte bize bu tickleri sağlayan mibik aralıklarla bizi sinyal yollyan yapımızın adına ticker diyoruz. her bir tick anında ise bizim tickerımız bizim ekranımıza sinyaller yolluyor ve biz bu sinyallere göre bazı değerlerimizi güncelliyoruz ve böylecede karşımıza animasyonlar çıkıyor bu ne aralıkla çalışacak?->biz bunları animasyonumuza örneğin sen bir animasyonsun 3 sn boyunca çalış dediğmizde bu ticker biizm 3 sn boyunca sürekli olarak sinyaller yollayan yapı

//2- Animation=> sadece bir değer bu değeri özel yapan şey ise belli aralıkla yani yaşam döngüsü boyunca belli aralıklarla değişmesi bir yazımız var bunun boyutunu 24 diye ayarlamışız sen 0-1 sn aralığında 24 ten 48 çık dediğimizde orda bir animasyon oluşuyor. ve bu değer değişimi lineer olabileceği gib nonliner de olabilir bunu belli yapıları kullanark yapıyoruz önce hızlı büyü sonra yavaş bir şekilde büyü

//3- AnimationController: animazyonumu control edeceğimiz yapı. yani onu durduran, başlatan gerekirse tekrar ettiren yapıyada biz animation contreller diyoruz animasyonumuzu ilgili animation_controller ile eşleltirdiğimizde ilgili nesne üzerinden animasyonu kontrol edebiliyoruz

//4- Animasyonlarda temel olan iki tane sınf var 1:Twen: 2:Curve
//---tween -> between(baslangıc - bitis)-başlangıç ve bitiş değerleri arasında bana değerler üretiyor controllerda ki lowerBound ve upper bounda ki gibi ama biz tweende farklı değerler verebiliriz renk olarak, alimated olarak bişey verebilirm yani tween controllerdan aldığı double değerleri türüne göre farklı aralıklardaki değerlere dönüştürüyor alignment olur color olur
//--- Curve tween deiğimiz başlangıç ve bitiş arasında lineer doğrusal bir harekt çiziyor curve de ise eğri büğrü ivmelenmeler yapıyor lineer olmayan efektlerde kullanılıyor

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  MyHomePage({Key? key , required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  //!witdh: biz bir sınıfın özelliğini kullanmak istiyorsak extends kullanırdık ama bir tane extends e izin verir sitem eğer başka bir yerdeki özellikleride kullanmak isityorsanda bu sefewr mixin yapılarını kullanırız with diyerekte bu mizin deki özellikleri kullanabiliriz
  int _counter = 0;
  //!2.DERS 1.KISIM
  //controller ın yapamadığı yerlerde devreye animationlar girer mesela dart kordinatında 0,-1 arası değerler lazım controllerında verdiği genelde double değerler 0 ile 1 arasındaki değerleri ihtiyacımız olan 0 -1 değerlerine dönüştür kullan gibi
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      //vsync: ekranı ticker ile senkronize eden nesnedir. ticker sürekli olarak bize sinyaller yolluyor biz burda duration u 3 sn olarak ayaraladık sn 180 karenin değişmesi gerek sürekli olarak bunu control olarak yollamsı gerek ve bu senden TickerProvider istiyor sende this diyerek bu sınıftaki TickerProvider ı kullanabilirsin diyoruz artık ticker belli aralıklarla bana sinyal yollayacak benim sınıfımda bu sinyallere göre işlem yapabilir hale gelebilecek
      //duration: bu animasyon kontrolcüsünün kontorl edeceği animasyonun süresi bunun kontrol ettiği animasyon 3 sn sürsün dedik ve dispose ile bu controlleri silmeyi unutmayalım arkada açık kalmasın diye
      //lowerBound: 3 sn boyunca bu kontrolcü kontrollerini yapsın alt limiti 20 üst limiti 40 olsun bu şu anlama geliyor 20 den 40 kadar değer üretecek double olarak ve bu 3 sn sürecek yani lowerBound ile upperBound da verdiğin değerler arasında double değerler üretilir senin verdiğin duration saniyesi sürecek kadar ben bu sayıları widgetlerımın belli özelliklerine uygulayarak farklı animasyonlar elde edecem. 
      vsync: this,
      duration: Duration(seconds: 3)
    );

      //addListener bu method değişimi dinleyen yapı yukardaki sayılar değiştikçe addListener ın içine bir callback olarak getirilir ve burda sayılar değişiyor ama ekranımda birşeyler değişecekse güncellenecekse bunu setStatle bildirmem lazım
      controller.addListener(() {
      setState(() {
        //debugPrint(controller.value.toString()); //ilgili controller ın o an hangi değerler aldığını görebiliriz
        //debugPrint(animation.value.toString());
      });
    });

    //animatioan adoğrudan Animation() sınıfını veremiyorsun çünkü o bir soyut sınıf
    animation =
        ColorTween(begin: Colors.red, end: Colors.yellow).animate(controller);
        //tween i doğrudan ben animasyona atayamıyorum çünkü tween sınıfına bakarsak Tween AnimeTable sıınıfdan üretilmiş AnimeTable ise direkt abstract sınıf ,  animationa baktığımız da ise alt sınıfı değil işte bunu alt sınıfı yapmak için .animate() diyoruz animate parent istiyor oraya controllerimizi veriyor ve  animate bize geriye animation dönderiyor benim karşıladığım nesnenin rürüde animation du demekki ColorTween(begin: Colors.red, end: Colors.yellow).animate(controller); bu methodun sonunda çıkan nesne aslında bir animation nesnesi oluyor 
        //yukardaki kod kırmızı ile sarı arasında bir geçiş yapmak isityorum ve bu 3 sn içinde gerçekleşecek controller 3 olduğu için 3 sn 

    animation2 = AlignmentTween(begin: Alignment(-1, 1), end: Alignment(1, -1))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo)); //hem tween hem curve animasyonunu aynı anda uyguladım
    animation3 =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);//curve dedikelrimiz sabit yapılar ve benim controllerimda şu an alt limit ve üst limit olmadığı için lowerBound ve uperBound default olan 0 ile 1 arası değerler üretecek ama eşit aralıkta olmayam değerler üretecek




    //todo:controller ı başlatmak için reverse ,repead,forward gibi  methodlarımız var
    //forward: controller ı başlat başlatınca da 20 den 40 a kadar 3 sn içinde sayılar üret ve add listener çalıştığı için bunu ekranda görecem
    controller.forward();//baştan başlar
    //controller.reverse(from: 100); //sondan başlar. burada from değeri vermeliyiz 

    //addStatusListener:benim ilgili controllerimın durumu hakkında bilgi veriyor bana aşağıdaki kodlar sayesinde animasyon sürekli tekrarlanır
    controller.addStatusListener((durum) {
      //AnimationStatus.completed ilgili animasyonum bitmiştir ve burda controller.reverse diyerek bitmiş olan animasyonu bittiği yerden geriye doğru sar
        //todo: dismised: başlamıştır ve durmuştur
        //todo: forward: başlangıçtan bitime doğru çalışması
        //todo: reverse: bitişten başlangıca doğru çalışması
        //todo: completed: sona geliyor artık biterse duruyor        
        //todo: orCancel hata almamak için yazılır ileri git gidemiyorsan o treed sonlandıysa çık
      if (durum == AnimationStatus.completed) {
        controller.reverse().orCancel;
        
      } else if (durum == AnimationStatus.dismissed) {
        
        controller.forward().orCancel;
      }

       debugPrint("Durum : " + durum.toString());
    });
  }

  @override
  void dispose() {
    // todo: implement dispose
    controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value, //animation artık bir değer üretiyor bu değer renk türünde backgroundColor de renk bekliyor bizden
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: animation3.value * 18),//0 ile 1 arası değerler ürettiği için bir sayıyla çarptım ki büyük değerler üretsin
            ),
            Container(
              alignment: animation2.value,
              height: 100,
              child: Text(
                '$_counter', //+ '    %${controller.value.round()}',
                style: TextStyle(fontSize: controller.value + 20), //controller ın ürettiği değerlere göre size ı ayarladık
              ),
            ),
            const Hero(
              tag: 'emre',
              child: FlutterLogo(
                size: 64,
                textColor: Colors.purple,
              ),
            ),
            ElevatedButton(
              child:const Text("Sirali Animasyonlar"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NewPage()));
              },
            ),
            ElevatedButton(
              child: const Text("Animasyonla ilgili Widgetlar"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>const AnimasyonluWidgetlar()));
              },
            ),
            
          ],
        ),
      ),
       floatingActionButton: const CustomFloatingActionButton(body: Center(),
      options: [
          CircleAvatar(
            child: Icon(Icons.height),
          ),
          CircleAvatar(
            child: Icon(Icons.title),
          ),
      ],
      type: CustomFloatingActionButtonType.circular,
      
      openFloatingActionButton: Icon(Icons.add),
      closeFloatingActionButton: Icon(Icons.close),)
    );
  }
}