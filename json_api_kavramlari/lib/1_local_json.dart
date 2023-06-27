import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_api_kavramlari/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({super.key});

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  String _title =  "Local Json Islemleri";
  late Future<List<Araba>> _listeyiDoldur ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        //!4.DERS 1.KISIM Burada butona bastığımız zaman setState ile Builder her seferinde tekrar tekrar çalışır fakat bu tekrar tekrar çalışmada builder içinde çağrılan arabalarJsonOku() da çalışacak bu kaynakların gereksiz kullanılmasın sebebi sonuç olarak verilerim getirlmiş bundan kurtulmak için initState kullanırız nasıl:bizim her seferinde çağırdığımız yapı Future<List<Araba>> tipinde olan arabalarJsonOku fonksiyonu biz gidip build fonk. dışında aynı veri tipinde (Future<List<Araba>>) olacak şekilde bir değişken tanımlarız ve initState içinde arabalarJsonOku yu tanımladığımız değişkene atarız böylece initState build methodundan önce BİR KEZ olacak şekilde çalışır ve bu sorundan kurutlurluruz
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            _title = "Buton Tıklandı ";
          });

        },),
        appBar: AppBar(
          title: Text(_title),
        ),
        //!3.DERS 2.KISIM:
        //Burada elemanlarımızı ListViewbuilder da gösteremeyiz yanlış olur sebebi hemen oluşturulacak bir liste yok arabalarJsonOku çalışacak ama kaç sn çalışıcak bilinmiyor bu bir future normal bir liste değil ondan dolayı ListViewbuilder kullanacağız ama şimdi değil şimdi future verilerle çalışırken FutureBuilder kullanacağız bu sayede uzun sürecek işlemlerde elde edeceğimiz  verileri gösteremeye yarayan bir yapıdır

        body: FutureBuilder<List<Araba>>(

          //future Future<List<Araba>>? bizden bunu istiyor e zaten bizim arabalarJsonOku o formatta future çalışır belki 10 sn belki 5 sn ama bittikten sonra geriye döndürdüğü List<Araba> yı builder a snapshot aracılığıyla iletecek ve bu snapshot ta azı özelliklerimiz var  Future yada hata yada veri dönderir demiştik if(snapshot.hasData) diyerek verdiimiz future data dönderiyorsa ... işlemler olsun else if(snapshot.hasError) diyerekte hata çıkarsa eğer diye bu kısmı kullanırız ve builder geriye mutlaka bir widget return etmeli demiştik 
          //!4.DERS 2.KISIM: future: arabalarJsonOku(), bu kısım yerine yukarda tanımladığımız _listeyiDoldur değişkenini dolduracağız ki setStatede tekrar tekrar Future yapısı çalışmasın
          future: _listeyiDoldur,
          //!4.DERS 3.KISIM initialData: bu bizden FutureBuilder a verdiğimiz veri türünde yani ben sadece FutureBuilder<Araba> deseyedim bu benden araba türünden ilk veri beklicekti ilk veri demek meselan benim future 5 sn çalışıyor işte o 5 sn dolana kadar yada bşr hata alana kadar kullanıcıya ekranda birşey göstermek isteyebiliriz buna örnek ins. ilk açtığımızda güncel olmayan eski gezdiimiz gönderileri göstermesi gibi initialData da bu işe yarıyor benim veeriatabanına gidip verileri getirmem 10 sn sürüyorsa kullanıcıya eskiden kaydettiğim şeyleri gösterebilirim bunun gibi aşağıda rastgele bir tane araba nesnesi oluşturdum ama normalde böyle kullanılmaz interenete çıkarsın  internetten verileri getirtirsin local bir yerde bir local dosyaya yazarız bunları kullanıcı 2 - 3 .kez girdiğinde ilk önce locala bakarız önce onları gösteriririz sonra internete çıkarız 
          initialData: [
            Araba(arabaAdi: "Audi", ulke: "Almanya", kurulusYil: 1956, model: [Model(modelAdi: "A8", fiyat:150000 , benzinli: true)])
          ],

          builder: (context, snapshot) {
            if(snapshot.hasData)
            {
              
              //hasData demek dosyaya gidilecek içinde arabalar bulunan bir liste dönderecek eğer buraya kadar geldiysem return ListView.Builder diyip bir liste dönderebliriz
              //List<Araba>: bu kadar şeyin amacı içinde araba bulunan liste ben buna snapshot.data alanı ile erişebiliyorum bu eriştiğim yapıyıda bir değişkene atıyorum
              List<Araba> arabaListesi =snapshot.data!;
              
              return ListView.builder(itemCount: arabaListesi.length ,itemBuilder: (context, index) {
                Araba oAnkiAraba = arabaListesi[index];
                return ListTile(
                  title: Text(oAnkiAraba.arabaAdi),
                  subtitle: Text(oAnkiAraba.ulke),
                  leading:CircleAvatar(child: Text(oAnkiAraba.model[0].fiyat.toString())),
                );
              },);

            }
            else if(snapshot.hasError)
            {
              //hata çıkarsa hataya snapshot.error ile erişbeilirsin
              return Center(
                child:Text(snapshot.error.toString())
              );
            }
            else{
              //future miz 10 sn sürdü diyelim 10 sn sonunda verim gelebilir 3.sn de hata çıkabilir veya 10.sn veri gelene kadar bir bekleme süresi var işte o beklemede de ekrana ben CircularProgressIndicator diyerek kullanıcıya arka planda işlemin devam etttiğini belirtebilirim
              //!4.DERS 4.KISIM CircularProgressIndicator ı artık göremiyoruz if(snapshot.hasData) false değil initialData veridiğimizde artık bir datamız olmuş oluyor ondan dolayı yğkleme işlemini göremedik
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
          },
        ));
  }
  
  //bu fonk çalıştığında benim localımda bulunan dosya okunup ordaki bilgiler bu consola yazdıracağız
  Future<List<Araba>> arabalarJsonOku() async {
    try
    {

      /*4 ders için bu kısmı yorum satırı yaptım ve 5 saniyelik işlem başladı ve bitti satırlarını ekledim ki setstate ile tekrar tekrar future yapısının çalıştığını görelim
       //!3.DERS 4.KISIM: delay ile beklettik ki FutureBuilder da else kısmında ki bekleme aktif olsun  heman altında ki örnekte  ise 3 saniye bekliyor ve hata mesajı göstertiyor bunu şurda kullanabiliriz internete çıktık 3 sn sonra veri gelmezse futureBuilderım hatayı yakaladı ve ekrana bastırıyor
      await Future.delayed(Duration(seconds: 3) , () {
        return Future.error("3 saniye sonra hata çıktı");
      });
      */
      debugPrint("5 saniyelik işlem başladı");
      await Future.delayed(Duration(seconds: 5));
      debugPrint("5 saniyelik işlem bitti");




    //localımdaki dosyaya erişmek için bu bir asset olduğu için flutterda da DefaultAssetBundle diye bir sınıf var onu kulllanırız aşağıdaki gibi yaparız yani fakat burada context değerine ulaşamıyoruz ya bu fonksiyonu çağırdığımız yerde context değerini parametre olarak gönderirsin yada stateles widgetımızı stateful widgeta çevirirsin ileride stateful widget işimize yarayacak diye stetful a çevirim yaptık stateful widgetlarda burada ki state alanından direkt olarak erişebiliyorduk contex bu sınıf içerisinde her yerden erişebilir hale geliyor
    //!loadString Future BİR FONKSİYON future yapılarını bir bekleme işlemi varsa kullanırdık burada local dosyayı okuyacağız evet ama belikide local dosyamızın içinde ki veriler çok fazla olabilir ondan dolayı future yapısını kullanırız await ile ne kadar süre sürerse sürsün yinede bekletme işlemi yaparız ve işin sonunda iiçinde Future <string> olan bir veri verecek
    debugPrint("-----------string olarak ver---------------");
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/arabalar.json");
    debugPrint(
        okunanString); //!burada bana string bir değer verir içerdeki verilerden belli bir veriye erişmem şu an için mümkün değil  onunu için bu stringi alıp jsona dönüştürmem lazım onun içinde aşağıdaki kodu yazıyoruz
    var jsonObject = jsonDecode(okunanString);
   debugPrint("------------");
    
    debugPrint("-----------JsonDecoda olarak ver---------------");
    debugPrint(jsonObject
        .toString()); //burda da biz bir diziyi doğrudan string gibi yazdırmak için toString dedik. jsonObject demek aslında onu artık bir liste halinde gör demek
    debugPrint("------------map yapısı ile listeye çevrip ver--------------");
    //ve biz bu object tipinde ki json dosyamzı kullanmak için as list diyoruz liste gibi çevir ve artık bunu liste olduğunu söylediğimiz için bundan sonrada liste ile ilgili mütün methodlara erişebilr hale geldi ve bizim arabalarımız tek tek liste halinde olduğu için ben bunları dönüştürmek istiyorum
    (jsonObject as List).map((e) => debugPrint(e.toString())).toList();
    debugPrint("------------x indexteki elamnı ver--------------");
    List arabalarListesi = jsonObject;
    debugPrint(arabalarListesi[1].toString());
    debugPrint(
        "------------x indexteki Y key değerine sahip elemanı ver --------------");
    debugPrint(arabalarListesi[1]["araba_adi"].toString());
    debugPrint("------------fosd focus un fiyat değerine eriş --------------");
    //liste içinde ki map map içinde ki liste şeklinde erişim sağlıyoruz listelerer indexler le map lere key değeriyle erişiyorsun 
    debugPrint(arabalarListesi[1]["model"][1]["fiyat"].toString());
    debugPrint("-----------------2.DERS------------");
    
    


    //!2.DERS 2 (2.DERS 1 araba_model.dart oluşturmaktı)
    //!ÖNEMLİ
    //Elemanlarmız artık consolede değil De ListView de göstermek isitiyorum bunun içinde bir VERİ KAYNAĞIMI oluşturmam gerekiyor ben içinde Araba olan bir liste oluşturmak istiyorum fakat aşağıda ki kod hata veriyor Json objest <Dynamic> veri veriyor ama biz <Araba> diyoruz bunu map fonk. ile çevireceğiz arabalar.json dosyamızdaki listede yer alan araba lsitesini tek tek gezip Araba.fromMap ile alacağım map türündeki veriyi Araba nesnesine dönüştürecem diyor ve bu işlemlerden sonra içinde Araba ların olduğu bir liste elde etmek istiyorsam toList() diyip bir listeye dönüştürmem gerek

    //? : ÖZET:jsonDecode demeden önce dosyadan okuduğumuz bütün veriler bir metindi ben jsonDecode diyince bu metni(arabalar.json içindeki metni) aldı json Objelerine dönüştürdü  daha sonra diyoruzki bu dönüştürdüğün şey aslında Dynamic (runTime da çalışır) ben bunun bir liste olduğunu sisteme söyledim (as List) bu liste içinde de arabalar ile ilgili bilgileri içeren map ler var ve ben burda List<Araba> tumArabalar = (jsonObject as List).map((arabaMap) => Araba.fromMap(arabaMap)).toList(); ile diyorum ki jsonObject i bir liste olarak düşün liste olarak düşündüğünde artık map fonk. kullanabilirm bu map fonk yaptığı şey ise elemanları tek tek geziyordu ve burada gezdiği veriyi arabaMap içinde bize veriyor yani araba ile ilgili verileri map formatın da veriyor ben bu map formatında ki verileri alıp oluşturduğum araba_model.dart sınıfında bulunan fromMap e yolluyorum ve bu da bana günün sonunda araba1 ile ilgili map i sınıfa dönüştürüyor aynı şekilde map çalışmaya devam ediyor 1.indexteki araba map ini alıyor araba.fromMap e yolluyor o da bize araba2 yi veriyor ayrı ayrı bunları oluşturdu bunlar iterable türünde benim bunu bilidiğim List<Araba> listesine toList diyerek dönüştürüyor ne yapmış olduk map formatında tutulan verileri araba varilerine dönüştürmüş oldum eğer veritabanına yazma durumum olursa tekrar map formatına dönüştürürüm
    //List<Araba> tumArabalar = jsonObject;
    List<Araba> tumArabalar = (jsonObject as List).map((arabaMap) => Araba.fromMap(arabaMap)).toList();
    debugPrint(tumArabalar.length.toString());
    //Artık elimde Araba olan listem var ben bu liste ile herşeyi yapabilirim
    debugPrint(tumArabalar[1].model[1].modelAdi);

    //!3.DERS 1.KISIM: bu fonksiyonumuza return ekliyoruz ve List<Araba> türünde veri döndereceğiz ama fonk. bize kızıyor sistemdiyor ki ben belki bu verilere 3 sn 5 sn sonra erişçem ondan dolayı fonks. gidip Future ekliyoruz . future yapısı sayesinde ilerleyen bir zamanda Future<...> .. kısmına belirttiğimiz yapıyı veriyor burada Future yapısı 2 şey dönebilir ya .. yerine yazdığımız veriyi yada hatayı dönderir bize

    return tumArabalar;
    }
     //!3.DERS 3.KISIM: try catch kısmı
    catch(e)
    {
      debugPrint(e.toString());
      //return döndermeliyiz hata çıkrasada bir şey döndermeliyiz
      //return []; böylede yapabiliriz hatayı yakalayıp programı burda bitiriyoruz fakat bu sefer FutureBuilder içinde ki snapshot.error ye iş kalmıyor o zaman biz burda boş dizi yerine Future  türünde bir error dönüştürüyoruz.burda hatayı yakalıyoruz bunu bir future.error olarak yolluyoruz ve bu has.errorda yakalanıyor ve ekranada hatanın kendisi yazdırılıyor yanı Future.error içine yazdığımız veri snapshot.error alanına yazıldığı için ekranda bunu görüyüruz 
      return Future.error(e.toString());
    }
  }
}
