//Custom Font Kullanımı için google, google fonts yazıp ordan bir tane font seçip indiryorusn ve indirdiğin fonts un ttf dosyasını projemizde bir tane assets/fonts dosyasını oluşturup içine atıyorsun ve daha sonra flutter ın documanınında yer alan fonts kısmında yer alan kod parçacığını pubspec.yaml dosyası içine yazıyorsun dışardan resim ekler gibi ve gelip indiridiğimiz fonta vermiş olduğumuz family ismi ile burda çağırıyorum

import 'package:flutter/material.dart';
import 'package:flutter_dersleri_bolum2/1.dart';
import 'package:flutter_dersleri_bolum2/2_Drawer_menu.dart';
import 'package:flutter_dersleri_bolum2/4_5_ana_sayfa.dart';
import 'package:flutter_dersleri_bolum2/4_5_arama.dart';
import 'package:flutter_dersleri_bolum2/6_page_view.dart';
import 'package:flutter_dersleri_bolum2/7_tabs.dart';

//!7.DERS TABBAR KULLANIMI 2: 4.indexteki butona basınca hata alınıyordu internette yaptığım araştırmalar sonucu main() kısmını bu şekilde güncellemem gerektiğini öğrendim
void main() => runApp(MaterialApp(home: MyApp(),));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int secilenMenuItem = 0;
  //BUTTOM NAVİGATOR BAR VE SAYFALAR ARASI GEÇİŞ 2: listemizi tanımlşayalım
  List<Widget> tumSayfalar = [];
  late AnaSayfa sayfaAna;
  late AramaSayfasi sayfaArama;
  late PageViewOrnek pageViewOrnek;


  //5.DERS:  SAYFADA KALDIĞIMIZ YERDEN DEVAM ETME 1: ana sayfada veri kısmına ilerledik diyelim arama kısmında ki listemide de ilerledik diyelim fakat sayfalar arasında geçiş yaptıpımızda ilerlememiz kaybolup listenin en başından başlıyoruz bunu engellem içiin bir key çeşidi olan PageStorageKey i kullanırız bunu kullanırken PageStorageKey(buraya diğer keylerden ayrıt edici bir terim girersin) ve bu oluşturduğumuz key leri aşağıda initState de diğer sayfalardan nesne oluştururken parametre olarak key değerini  diğer sayfalara gönderiyoruz fakat diğer sayfaların kurucularında key parametresi olmadığı için gidip orda da bir kurucu tanımlayıp key bekletiyoruz aldığımız key i de super diyip ana sınıfına göndertiyoruz
  var keyAnaSayfa =const PageStorageKey("key_ana_sayfa");
  var keyArama=const PageStorageKey("key_arama_sayfa");
  //--
  var keyPageView=const PageStorageKey("key_pageView_sayfa");

  @override
  void initState() {
    //init state const tan hemen sonra çalışan buildden önce çalışan bir yapı
   super.initState();
   //TODO: AnaSayfa(...) buraya key değerlerimizi veriyoruz
   sayfaAna =  AnaSayfa(keyAnaSayfa);
   sayfaArama =  AramaSayfasi(keyArama);
   pageViewOrnek = PageViewOrnek(keyPageView);
   tumSayfalar = [sayfaAna,sayfaArama,pageViewOrnek];
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      //!Eğer uygulamada default fontumun değişmesini istiyorsan MaterialApp içinde theme: kısmından ayarlıyorsun
      theme: ThemeData(
        fontFamily: "Genel",
        primarySwatch: Colors.teal,
        
      ),
      home: Scaffold(
        drawer: const DrawerMenu(),
        appBar: AppBar(
          elevation: 0,
          title: const Text('Bölüm 2'),
        ),
        //BUTTOM NAVİGATOR BAR VE SAYFALAR ARASI GEÇİŞ 1: önce gidip ana_sayfa.dart , arama.dart sayfalaraını oluşturduktan sonra navigator butonlara basınca değiştirmek istediğim yer body kısmında ki KisiselFontKullanimi() alanını değiştirmek yani benim bu  body kısmını dinamik hala getirmem lazım bunun içinde bütün sayfalarımızı içeren bir liste tanımlayalım ve bunun içinde de widgetlar olacak çünkü benim her bir sayfam bir widget dönderiyor
                            
        //body: const KisiselFontKullanimi(),
        //!DİKKAT biz burda yeni bir sayfa açmıyoruz var olann sayfanını body kısmını değişitiriyoruz
        //BUTTOM NAVİGATOR BAR VE SAYFALAR ARASI GEÇİŞ 3: ilk başta secilenMenuItem 0 olduğu için tumSayfalar[0] yani anaSayfa gelecek eğer kullanıcı gidip menüden bir şey değiştirirse biz secilemMenuItem ı güncelliyorduk mesela arama yı seçti secilenMenuItem 1 oldu tumSayfalar[1] den aramaSayfası geldi 3. ve 4. buton tanımlı olmadığı için o sayfaların kontorlünü sağlamalıyız

        body:secilenMenuItem<= tumSayfalar.length-1 ? tumSayfalar[secilenMenuItem] : tumSayfalar[0],


        //BUTTONNAVİGATORBAR 1: Genellikle üç ile beş arasında olmak üzere az sayıda görünüm arasından seçim yapmak için bir uygulamanın altında görüntülenen bir malzeme widget'ı. bunlarda da DropDwnButton gibi içindeki elemanları liste şeklinde alıyor. ve bu listelerin sayısı 4 ten azise eğer fixed modda çalışıyor yani elemanlar gözüküyor ama eğer 3 den fazlaysa shifting modda çalışır elemanlar beyaz renkte gelir eğer 3 ten fazla olacaksa ve görünür yapacaksan BottomNavigationBar ın propretyleri içinden type: BottomNavigationBarType.fixed şekliinde ayar yapmalısın eğer yok shifting moddaysanda ve görünmesini istiyorsan her bir BottomNavigationBarItem a backround color vermelisin
        //BUTTONNAVİGATORBAR 2: eğer ki fixed kullanıyorsak ve arka plan renginin değişmesini istiyorsak ButtonNavigatorBar ı bir theme widgetı içine alıyorsun ve theme wigget ı içinde data: ThemData(canvasColor : ... ile arka plan rengini primariyColor:... ile de iconlara tıklanıncaki rengi değiştirebilirsin)
        //BUTTONNAVİGATORBAR 3: özetle eğer ki shiftingde renk ayarı yapmak isitiyorsan her item a gidip backroundcolor verirsin. fixed da renk vermek istersen buttonNavigatorBar ı gidip theme içine alıyon BUTTONNAVİGATORBAR 2 deki adaımları yapıyor
        bottomNavigationBar: buttomNavMenu(),
      ),
    );
  }

  //3.DERSİN KODLARI
  // bottomNavigationBar bir methoda aldık sınıfa almamamızın sebebi yukarda tanımlı olan bir değişkeni kullanıyor olması sınıf ta yapabilirdin ama bu daha doğru bir yapı
  Theme buttomNavMenu() {
    return Theme(
        data: ThemeData(
          canvasColor: Colors.grey,
          primaryColor: Colors
              .red, //?bu yöntem işe yaramadı bunun yerine ButtomNavigatorBar properti si içnde fixedColor: Colors..., diyip renk veriyorsun iconlara
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "AnaSayfa",
              backgroundColor: Colors.teal,
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.call), //buton aktif olunca olacak icon u veriyon
              activeIcon: Icon(Icons.call_end),
              label: "AnaSayfa",
              backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "AnaSayfa",
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "AnaSayfa",
              backgroundColor: Colors.green,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          fixedColor: Colors.red,
          currentIndex:
              secilenMenuItem, //hangi butonun seçili olduğunu söyler
          onTap: (value) {
            setState(() {
              secilenMenuItem = value;
              //!DERS 7: TABBAR KULLANIMI 1: tabbar kullanmak için ButtomNavigatorBar ın olmaması lazım. bunun ButtomNavigatorBar ın sondaki 3.indeksteki butonuna basılınca yeni bir sayfanın açılması için aşağıdaki kodu yazdık nırmalde sadece body kısmı değişiyordu ama bunu kullanmak için komple değiştirmemiz gerek
              if(value==3)
              {
                Navigator.push(context , MaterialPageRoute(builder: (context) =>const TabOrnek())).then((value) {
                  secilenMenuItem == 0;
                  
                });
                
              }
              else
              {

              }
            });
          },
        ),
      );
  }
}
