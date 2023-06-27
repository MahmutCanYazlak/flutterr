//Hive kullanımı: kullanıcının localinde bulunan bir veritabanıdır hive . hive kullanmak için deocumanında yer alan bazı paketleri öncelikle import etmeniz gerekir
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_kullanimi/model/4_ogrenci_model.dart';

void main() async{
  //!6.DERS 2.KISIM
  //runApp çalışmadan önce yapılması gereken yapılar varsa alttaki komutu kullanmalıyız bu komut bu maindeki işlmeler bittikten SONRA git widget tree yi çalıştır diyoruz 
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter("uygulama");// bunu main içinde yazıyoruz bu şu işe yarar: getApplicationDocumentsDirectory altına (ki biz bunu file storage de path_provider erklentisi ile elde ediyorduk) bu yapıyı kullanıınca ayrıca path provider kurmamıza gerek kalmıyor bunun altına verilerimizi tutacak dosyaları oluşturuyor biz istersek (...) buraya bir subDirectery  oluşturup bunun altına bu dosyanın oluşturulmasını sağlayabilirsiniz

  //daha sonra işimiz box lara kaldı box lar sql lerdeki tablolara benzer box lar daha esnektir verielrimizi saklamak için openBox diyerek box ı açmamız lazım ve documantasyondan aldığım kod main içine yapıştırıyorum kodun anlamı: uygulamam başlatılmadan önce(main içine yazdığım için) test diye bir kutu oluştur. eğer o isimde bir kutu daha önceden de varsa diğeri silinmiyor onu kullanıyor 
  // var box = await Hive.openBox('test'); //! var box ı siliyoruz sadece await diyoruz ben referansı ile ilgilenmiyorum sadece bu kutuyu yoksa oluştur varsada onu kullan
  await Hive.openBox("test");


  //!4.DERS 6.KISIM
  //kutuyu açmadan önce aşağıdaki kodu yazıyoruz  adaptorları tanımlıyoruz 
  Hive.registerAdapter(OgrenciAdapter());
  Hive.registerAdapter(GozRengiAdapter());

  //!4.DERS 3.KISIM
  await Hive.openBox<Ogrenci>("ogrenciler"); //içinde Ogrenci verisi tutan ve adı ogrenciler olan kutu oluşturduk


  //!5.DERS 1.KISIM
  await Hive.openLazyBox<int>("sayilar");

  //!6.DERS 1.KISIM
  //TODO: ENCRYTED işlemleri bu kodları https://docs.hivedb.dev/#/advanced/encrypted_box sitesinden hazır aldık
   FlutterSecureStorage secureStorage = FlutterSecureStorage();//secure storage den nesne ürettik 
  // if key not exists return null
  var encryptionKeyString = await secureStorage.read(key: 'key');//secure storage git key değeri "key" olan bir değer var mı onu kontrol et
  //eğer bu key secure storage de yoksa yani uygulama ilk defa çalışıyorsa 
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey(); //Hive ile secureKey üretiyoruz 
    //sonra bunu alıp secureStorage.write diyerek yazıyoruz 
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key), //içerisinde int olan bir listeyi byte olarak alıyor ve bir string ifadaeye dönüştürüp secureStorage yazıyor 
    );
  //eğer key secure storage da varsa hiçbir şey yapmıyor   var encryptionKeyString = await secureStorage.read(key: 'key'); burdan bu değeri okuyacak 
  }
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!); //encryptionKey i yani secureStorage.read ettiğimiz bu key i decode ederek normal bir yine int lı bir listeye dönüştürüyor yani bytelara dönüştürüyoruz 
  print('Encryption key Uint8List: $encryptionKeyUint8List'); //bunu yazdırıyoruz
  final sifreliKutu = await Hive.openBox('ozel', encryptionCipher: HiveAesCipher(encryptionKeyUint8List)); //oluşturudğumuz key i buraya veriyoruz
  sifreliKutu.put('secret', 'Hive is cool');//key: scret , value:Hive is cool
  sifreliKutu.put('sifre', "440902");
  print(sifreliKutu.get('secret'));
  print(sifreliKutu.get('sifre'));



  runApp(const MyApp());
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

  //!DERS 1-2-3:
  void hiveVerilerIleIlgiliIslemler() async{
  //ne zaman ki bu butona basacak ben hive ile ilgili işlemler yapacağım

  //!KUTUYA VERİ EKLEMEK:
  //kutuya veri yazmak için; not: birden fazla kutun olabileceği için kutunun adını yazıyorsun ve önce o kutuyu açıyorsun yani erişiyorsun
  var box = Hive.box("test");

  //----not:----uygulamayı her açıp kapattığımızda her seferinde add ile veriler yazılıyor yani biz ikince kez denediğimizde o veriler orada diğer elemanlar olarak yeniden ekleniyor o yüzden ekleme kodları çalışmadan önce içeriği bir silelim daha sonra yeni elemanlar ekleyelim fakat bu uzun sürecek bir işlem old. için o await ile beklememiz lazım( zaten üzerine gelince future yapısında old. söylüyor bize)
  await box.clear();

  //-----not:---- ekleme işlemi async await kullanılmıyor çünkü biz main de await Hive.openBox("test"); yaptığımızda tüm kutuyu ramde açıyor blki içinde 1000 tane eleman var bunların hepsini ram de saklıyor ve en kısa zamanda telefonun hafızasına yazıyor o yüzden add kullanımları asenkron değil burda çok falz veri tutuyorsam bu verinin ram de tutulması iyi birşeydeğil onun içinde LazyBox ı göreceğiz

  //todo: eleman eklemek için ilk yöntem ADD:
  // add ile eklediğimiz veriler değerin kendisidir key değerleri otomatik olarak auto increment olarak artıyor
  box.add("mahmut can"); //index:0 , key:0, value:Mahmut Can
  box.add("yazlak");//index:1 , key:1, value:yazlak
  box.add(true);//index:2 , key:2, value:true
  box.add(123);//index:3 , key:3, value:123

  //todo: eleman eklemek için ilk yöntemin listeli hali
  //bir liste olarak elemenaları geçebilirim ve addAll da çok fazla veri olabileceği için bunu da await ile bekletiyoruz 
  box.addAll(["liste1","liste2",false,4409]);

  
  //todo: eleman eklemek için ikinci yöntem put:
  //put methodu bir map gibi çalışıyor yani biz buraya önce bir key değeri yazıyoruz sonra değerini yazıyoruz ve put un farkı asenkron olması yani bunu await ile beklememiz gerekiyor eğer bu değeri hemen kullanacaksak 
  await box.put("tc", "11223344556");
  await box.put("tema", "dark");//tema veriside tutabilirsin

  //todo: eleman eklemek için ikinci yöntemin listeli hali
  //putAll da: bir kerede birden fazla veriyi map şekilinde eklerken kullanırız.putAll bizden key valuları tutacağı bir map bekliyor
  await box.putAll({
    "araba":"Mercedes",
    "yil": 2023
  });

  /*box.toMap yapısı için kapatıldı
  // yazdığımız değerleri okuyalım
  box.values.forEach((element) {
    //keys değerlerim tc ,tema şeklinde gelir
    debugPrint(element.toString()
    );
  });
  */

  debugPrint(box.toMap().toString()); //Değerleri forEach ile gezemek gibi. bütün kutudaki key ve value değerlerini map e çevirip yazdırıyor böylece map yapısında kutunun içindeki bütün değerleri görüyorsun
  debugPrint(box.get("tema"));//key ile veriye erişim
  debugPrint(box.getAt(0));//index ile veriye erişim(AT GÖRÜNCE ONUN İNDEX OLDUĞUNU ANLARSIN)
  debugPrint(box.get(0));

  debugPrint(box.get("tc"));
  debugPrint(box.getAt(4));
  debugPrint(box.length.toString());//box ın uzunluğunu verir

  await box.delete("tc");//key e göre silme
  await box.deleteAt(0);//index e göre silme
  debugPrint(box.toMap().toString());
  await box.putAt(0, "yeni deger");//index e göre yeni değer ekleme
  debugPrint(box.toMap().toString());



  //!Bir rehber uygulaması yapmaya çalıştığımızda:
  //aynı key üzerine birden fazla eleman eklemeye çalışırız öyle oluncada key e ilk eklediğimiz değer gider , güncellenir. Bir diğer örnek bir uygulama yaptık öğrencilerle çalışıyoruz bir öğrencinin belki 5 tane farklı verisi var işte bunları tek seferde yazdırmak istiyorsak artık kendi sınıflarımızı Hive de kaydedecek şekilde yani TYPE ADAPTERS e dönüştürüp kullanmamız gerekiyor
  //todo: aynı key e birden fazla değer eklenmesi ve ilk değerin güncellenmesi örneği
  box.put("isim", "Mahmut Can");
  box.put("isim", "Seren"); 

  //todo: TypeAdapters Kullanımı 
  //Hive veritabanında List , map , DataTime vs saklayabiliyoruz ama Hive bizim oluşturduğumuz sınıfları saklayamaz işte kendi sınıflarımızı hive ile çalışmaya uygun hale getirmek için onlara TypeAdapter lar oluşturmamız gerekecek ki hive bunları nasıl  yazacağını bilsin. 2 yöntemi var 1:manuel 2:GenerateAapter(*) biz hive_generater paketini kurmuştuk bun kullanark oluşturmuş olduğumuz sınıfı otomatik hale getireceğiz


  }

  //!DERS 4:
  void _customData() async
  {
    //!4.DERS 2.KISIM
    //aşağıda tanımladığım Ogrenci nesnelerini hive veritabanına kaydetmek istiyorum
    var mahmutCan = Ogrenci(3, "Mahmut Can", GozRengi.MAVI);
    var seren = Ogrenci(2, "Seren", GozRengi.YESIL);

    var box = Hive.box<Ogrenci>("ogrenciler"); //oluşan kutumuzu açtık 
    await box.clear();//her projeyi açtığımızda ve buda bir veritabanı olduğu için her seferinde bu elemanlarımızı tekrar tekrar ekliyor bunu engellemek için yaptık eski verileri sildik
    box.add(mahmutCan);
    box.add(seren);

    //---projemizi çalıştırdığımızda hata alırız sebebi bir adaptor oluşturmamızdan kaynaklanır oluşturmak için 4_ogrenci.model.dart dosyasına gidiyoruz

    //hata düzeltildi

    box.put("MahmutCan", mahmutCan);
    box.put("Seren", seren);


    //!4.DERS 7.KISIM
    // verileri yazdıralım
    debugPrint(box.toMap().toString()); //calıştırdığımızda instance of hatası aldık yani nasıl string yazılacağını bilmiyor sınıfıma gidip toStringi ovverirde ediyoz

  }
  
  //!DERS 5:
  void _lazyAndEncrytedBox()
  async{
    //eğer HİVE veritabanında çok fazla veri tutuyorsak Bu durumlarda LazBox kullanılır. diyelim bir kutuda 3000 tane ismi tuttuk ve ne zama ki open dediğimiz zaman bu 3000 tane değer uygulama hafızasında direkt olarak açılır kutuyu açar açmazn ve ordan hızlı bir şekilde okuma yazma yapabiliyoruz ama belkide 10.000 veri varsa işte o zaman burda LazyBox kullansbiliriz bu ne yapıyor : bu gidipte bütün 10.000 taneveriyi hafızada açmıyorda bir tek key değerlerini açıp hafızada tutuyor ve biz key i can olan değeri veya tc si şu olan değeri bana getir dediğimiz zaman ondan sonra gidip onu diskten okuyor o yüzden normal box da ki get asenkron olmazken LazyBox daki get methodu await dememiz lazım normal kutu açılımıda tüm veriler gittiği için onu beklemeye gerek yoktu ama openLazyBox(..) açtığımızda get diyip değeri okuduğumuzda bunu beklememiz gerekiyor.

    var sayilar= Hive.lazyBox<int>("sayilar");//kutuyu açarkende lazyBox diyip açarız
    
    for(int i =0;i<500; i++)
    {
     await sayilar.add(i*50);
    }
    // debugPrint(sayilar.toMap().toString()); //sayilar artık bir lazy box olduğu için toMap ile erişemeiyorum bir for döngüsü açıp 
     for(int i =0;i<500; i++)
    {
     debugPrint((await sayilar.getAt(i)).toString());
    }


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //!BUTONA BASTIĞIMDA YUKARDA YAZDIĞIMIZ FONSKİYON TETİKLENECEK
        onPressed: _lazyAndEncrytedBox,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
