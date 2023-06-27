//NAVİGATOR: biz bir uygulama yani materialApp oluşturduğumuzda arka planda otomatikmen oluşturuluyor mesela home: bu sayede oluşuyor ve şu nalma geliyor bu flutter uygulamasının an sayfası ne olsun ana sayfası scaffold olsun demişiz Navigator.of(context): bu ise bizim widget treemizde Her MaterialApp ile bize verilen bir Navigator var demiştik ya buna eriş içine de yeni bir rota koy demek. şimdi bizim uygulamamız isterse 70 tane sayfa olsun bir tane navigatör old. için öncelikle diyorumki widget treemde bulunan bu navigator a eriş-->Navigator.of(context) ondan sonra bunun içindeki yapıya eleman ekle artık stack yapısının neresindeysek yeni rotayı ekledikmi ve butona bastıkmı o yeni sayfaya gitmiş oluyoruz
//NAVİGATOR sınıfı özetle içinde rotaların tutulduğu bir yığın yapısıdır

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/green_page.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/red_page.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/route_generator.dart';
import 'package:navigasyon_islemleri_ve_navigator_sinifi/yellow_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      //home: AnaSayfa(),

      /*

      PUSH NAMED İÇİN ROUTES AYARI 1: biz her seferinde syafalar arasında geçiş yapmak için kod tekrarı yapıyoruz onun yerine kod karmaşasını azaltmak için 2 yöntem var 1.) push Named kullanımı bunun içi gelip MaterialApp de routes diyoruz bu bir map yapısıdır ve MaterialApp içerisinde uygulamamızda kullanacağımız bütün rotaları tanımlayabilirz bizden string ve fonksiyon bekliyor fonksiyonda context alıyormuş ve geriyede bir widget Builder veriyormuş. burda map yapısı olşturacağız map de elamanlarımız key value olarak saklanıyordu: map yapısında şu şkeilde yazıyoruz (gidilecek olan rotamın adı , gidilecek rota ) böylece rota tanımını yapmış oldum bunu kullanmak için aşağıda bir elevetadButton oluşturuyoruz
      routes: {
        '/redPage' : (context) => RedPage(),
        '/' :(context) => AnaSayfa(), // genellikle rota adlarında / kullanılır ve başlangıç sayfası olarakta '/' bu slajı kullanabiliriz  fakat bunu yapınca hata aldık bunu sebebi eğer bizim böyle bir rota mapimiz varsa ve burda kök dizini belirtmişsek yani uygulamanın başlangıç sayfasını vermişsek bu aslında home: yerine geçiyor ondan dolayı ikisini birlikte kullanmaayız home: iptal etmeliyiz

        '/yellowPage' :(context) => YellowPage(), //bu context açılaca yeni yellowPage in contexti yani ağaca eklendiği yeri veriyor lazım olur diye veriyor 
      },
      onUnknownRoute BU şu işe yarar eğer ki butonlarda olmayan bir rota verirsek bunu kullan
      onUnknownRoute:(settings) => MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text("HATA")),
          body: Center(child: Text("404")),
        );
      },), 


      */

      //ON GENERATE ROUTE KULLANİMİ 1: şimdi yukarda routes yapısı oluşturduk ve eğer orda olmayan bir rota varsa onUnknownRoute buraya düşüyordu bu ikisinin ortasında onGenerateRoute vardır kafamız karışmasın diye routes ve onUnknownRoute yapsını yorum satırı yaptık ve hepsini onGenerateRoute içinde kullancağız bu yapı nasıl çalışıyor? biz ne zamanki isimlendirilmiş rota kullanıyorsak pushName butona basıldığında git ...X... sayfasına eriş bu ifade öncelikle routesta aranıyor sonra onGenerateRoute aranıyor onlarda bulunamazsa onUnknownRoute de bakıyor biz onları yorum satırı yaptık tüm yapıya onGenerateRoute içinde bakacağız 
      //ON GENERATE ROUTE KULLANİMİ 2: peki neden ongenerateRoute kullanalım? routes yapısı statik bir yapı  redPage diyince oraya gir OrangePage diyince oraya git ama bir uygulama yaptığımızda işler bu kadar basit değil mesela redpage gittikten sonra yeni bir detaysayfası açacaksak yeni açılan sayfaya veri gönderebiliriz dinamik yapılar olabilr veya routes dakiler MaterialPageRoute ile kaplanıyor ben belki CubertinoPageRoute kullancam routesta kullanamıyoruz ama onGenerateRoute de her rota işleminde burası tetiklendiği için istediğimizi yapabiliriz mesela bir uygulama yaptık redPage kaçkez girildiğinin bilgisini tutacaksak rotesta bunu yapamayız ama onGenerateRoute de yapabiliriz onGenerateRoute bizden ne bekliyor ? içinde geriye bir rota dönderen içinde routeSettings olan fonksiyon bekliyor. bu yapıda çok fazla rota varsa MaterialApp in içi çok karışacak bundan dolayı bu yapıyı ayrı bir dosya içine alalım->route_generator.dart
      
      onGenerateRoute: RouteGenerator.routeGenerator,  //ON GENERATE ROUTE KULLANİMİ 4:RouteGenerator.routeGenerator(settings) normalde böyle gelir bura ama biz settings yapısını siliyoruz sebebi biz bu satırı yazdığımızda bu satır işlendiğinde doğrudan bu satır çalışır ama ben direkt çalıştırmasını istemiyorum ne zaman çalışacağına o kendisi karar verecek ne zaman bir rota kullanımı olacak yani bir butona basıldığında Navigator.pushNamed(context, '/redPage2'); şöyle bir ifade olacak o zaman burası tetiklenecek ve benim sınıfımda bulunan bu fonksiyon bu sefer tetiklenmiş olacak bundan solayı parametre olarak gönderdiğimiz settings siliyoruz yoksa zaten hata da alıyoruz


    );
  }
}

