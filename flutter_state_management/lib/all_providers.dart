import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/3_sayac_manager.dart';

import 'model/3_sayac_model.dart';



//todo **************************************************
//!3.DERS 1.KISIM BU DOSYADAKİ BÜTÜN PROVİDERSLERİ SİLİP ORTAK BİR DOSYAYA TAŞIDIK ÇÜNKÜ ONLAR GLOBAL İSTEDİĞİ YERDEN ERİŞİLEBİLİRSER BUNDAN DOLAYI ORTAK BİR YERDE TOPLADIK
//todo **************************************************





//!2.DERS 1.KISIM 
//riverpod kullanmak için flutter_riverpod paketini import ediyoruz riverpod un içinde provider da vardır
//provider ne demek ?: sağlayıcı demek benim widget treeme int değer sağla string bir değer sağla gibi durumlarda provider ı kullanıyoruz ve biz provider ı tanımlarken global değişken şekilde tanımlıyoruz burdaki providerlar a final dediğimiz içinde değiştirilemez ve riverpod u kullanmak için ilgili myapp widgetımı provider scope diye bir widgetla sarmalamam gerekiyor

//!ihtiyacımıza yönelik olarak farklı farklı provider lar var::: burdaki providerlardan kastımız state management yöntemi olan provider değil Riverpod un içinde kullanılan bir sınıf aslında
//todo:provider :
// eğer biz ağacımıza basit bit int , string değer yollamak bunu faklı yerlerde okumak için provider kullanırız. burda service sınıfımızın widgetımızın veya uygulamamızın farklı yerlerinde kullanmak istiyorsak kullanabiliriz yani hep int ,string değil kendi service sınıflarımızı vs. de kullanabiliriz.

//todo:StateProvider:
//mesela sayaç uygulamamızda bir int counter değeri var ben bunu ağacımın farklı yerlerinde elde etmek istiyorsam bunu kullanırız StateProvider ile provider arasındaki fark provider da verdiğimiz değeri değiştiremiyoruz veya bu değişiklikleri dinleyemiyoruz ama stateProvider da bir integer değeri değiştirdiğiömizde ilgili yer bunu sürekli olarak dinliyor ve değiştiğinde orayıda güncelliyor

//todo:FutureProvider :
// ben firebase den future ile veritabanından dosyaları çektim bütün ağaca salmak istiyorum FutureProvider kullanırız ,

//todo:StreamProvider:
// anlık olarak bir stream yapımız varsa stream provider kullanırız 

//todo:StateNotifierProvider
//?yukarda olan provider lar verilerin aynı widget dosyasında olduğu bir yapı ama biz komplex yapımız varsa ve apayrı dosyada elde etmek istiyorsak StateNotifierProvider kullanmamız gerekiyor

//!2.DERS 2.KISIM : uygulamamızın en kök yerini main kısmını yani providerScope diye bir widgetla sarlamamız gerek gidip onu sarmaladık


//!2.DERS 3.KISIM aşağıda kurucular üzerinden gönderdiğimiz değerleri (appBar texti ve you have ile başalayan text) burada provider  ile tanımlayıp gönderiyoruz
//MyHomePage  kurucu üzerinden bir değer alımış ben bunu kurucu üzerinden değilde dışarıdan bir yerde tanımlayıp uygulamamın farklı farklı yerlerinden kullanmak istiyorum mesela o yüzden buraya gelip provider tanımlıyoruz nasıl tanımlıyorduk ? final yazıp ne sağlamak istediğimizi yazıyoruz 
//provider ın 2 yöntemi var birtanesi consumer  widget içinde tanımlıyom diğeri ise doğrudan temel widget yapın consumer oluyor stateles widget gibi 

//todo: 1.yol
final titleprovider = Provider<String>((ref) {
  return "Riverpod Basic";
});


//todo: 2.yol
final textProvider = Provider<String>((ref) {
  return "You have pushed the button this can times:";
});



//!2.DERS 6.KISIM
//eğer ki biz provider da verilen değeri güncellemek istediğimiz zaman düz provider işimize yaramıyor değişsek bile ekrana yansımıyor çünkü düz provider dinlenmiyor bunun yerine //!STATE PROVİDER kullanırız benim buraya verdiğim bu state değişebilir provider değişmezdi ama bu değişebilir ve bunun watch ile alındığı yerlere de bu değişiklik doprudan otomatik bir şekilde aktarılıyor 

