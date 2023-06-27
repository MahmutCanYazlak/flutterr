//bizim preferences storage da , secure storage de , file storage da da verileriOku ve verileriYaz isminde fonks. var hepsinde de mantıken aynı işi yapıyoruz ve biz ayrı ayrı widgetlarda bu yapıları kullanırken her seferinde var _preferenceService = FileStorageService(); şeklinde nesne oluşturmam gerekiyorki bu üstteki yapıaları kullanabileyim bizim bu projde tek widget var diye bir tane oluşturduk ama 10 tane widgetımızda olabiliedi o zaman 10 tane nesne oluşturman gerekirdi bunun yerine bir tane üretsem ve her seferinde aynı nesneyi kullansam ve diyelim 10 tane yerde kullandım ve preferenceSecureServisi kullandım sonra baktım olmuyor SecureStoregeService ye geçmem gerekti o zaman bu ifadeyi 10 yerde de değiştirmem gerek bunun için bu 7.DERSTEKİ YAPIYI GÖRECEĞİZ file.storage ,shared.preference, file_storage da fonks. somut sınıf ne yapacaklarını biliyor oratk yönleri verlleriKaydet  verileriOku ben bu ifadeler için üst sınıf oluşturacam bu sınıfın amacıda local diske birşeyler yazmak bu ifade genel bir ifade localStorage evet ama ne bu secure storage mı sherede prefences mı file storage mi biilinmiyor o yüzden ben bundan nesne üretemem ondan dolayı abstaract olsun diyorum
//sınıfımız içerisini nasıl dolduracağını bilmiyorsa soyut sınıf olur birde bunların içeriğini nasıl dolduracağını bilen somut sınıflar oluştururuz

import '../model/1_my_models.dart';

abstract class LocalStorageService {

  Future<void> verileriKaydet(UserInformation userInformation);
  Future<UserInformation> verileriOku();
}
