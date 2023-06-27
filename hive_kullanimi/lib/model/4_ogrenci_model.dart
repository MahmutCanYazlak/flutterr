
import 'package:hive/hive.dart';
part '4_ogrenci_model.g.dart';

//!4.DERS 4.KISIM ADAPTOR OLUŞTURMAK İÇİN:
//bu sınıfları Hive uygun bir şekilde kaydetmek için anotasion(@) var. bunlar bize Hive.dart tan gelir
//öncelikle HiveType diyip bunun type 1 diyorum. burada ogrencide bir typetir GozRengi de bir type dir GozRengine de HiveType diyip onada 2 diyoruz her Type farklı bir numara veriyoruz bunu yapmamız yetmiyor. bu anotasion şu işe yarar biz burda Hive Generater paketini kullanacağız ya bir komut çalıştıracağız işte o komut çalışırken burda verdiğimiz değerlere göre bize yeni bir model dosyası oluituracak HiveType sadece yetmiyor bir de her bir alanın başına @HiveField(index veriyoruz , deafault valude vereBİLİRSİN(herhangi bir değer atanmazsa bunu kullanır(hive yazılırken varsayılan değerler))) ve bunu hangi alanlar önemli ve kaydedeceksek o alanlara vermemiz yeterli olur

//!NOT:
//todo: !4.DERS 5.KISIM: ÖNEMLİ NOT: pubspec.yaml dosyamıza eklediğimizbuild_runner paketinin çalışması için önce projenin adına göre "part 4_ogrenci_model.g.dart " diyorsun (yazdığında hata verecek ama terminale yazağın komut sonrası o hata gidecek) daha sonra terminale önce cd ..proje_adi.. yazıp projenin içine girip daha sonrada :--->"flutter packages pub run build_runner build" komutunu çalıştırıyorsun bu şunu yapar: benim model dosyamı görecek buradaki tanımladığım anotasionlara göre model dosyamıza yeni bir dosya oluşturacak. hive veritabanım bu ogrenci nesnesini yazarken okurken oluşan dosya içindeki değerleri kullanıyor



//!4.DERS 1.KISIM


@HiveType(typeId: 1)
class Ogrenci 
{
  @HiveField(0 , defaultValue: 555)
  final int id;
  @HiveField(1)
  final String isim;
  @HiveField(2)
  final GozRengi gozRengi;

  //final tanımladığımız için ya ilk değer ataması yapacaksın yada kurucu fonk. tanimlicaksın
  Ogrenci(this.id, this.isim, this.gozRengi);


    //!4.DERS 8.KISIM
    //toString i overide etme işlemi
    @override
  String toString() {
    
    return "$id - $isim - $gozRengi";
  }

  }


  //enum da başlı başına bir veri türüdür bununda kullanımını görelim diye tanımladık
@HiveType(typeId: 2)
  enum GozRengi
  {
    @HiveField(0, defaultValue: true)
    SIYAH,
    @HiveField(1)
    MAVI,
    @HiveField(2)
    YESIL
  }