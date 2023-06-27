//TODO: PATH PROVİDER  KULLANIMI: işletim sistemine erişip ilgili klasörlere bir dosya oluşturmamı sağlıyor bir dosya oluşturmadan önce o dosyanın nereye oluşturukacağının tam padini almam lazım
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/7_local_storage_service.dart';

import '../model/1_my_models.dart';
import 'package:path_provider/path_provider.dart';
//!7.DERS 2.KISIM soyut sınıfımızı yazdık şimdide onun içini dolduracak somut sınıflar yazmamız gerekecekti bizde önceden yazmış olsuğumuz sınıfları güncelleyip LocalStorageService den implements yaptık bu güncellemeden sonra kodlarımız hata vermedi çünkğ abstaract sınıflarda ovveride edip doldurma zorunluluğu vardı e zaten biz burda onu doldurmuştuk önceden sadece verileriKaydet void ti biz LocalStorageService.dart ta onun Future<void> yapmıştık onu güncelledik
class FileStorageService implements LocalStorageService {
  //oluşturulacak dosyanın yolunu almak için
  _getFilePath() async {
    //getApplicationDocumentsDirectory bu bir future işletim sistemine erişeceği için uzun sürebilir
    var filePath =
        await getApplicationDocumentsDirectory(); //bu bana path i verecek
    debugPrint(filePath.path);
    return filePath.path;
  }

  //dosyayı oluşturmak için
  Future<File>_createFile() async {
    //File() dosyayı oluşturmak için kullanılır ve bizdeen path bekler zaten _getFilePath() bize path verir ondan sonrada oluşacak dosyanın adını verebiliriz
    //6.DERS İÇİN ALTTAKİ İKİ SATIRI YORUM SATIRI YAPTIK
    //var file = File(await _getFilePath() + "/info.txt");
    //await file.writeAsString("deneme içerik");//dosyanın writeAsString ile string değer yazdık daha farklı şeylerde var burda
    //!6.DERS 3.KISIM
    var file = File(await _getFilePath() + "/info.json");
    return file;
  }
  //!6.DERS 4.KISIM
  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    var file = await _createFile();
    //userInformation.toJson();
    await file.writeAsString(jsonEncode(userInformation));
  }
  //!6.DERS 5.KISIM
  @override
  Future<UserInformation> verileriOku() async {
    try{
    var file = await _createFile();
    var dosyaStringIcerik = await file.readAsString();
    var json = jsonDecode(dosyaStringIcerik);
    return UserInformation.fromJson(json);
    }
    catch(e)
    {
       debugPrint(e.toString());
       //hata alınsada alınmasada bir şeyler dönsün
       return UserInformation("", Cinsiyet.KADIN, [], false);
    }
  }


  //!FileStorageService den nesne ürettiğimiz zaman _createFile ın çalışmasını istiyorum onun içinde kurucu üzeürnden tetikleme yapıyorum
  FileStorageService()
  {
    _createFile();
  }
}

//!6.DERS 1.KISIM
//çoğu uygulamada ihtiyacımız olan basit bir deneme içerik isminde bir text yazdırmak değil , ihtiyacımız olan şey şu souçta benim tüm uygulama  user information üzerine yani kendimin oluştrduğu bir modelin üzerinden ilerliyor(1_my_models) haliyle ben orda yer alan bilgilirin dosyaya yazılmasını isterim o zaman o nesneyi dosyaya yazılacak şekilde dönüştürmemiz lazım çoğu yerde kullandığımız json burda karşımıza çıkıyor eğer ben 1_my_models.dart dosyasundaki UserInformatin sınıfını düzgün bir şekilde json formatına dönüştürürsem oda nasıl olsa bu objenin json a dönüştürülmüş bir string halidir ben o stringi dosyaya yazarım okurkende tam tersi işlemi yapıp tüm uygulamanın içeriğini dosyaya taşımış olurum ondan dolayı benim  o modeli json a dönüştürmem lazım ve  File(await _getFilePath() + "/info.txt"); yerine  File(await _getFilePath() + "/info.json"); demem lazım yazarkende file.writeAsString("deneme içerik") basit bir string ifade yerine userInformation objesini dosyaya yazmamız lazım bunu yazmak içinde fromJson ToJson gibi methodlar var burda dart dosyamızı json a dönüştürmemiz lazım 6.DERS te de onu yapacağız bu işlemin tersini pokeDex uygulamasında yapmış