//AYRI BİR SINIF İÇERİSİNDE NAVİGATORU KULLANMA SEBEBİMİZ: şimdi context yapısı kendisinden öncekilerin yerini gösterir widget treede yukarıda materialApp de ki context yapısı kendisinden önceki kök yapısını gösterir bizim navigator yapızmız ise MaterialApp de oluşurdu biz gidip materialApp deki contexti kullanarak sayfa açma işlemi yaparsak hata alırız onun için bu şekilde yeni bir stateles widget sınıfı oluştururum ve burdaki context yapısında navigator u çağırırım sebebi burdaki context yapsıında kendisinden önceki materialapp i de tutuyor
class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Material App Bar'),
      ),
      body: Center(
          child: Column(
        children: [

          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade300),
            onPressed: () async {
              //CupertinoPageRoute iosa özel açılma efekti MaterialPageRoute androide özel açılma efekti

              //çağrılan sayfadan gelen veriyi burda yakalamak içim: bu push işlemi gerçekleştirildiğinde henüz bir sayı falan oluşmadı yani "Kirmizi sayfaya gir IOS" butonuna bastık fetura işlemi bitti diyemeyiz ben bu değeri burda await ile bekleyebilirim push yapısı geriye bir değer dönderecekmiş o yüzden aslında gidip önüne <int> dieyerek int bir değer dönderecek diyebilirim. ve eğer await kullanıyorsak bu methoda async diyerek belirtmemiz gerekiyor //FETURE YAPISI ve ne zamanki Navigator.push diyerek RedPage i açıyorum bana bir sayı gelecek bende bunu alıp ekranıma vs bastırabilirim //FETURE YAPISININ  BİR DİĞER YÖNTEMİDE THEN YAPISI onuda MaterialPageRoute kısmında görelim
              int? _gelenSayi =
                  await Navigator.push<int>(context, CupertinoPageRoute(
                builder: (context) {
                  return RedPage();
                },
              ));

              debugPrint("IOS diğer sayfadan gelen değer: $_gelenSayi");
            },
            child: Text("Kirmizi sayfaya gir IOS"),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
            onPressed: () {
              //Navigator.push(context,route), //statick bir method olduğu için sınıf üzerinden erişebiliyorum ama benden yine context bekliyor
              //push kısmı bizden Route bekliyor ama bu soyut bir sınıf onun yerine ondan türetilmiş olan MaterialPageRoute kullancaz buda bizden builder bekliyor bu şu anlama geliyor geriye bir widget döndüren ve context oalrak parametre alan bir fonksiyonmuş geriye bir widget döndermeliymiş ve parametre olarakta bize context değeri veren isimlendirilmemiş fonksiyon ve bizim burda döndereceğimiz widgetta açılacak olan yeni sayfamız olmalı
              //RedContext yeni açılan sayfayla oluşan context bu sayfa içinde context i kullanmak isterseniz diye verilen context
              //Normal context değeri ise AnaSayfa içindeki builderın bize verdiği context değeri
              //FETURE OLAYI: then diyip gelecek value değerinin tipini giriyoruz bu değer null da olabileceği için ? yaptık ve dynamic olduğundan dolayı gidip push kısmınada <int> yazıyon ve değeri kullanabiliyon
              Navigator.of(context).push<int>(
                  MaterialPageRoute(builder: (RedContext) {
                return RedPage();
              })).then((int? value) => debugPrint(
                  "android diğer sayfadan gelen değer: $value")); //bu ise widget treede bulunan navigatore erişip ondan sonra ekliyor ama bu ikiside aynı işi yapıyor yazımları farklı
            },
            child: Text("Kirmizi sayfaya gir Android"),
          ),

          //MAYBEPOP KULLANIMI maybepop dediğim zaman o sayfanını öncesinde yani stack imizde öncesinde bir elamn varsa MaybePop yaparak ilgili sayfadan çıkılmasını sağlıyor eğer onun öncesinde herhangi bir elaman yoksa (burdaki gibi ilk sayfaysa) çıkmıyor. eğer bunun yerine doğrudan pop deseydik benim zaten bir sayfam var oda AnaSayfa() olarak burda açıldı pop dediğimiz zamanda beni materialApp in temeline gönderdi yani stackta bulunan tek eleman olan AnaSayfa() ya yolladı ÖZETLE maybepop dediğimizde öncesinde bir elaman varsa pop yapsın yoksa elemanı çıkarmasın demek ama eğer öncesinde bir sayfa yoksa ve pop dersen hatanımsı bişey alırsın
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: Text("Maybe Pop kullanımı"),
          ),


          //CANPOP KULLLANIMI : geriye dönebilir miyim demek bu bir if koşuluyla kullanılabilir. yani öncesinde bir eleman var mı yok mu bunun kontrolünü yapmak içn kullanılır
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
            onPressed: () {
              if(Navigator.canPop(context))
              {
                print("evet pop olabilir");
              }
              else
              {
                print("hayır olamaz");
              }
            },
            child: Text("Can Pop kullanımı"),
          ),


          //PUSH REPLACEMENT KULLANİMİ: normalde Navigator.of(context).push(MaterialPageRoute(builder: (GreenContext) {return RedPage(); })) dediğimizde stack yapımızda AnaSayfa onunda üstüne GreenPage koymuş oluyoruz Push Replacement te ise kullanımı bire bir aynı bir tek adı farklı ne işe yrıyor: burda ise greenPage anaSayfanını üstüne değilde stackta bunu çağıranın yerine bunu koy demek greenPage i AnaSayfa() yerine koyaca stackta. bunu kullandığımızda stackte bir tek greenPage olacak ve geri gittiğimizde uygulamadan çıkacak bunu şurda kullanabiliriz login ekranında kullanıcı bilgileri doğru girdiğinde anasayfaya geldiğinde geri gittiği zaman tekrardan login ekranını görmesine gerek yok o yüzden push yerine pushReplacement kullanırız
           ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) {
                      return GreenPage();
                    }),
              );
            },
            child: Text("Push Replacement kullanımı"),
          ),


           //PUSH NAMED KULLANIMI 2: Navigator.pushNamed(context, rota Adı); rota adı yukartda routes da tanımladığımız rota adı olmalı. Burda yapı kendiliğinden MaterialPageRoute ile sarmaladı tek bir satırda çözdük yalnız buda default MaterialPageRoute veriyor ben belki CupertinoPageRoute kullancam bunun kötü yanı bu
           ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue.shade600),
            onPressed: () {
              //Navigator.of(context).pushNamed(routeName);
              Navigator.pushNamed(context, '/redPage');
            },
            child: Text("Push Named kullanımı"),
          ),
           
           
            //ON UNKNOW ROUTE KULLANIMI eğer push named kullanımı için routes da olmayan bir rota verildiyse onUnknownRoute kısmı çalışır
           ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue.shade600),
            onPressed: () {
              //Navigator.of(context).pushNamed(routeName);
              Navigator.pushNamed(context, '/redPage2'); //var olmayan bir rota dedik
            },
            child: Text("onUnknownRoutekullanımı"),
          ),


          //ON GENERATE ROUTE KULLANİMİ 3: SAYFALAR ARASI VERİ GÖNDERMEK İÇİN 1: arguments yapısını kullanırız ve bu object türünde veri alıyor yani herhangi bir türde veri alabilir map yapısı , liste yapısı , int değer ... rotamın yanına göndereceğimiz değeride yazıyoruz bu değer route_generator.dart dosyası içinde routeGenerator fonksiyonuna gidiyor burda Switch yapımız içinde ilgili rota bulunuyor '/ogrenciListesi' diye ve routeGenerator(RouteSettings settings) de settings kısmına bilgiler geldi X değerimizi tutan settings.argument bunun içinde buraya geldi ama bunları oluşturduğumuz yer _routeOlustur(Widget gidilecekWidget) burası burdaki MaterialPaheRoute lara bunu vermemiz lazım settings yapımızı parametre üzerinden yolluyoruz çünkü değerimiz settings içerisnde _routeOlustur(Widget gidilecekWidget , SETTİNGS) yapıp _routeolustur fonksiyonuna yolluyorum ve burda da diyoruzki ki MaterialPaheRoute ile gidilecek widgetı oluşturuyorken aldığın seetingside yeni bir widget mesela öğrenciListesi widgetını açmadan evvel gönder settings: settings bu şkilde gönderdik bunu yapmazsak kullanıcı veriyi yollamış olur ama biz veriyi ilgili açılan sayfaya göndermemiş olurduk
           ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue.shade600),
            onPressed: () {
            
              Navigator.pushNamed(context, '/ogrenciListesi', arguments: 60); 
            },
            child: Text("Lsite oluştur"),
          ),
        ],
      )),
    );
  }
}
