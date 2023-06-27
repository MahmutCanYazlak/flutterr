//!3.DERS 1.KISIM bu derste kodları daha düzgün bit yapı haline getireceğiz öncelikle widgetların içinde normal bu şekilde kodların olmasına gerek yok o yüzden bir services yapısı oluşturp 1_sharepref_kullanımı.dart içindeki kodları buraya taşıdık fakat buradaki değişkenler hata verdi bu değerler için widgetlara erişip ordan okumak saçma olur onun yerine ya verileri tek tek  parametre olarak  isim , renkler şeklinde gönderebilirim yada bunlara ayrı bir model oluştururum zaten hazır bir model dosyam var 1_my_models.dart oraya bunun için bir sınıf oluşturdum..Servicesların içinde widget ile ilgili bir şey bulunmz

import 'package:flutter/material.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/model/1_my_models.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/7_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//!7.DERS 2.KISIM soyut sınıfımızı yazdık şimdide onun içini dolduracak somut sınıflar yazmamız gerekecekti bizde önceden yazmış olsuğumuz sınıfları güncelleyip LocalStorageService den implements yaptık bu güncellemeden sonra kodlarımız hata vermedi çünkğ abstaract sınıflarda ovveride edip doldurma zorunluluğu vardı e zaten biz burda onu doldurmuştuk önceden sadece verileriKaydet void ti biz LocalStorageService.dart ta onun Future<void> yapmıştık onu güncelledik
//TODO: 3.DERS : SHARED PREFERENCES KULLANIMI
class SharedPreferenceService implements LocalStorageService
{
  late final SharedPreferences preferences;
  SharedPreferenceService()
  {
    //!8.DERS 11.KISIM nesnemiz hata verinde kurucu içinde tanımlayalım dedik fakat burda da hata aldık sorun şu: kurucu methodların amacı geriye ilgili nesneyi döndürmektir ve buralarda async await yapıları kullanılmaz bunu aşmak için bir fonk. oluşturup bu işlemi onun içinde kullanalım kurucu içinde de o fonk. (init())çağıralım
    init();
    debugPrint("Shared pref kurucusu çalıştı");
      
  }

  Future<void> init() async
  {
    preferences = await SharedPreferences.getInstance();
  }
    @override
    Future<void> verileriKaydet(UserInformation userInformation) async{
    final _name = userInformation.isim;
    //!2.DERS 1:KISIM: SHAREDPREFERENCE KULLANIMI: İLE VERİLERİ KAYDETMEK İÇİN
    //aşağıdaki kodu yazınca artık sharedPrefences ı kullanabiliriz dosya sisteminede erişeceği için uzun sürebilir ondan dolayı await ile bekledik zaten documantasyonda da future yapısında olduğunu söylemiş ve artık preferences nesnesi üzerinden neler yapabileceğimize bakacağzı //!8.DERS 10.KISMDA HATA ALDIK NESNE KISMINDA NESNE ÜRETİMİNİ KURUCU İÇİNDE OLUŞTURDUK

    //set kullanarak verş aktarımı yapabilirsin name saklayalım ve türü String olduğu için SetString seçtik ve bizden saklayacağımız değere key vermemizi istiyor ve value değeri vermen gerekiyor. aşağodaki yaptığımız şey kullanıcının girdiği değeri name deişkenine aktarmıştık bunu dosyaya isim anahtarıyla ekleyelim
    preferences.setString("isim", _name);

    preferences.setBool("ogrenci", userInformation.ogrenciMi);
    //cinsiyeti int olarak saklayabilirsin nasıl: kadın sa 0 , erkek se 1, diğer se 2 gibi değerleri ki biz bu değerleri my_model.dart içindeki enumlarda index yapısıyla saklanıyor yani Cinsiyet.value 0 dediğimizde kadın value 1 dediğimizde Erkek , 2 dediğimizde diğer geliyor bu değeri alarak 0,1,2 diye bunu burda saklayıp ondan sonrada onu okurkende ona uygun bir mantıkla okuyup gösterebilrim 
    preferences.setInt("cinsiyet", userInformation.cinsiyet.index);
    preferences.setStringList("renkler", userInformation.renkler);
    
  }
  @override //verileri oku ve verleriKaydet te yer alan tüm ovverride lar 7.DERSTEN sonra eklendi bu fonks. üst sınıftan geldiği için 
  Future<UserInformation> verileriOku  ()
  async{
    //!2.DERS , 2. KISIM SHAREDPREFERENCE KULLANIMI:VERİLERİ OKUMAK İÇİN 
    
    //nasıl ki set diyerek verileri yazmıştık şimdi de get diyerek verileri okuyup ilgili değişkenlere atayacağım
    //burada key değerlerini yukarda değerleri yazarken kullandığımız key değerleri ile aynı olmalı 
    var _isim = preferences.getString("isim") ?? ""; //?? null ise eğer boş ifade olsun dedik
    var _ogrenci =preferences.getBool("ogrenci") ?? false;

    //_secilenCinsiyet = preferences.getInt("cinsiyet") ?? 0; böyle bir şey yapamam çünkü _secilenCindiyet Cinsiyet türünde bir veri ama  preferences.getInt("cinsiyet") burası int
    var _cinsiyet = Cinsiyet.values[preferences.getInt("cinsiyet") ?? 0];
    var _renkler = preferences.getStringList("renkler") ?? <String>[]; //eğer nullsa boş liste olsun dedik

    /*SERVİS YAPISINDA BUNA GEREK YOK
    setState ti burda damemizin sebebi hot restart yaptığımızda veriler gelmeyip hot reload yaptığımızda geliyor bunu düzeltmek için bunu yaptık bunun kaynaklanma sebebi ise : biz uygulama ilk açılırken verileri oku diyoruz init state de ama bu fonksiyonumda uzun sürecek bir işlem var ve bu işlem bitmeden yani await diyip bekliyoruz ya aşağodaki değerleri okuma işlemi vs var bu işlem bitmeden ne oluyor bu _verileriOku()  atlanıyor ve build tetikleniyor ve ekrana bunlar geliyor ben ne zaman hot restart yapıyorum şöyle düşünelim ekran 1 sn yede yazılıyor ama veriler 2 sn sonra geliyor o yüzden bu değişiklik burda gözükmüyor gözükmesi için fonk. içindeki işlemler bittikten sonra setState diyebilirim bunu yapınca fons. içindeki değerler okunmuş olacak ilgili değişkenlere aktarılmış olacak ondan sonra setState dedikten sonra direkt olarak değişiklik ekrana yansımış olacak
    setState(() {
      
    });
    */

    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);

  }
}

