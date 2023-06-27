
//!Enum: sınf kadar büyük olamayacak veriler için okumnabilrliği ve yazım yanlışını azaltmak için kullanabileceğimiz yapılar Cinsiyet.KADIN diyip erişebilirim
// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Cinsiyet{
  KADIN,
  ERKEK,
  DiGER
}
enum Renkler
{
  SARI,
  MAVI,
  YESIL,
  PEMBE,
  KIRMIZI,
  MOR
}

//!3.DERS
class UserInformation{
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String > renkler;
  final bool ogrenciMi;


  UserInformation(this.isim, this.cinsiyet, this.renkler, this.ogrenciMi);

  //!6.DERS 2.KISIM

  //!kendi oluşturduğumuz bu veri modelini dosyaya yazmak için json a yazmamız lazım ötle kaydetmemiz lazım okurkende json dan alıp normal objemize dönüştürmemiz lazım bunun için toJson ve ve fromJson methodaları var ben bu methodları _file_storage.dart içinde verileri kaydet fonk. userInformation.toJson() diyip çağırmam lazım şimdi bu methotları bu sınıf içide tanımlamam lazım

  //oluşturduğumuz sınıfı json foramtına dönüştürmek için. bu geriye  Map<String ,dynamic>  türünde map dönüştürür 
  //toJson dosyaya yazarken kullanılır
  Map<String ,dynamic> toJson()
  {
    return{
      "isim": isim,
      "cinsiyet" : describeEnum(cinsiyet), //burda doğrudan cinsiyet gelir diyemeyiz çünkü bu benim oluşturduğum enum formatında birşey ve jsonda böyle bit yapı yok json da string , sayı , bool , true ,false ... var benim cinsiyet.kadın erkek diğer yapıları sadece string ifade olarak kadın,erkek,diğer olarak bir ifadeye dönüştürmem lazım bunun içinde de describeEnum(cinsiyet) kullanırız bu yaptığımız şey şunu yapar cinsiyet==>Cinsiyet.ERKEK ==>ERKEK 
      "renkler":renkler,
      "ogrenciMi":ogrenciMi
    };
  }

  //fromJson dosyadan okurken kullanılır
  //fromJson elimizde bir json yapısı var bunu biz UserInformation çeviriyor sonuç oalrak  UserInformation.fromJson() bu bir isimilendirilmiş kurucudur kurucunun amacı ilgili sınıftan bize bir nesne vermekti ve  UserInformation.fromJson() bu bir isimlendirilmiş kurucudur bunun geri dönüşü UserInformation dur. Ve bu methodun içine hiç girmeden şunu diyebiliriz sana prametre olarak yukarda oluşturduğum şu  Map<String ,dynamic>  yapı gelecek sen bunu ilgili sınıfın yapısına dönüştür
  UserInformation.fromJson(Map<String ,dynamic> json) 
  :isim = json["isim"],//bu sınıfta isim diye bir değişken var  bu değişkene sana yolladığım map in adına da json demişim içinde isim diye bir alan var onu ona ata
  cinsiyet = Cinsiyet.values.firstWhere((element) => describeEnum(element).toString()==json["cinsiyet"]), //sana verdiğim json nun içinde cinsiyet diye bri değer var ama bu ERKEK gibi bir string değer bizim bunu enum türündeki Cinsiyet cinsiyet yapısına dönüştürmem lazım burda yapmış olduğum yöntem ile bunu yapıyoruz. bu yöntem şu : json["cinsiyet"] in içinde ERKEK diye bir değer var ben bunu Cinsiyet.values.firstWhere ile enum yapılarımı tek tek kontrol ediyorum (firsWhere elemanları tek tek gezer) ve bu elemen tin strine dönüşmüş hali ERKEK eşit olduğu elemanı bulup onu geriye yolluyorum o da Cinsiyet.ERKEK oluyor ()
  renkler =List<String>.from(json["renkler"]), //json["renkler"] buradaki List<dynamic> değerini al bu değerlerleden bana içnde stribler olan bir liste oluştur dedik
  ogrenciMi=json["ogrenciMi"];

  }