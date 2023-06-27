import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/main.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/model/1_my_models.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/2_3_shared_pref_services.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/4_secure_storage.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/5_6_file_storage.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/7_local_storage_service.dart';


class SharedPreferenceKullanimi extends StatefulWidget {
  const SharedPreferenceKullanimi({super.key});

  @override
  State<SharedPreferenceKullanimi> createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  var _secilenCinsiyet = Cinsiyet.KADIN;
  var  _secilenRenkler = <String>[];
  var _ogrenciMi=false;
  TextEditingController _nameController = TextEditingController();

  //!3.DERS, 2. KISIM oluşturduğum service kısmındaki fonk. kullanmak için nesne oluşturduk 
 // final  _preferenceService = SharedPreferenceService(); //4.DERSTE SOURCE STOREAGE KULLANIMINI GÖRMEK İÇİN YORUM SATIRI YAPTIK

 //!4.DERS
  //final _preferenceService = SecureStorageService(); //!5.DERSTEKİ file_storage işlemini göremk için kapattık
  //final _preferenceService = FileStorageService();  //!7.DERS 3.KISIM için iptal ettik
  //!7.DERS 4.KISIM biz yazmış olduğumuz abstaract LocalStorageService sınıfı ile farklı görünen ama aynı amaca hizmet eden 3 sınıfı(SharedPreferenceService ,SecureStorageService, FileStorageService) tek bir çatı altında üst sınıf altında toplamış oldum. bunun güzelliği şu mesela SecureStorageService bu sınıftan LocalStorageService bunu imlemente ettiğim için LocalStorageService bunda tanımlı olan tüm methodlar SecureStorageService ,SharedPreferenceService ,FileStorageService bunlarda da var o yüzden bu kullanıma izin veriliyor ve abstract sınıf olduğu için implemente ettiğim sınıflarda kendine üzgü fonk. olabilir FileStorageService de ki _createFile fonk. gibi yeterki verileriOku ve VerileriKaydet fonk. yer alsın 

  //final LocalStorageService _preferenceService = SecureStorageService(); //!8.ders için bunu da iptal ettik

  /* 7.dersin mantığını göstermek için yazdık
  final LocalStorageService _preferenceService2 = SharedPreferenceService();
  final LocalStorageService _preferenceService3 = FileStorageService();
  */

  //!8.DERS 5.KISIM: 
    //final LocalStorageService _preferenceService = locator<SecureStorageService>();

    //yukardakinin sıkıntısı şu ben diyelim ki SecureStorageService yerine SharedStorageService kullancam o zaman bunu 10 yerde yazmış olabilirdim ve 10 yerde de değiştirmem gerekirdi işte ben bunu engellemeke için bu storage sınıflarımı bir üst sınıfta topladığım için ben bunu main.dart ta tanımlarken  locator.registerSingleton<LocalStorageService>(SecureStorageService()); diye tanımlarım böylece herhangi bir değişiklikte sadece mainde tanımladığım yapının içini değiştirmem yeterli olacak

    final LocalStorageService _preferenceService = locator<LocalStorageService>();
 
  //!5.DERS

  @override
  void initState() {
    _verileriOku(); //! 2.DERS , 2.KISIM : verilerimizi build yapısı oluşturulmadan dosyadan verileri okunup ilgili alanlara yazılacaktır   
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("SharedPreference Kullanimi")),
      body: ListView(
        children: [
           ListTile(
            title: TextField(
              controller: _nameController,
              decoration:const InputDecoration(labelText: "Adinizi Giriniz"),
            ),
          ),
          for(var item in Cinsiyet.values)
          //describeEnum : enum içindeki değerlerimizi string olarak ismini almamızı sağlar
          _buildRadioListTiles(describeEnum(item), item),
         
          for(var item in Renkler.values)
          _buildCheckBoxList(item),
          
          SwitchListTile(title: const Text("Ogrenci misin?") ,value: _ogrenciMi, onChanged: (value) {
            setState(() {
            _ogrenciMi = value;
              
            });
          },),
          TextButton(onPressed: () {
           late var _userInformation= UserInformation(_nameController.text, _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
           _preferenceService.verileriKaydet(_userInformation);
          }, child:const Text("Kaydet"))
        ],
      ),
    );
  }



  Widget _buildRadioListTiles(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
      //?RADİO LİST TİLE :
      //value:bu seçildiğinde ne olacak mesela diyelim ki cinsiyet diye erkek ve kadın diye iki tane seçeneğimiz var . okunabilirliği arttırmak için model diye bir dosya oluşturup modellerimi buranın altında toplayalım. ve valu değirinde oluşturmuş olduğum 1_my_models.dart dosyasındaki kadına erişiyoruz
      //groupValue:birden fazla RadioListTile eklemiş olabiliriz bunları gruplandırmak adına her birinde aynı olan değer vermemiz lazım bunun için stateles widgetımız stateful widgeta dönüştürüyoruz
      title: Text(title),
      value: cinsiyet,
      groupValue: _secilenCinsiyet,
      onChanged: (secilmisCinsiyet) {
        setState(() {
          _secilenCinsiyet = secilmisCinsiyet!;
        });
      },
    );
  }

  Widget _buildCheckBoxList(Renkler renk)
  {
    return CheckboxListTile(
            title: Text(describeEnum(renk)),
            value: _secilenRenkler.contains(describeEnum(renk)),
            onChanged: (deger) {
              if (deger == false) {
                _secilenRenkler.remove(describeEnum(renk));
              }
              else
              {
                _secilenRenkler.add(describeEnum(renk));
              }
              setState(() {
                
              });
              debugPrint(_secilenRenkler.toString());
            },
          );
  }
  
  void _verileriOku() async{
   var info = await _preferenceService.verileriOku();
   _nameController.text = info.isim;
   _secilenCinsiyet = info.cinsiyet;
   _secilenRenkler = info.renkler;
   _ogrenciMi = info.ogrenciMi;
   //burda bekleyen bir işlem vardı setstate diyelim ki bu değerleri aldıktan sonra bir daha buildi çalıştırsın ve okunan değerler erkana yansısın
   setState(() {
     
   });

  }
  
}
