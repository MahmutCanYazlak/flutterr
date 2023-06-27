//TODO: SECURE STORAGE KULLANIMI: sharedPreferences ile aynı anlamda localde verilerimiz kaydetmek için kullanılır fakat bu secure storage verilerimiz kaydederken şifreleyip kaydediyor ve kaydederken string değer olarak kaydeder verileri dönüştürme işlemi yapmalıyız

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/7_local_storage_service.dart';

import '../model/1_my_models.dart';

//!7.DERS 2.KISIM soyut sınıfımızı yazdık şimdide onun içini dolduracak somut sınıflar yazmamız gerekecekti bizde önceden yazmış olsuğumuz sınıfları güncelleyip LocalStorageService den implements yaptık bu güncellemeden sonra kodlarımız hata vermedi çünkğ abstaract sınıflarda ovveride edip doldurma zorunluluğu vardı e zaten biz burda onu doldurmuştuk önceden sadece verileriKaydet void ti biz LocalStorageService.dart ta onun Future<void> yapmıştık onu güncelledik
class SecureStorageService implements LocalStorageService{
  late final FlutterSecureStorage preferences; //bunun atamsı verileri oku da yapılıyor veriler yazılmadan önce okuma işlemi yapıldığı için orda yaptık ilk orası olur ondan dolayıdı preferences ı dıaşarıya taşıdım

  //!8.DERS 9.KISIM : aldığımız hata singleton diyorki bütün uygulama boyunca tek bir kere oluşturulacak biz buraya gir çık yaptığımızda 2.kez girdiğimizde verileriOku() fonk. bir daha çalışıyor ve preferences = FlutterSecureStorage(); bundan bir daha nesne üretmeye çalışıyor hata almamızın sebebi preferences = FlutterSecureStorage(); bu satır bu satırı yorum satırı yaptık ve bir kurucu fonksiyon oluşturup preferences = FlutterSecureStorage(); bu kodu vurda oluşturuyoruz 

  SecureStorageService()
  {
    debugPrint("sECUREsTORAGE KURUCUSU ÇALIŞTI");
    preferences = FlutterSecureStorage();
  } 


  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    //verileri yazarkende okurkende await dememiz lazım çnkü şifreleme olduğu için yazarken ve okurken vakit alan işlmeler bunlar
    final _name = userInformation.isim;
    await preferences.write(key: "isim", value: _name); //bu zaten string
    await preferences.write(key: "ogrenci", value: userInformation.ogrenciMi.toString());
    await preferences.write(key: "cinsiyet", value: userInformation.cinsiyet.index.toString());
    //value olarak ta string değer vermem gerek, karmaşık verilerimiz varsa ki bütün bir objeyi bile yani user İnformationun kendisini bile aslında bir şekilde stringe dönüştürüp burda tutabiliriz userInformation.renkler burdaki listeyi hem liste özelliği olsun hemde String olsun jsonDecode ve jsonEncode işllemleri vardı. jsonEncode geriye bir string ifade dönderiyor ve bizden object bekliyor benim nesnemde zaten bir object nesnemi buna veririm bunu alıp string formatına dönüştürüp bunun içinde saklamaya başlar yani listemi JsonEncode diyerek json formatında bir stringe dönüştürüp sakladım
    await preferences.write( key: "renkler", value: jsonEncode(userInformation.renkler));
  }
  @override
  Future<UserInformation> verileriOku() async {
    //secure storage de getInstance() , await falan dememe gerek yok ilk nesneyi alma işlemlerinde bunlara gerek yok verileri okurken ve yazarken istiyor
    // preferences = FlutterSecureStorage(); //!8.DERS 9.KISIM  KISMINDAKİ HATAYI ALMA SEBEBİ:
    var _isim = await preferences.read(key: "isim") ?? "";

    var _ogrenciString = await preferences.read(key: "ogrenci") ?? "false"; // string olarak ya "true" /"false" verir
    var _ogrenci = _ogrenciString.toLowerCase() == "true" ? true : false;  //stringi int e çevirmek için int.parse var bool için böyle bir method yok dartta onun için stringi küçük harfe çevirdik bu treu eşitse bu değer true dir değilse false dir

    //cinsiyeti string olarak aldık ama benim asıl cinsiyet değerim int olmalı alt saıtdada onu int e parse ediyoruz
    var _cinsiyetString = await preferences.read(key: "cinsiyet") ?? "0"; //string olarak "0" , "1" , "2" değerlerini üretir
    var _cinsiyet = Cinsiyet.values[int.parse(_cinsiyetString)];

    var _renklerString = await preferences.read(key: "renkler") ?? ""; //renkleri string olarak okudu ama renkler bir listeydi bunu tekraradan bir listeye dünştm lazım
    var _renkler = _renklerString==null ?  <String>[]: List<String>.from(jsonDecode(_renklerString)); //verileri yazarken yaptığım işlemin tersini yaptık sadece dönüştürmekle kalmadım from diyerke bunu bir listeye dünüştürdüm çünkü renkler benden içinse String ler bulunun bir liste bekliyordu List<Ogerenci>
    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }
}