final sayacStateProvider = StateProvider<int>((ref) {
  return 0 ;
});


/*  
todo:iki provider ı birleştirme
final sayacProvider = StateProvider<String>((ref) {
  // ref:ref ile başka providerlara erişebiliriz. bir veriyi elde ederken başka providerlara ihtiyacımız varsa kolay bir şekilde bunları birleştirip kullanabiliriz
  var title = ref.watch(titleprovider);
  return  "$title deneme" ;
});
*/




//Farklı bir dosyadan işlem yapmak için STATENOTİFİER PROVİDER kullanırız mesela veritabanından veri getirmek için yada eleman ekleme işlemlerini ayrı bir dosya içinde yapardık normal provider ve StateProvider işimizi çözmez. ve böylece aslında busines lojistik yani işlem yapan kodlarımı(hesaplama işlemleri, veritabanından veri getirme vb) ayrı bir dosyada ele almam gerekiyor 










//!DERS 3. 2. KISIM 
//3_sayac_model.dart sınıfının ilgili provider ı buraya yazalım
//StateNotifierProvider iki parametre alır 1. busines logic işlemlerimiz hangi sınıfta yapılıyor 2.bu sınıfın state ne yani bu dosyayı okuduğumda ilgilendiğimiz değişecek durumunb veri türünü yazarız 



//!:HOCANIN  NOTU:********************************************************************************
//todo: 1.parametre yani SayacManger iş kodlarının , methodların olduğu dosyadır buna erişmek için:::----> ref.read(sayacNotiferProvider.notifier).,,, demek gerekir

//todo: 2.parametre yani SayacModel ise bu providerin state idir buna erişmek için:::----> ref.watch(sayacNotiferProvider) demek gerekir 
//todo: SayacModel sınıfındaki sayaç değeri için :::----> ref.watch(sayacNotifierProvider).sayacDegeri
//!:HOCANIN  NOTU:********************************************************************************


final sayacNotiferProvider = StateNotifierProvider<SayacManager,SayacModel>((ref) {
  //sayacManeger ın ilk oluşturulma anını burada yapıyoruz ki bu provadier ı dinlediğimde . diyip arttır azalt gibi methodalara erişebileyim
  return SayacManager() ;
});







//!4.DERS 2.KISIM

final titleprovider2 = Provider<String>((ref) {
  return "Riverpod State Notifier Kullanimi";
});



//!5.DERS 1.KISIM
//bir provider oluştururken olaki başka bir provider a ihtiyaç duyarsak neler yaparız ona bakacağız 
//oluşturduğumuz providerlar bize ref nesnesini verirler aynı arayüzümümde olduğu gibi ref objesini diğer providerlara erişmek için kullanabiliriz dieylim ki benim elimde bir int sayi var 1,2,3 diye gidiyor eğer bu çift ise widgetım da çift yazsın tekse tek yazsin  böyle bir mantık geliştirmek için benim o anki sayac değerine erişyor olmam gerekiyor 
final CiftMiProvider = Provider<bool>((ref) {
  var degerim = ref.watch(sayacNotiferProvider).sayacDegeri;  

  //var degerim = ref.read(sayacNotiferProvider).sayacDegeri; //BURADA SÜREKLİ WATCH EDİYORUZ YANİ ŞUNU DİYORSUN BURADA Kİ DEÜİŞİKLİKLERLE BENDE İLGİLENİYORUM DİYOR ONDAN DOLAYIDA sayacNotiferProvider DA SÜREKLİ TETİKLENİYOR AMA BEN BUNU BİR KERE DİNLİCEM İLK AÇILIŞ DEĞERİ BENİM İ,ÇİN ÖNEMLİ SONRAKİ DEĞİŞKİLİKLER BENİM UMRUMDA DEĞİL DİYORSAK READ DERİZ VE BÖYLECE SÜREKLİ sayacNotiferProvider BURAYI İZLEMEZ ONDAN DOLAYIDA TEK Mİ ÇİFT Mİ KONTROLÜ ÇALIŞMAZ 0 DEĞERİ Nİ ALIR DAHADA İZLEMEZ ONDAN DOLAYI WATC DİYORUZ

  return degerim % 5 ==0 ? true : false;
});


