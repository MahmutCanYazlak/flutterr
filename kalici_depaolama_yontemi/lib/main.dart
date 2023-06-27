import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/1_sharepref_kullanimi.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/2_3_shared_pref_services.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/4_secure_storage.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/5_6_file_storage.dart';
import 'package:hive_kullanimi_ve_kalici_depaolama_yontemi/services/7_local_storage_service.dart';

//!8.DERS 1.KISIM: GET_IT KULLANIMI: ilk olarak get_it paketini kurduk ve docüman. dan aldığımız kodu mainden önce ye yapıştırdık. peki bu ne işe yarayacak:? global olarak yani uygulamanın her yerinden erişebileceğimiz locator nesnemiz var artık ve ben bunun üzerinden başka sınıflarca ihityaç duyulacak sınıflara register ediyorum yani uygulama ilk açıldığında sen bu sınıf nesneleriini oluştur demiş oluyorum yani 1_sharepref_kullanimi.dart dosyasının içinde yazdığımız final LocalStorageService _preferenceService = SecureStorageService(); burda yapılan işlemi tek bir çatı altında bizim widgetlarımız 5 farklı dosyaya ihityaç duyuyorsa hepsini burda register ediyoz kaydedip tanımlıyoruz

//!8.DERS 2.KISIM: locator. diyince birsürü farklı yöntem var eğre 10 farklı yerde storage yapılarını kullanıyorsak 10 farklı yerde nesne üretmem gerek demiştik ama benim uygulamamda bir tane nesne üretmem yeterli işte o zaman SİNGLETON kullanmamız gerekiyor singleton şu işe yarar : bir nensneyi bir kere üretiyor ve ondan sonra biz onu kullanmak istediğimizde bir daha bir daha constractor çalışmıyorda aynı nesne üzerinden ilerliyoruz
final locator = GetIt.instance;

void setup() {
  //locator.registerSingleton<SecureStorageService>(SecureStorageService());
  //locator.registerSingleton<SharedStorageService>(SharedStorageService());
  //!8.DERS 3.KISIM:
  //bu yukardaki kodun sıkıntısı şu ben bunları çağıracağım zaman locator.get() dediğimde yukardakilerden hangisini getirecek ve ben bunları yine 10 yerde çağırdım diyelim final LocalStorageService _preferenceService = locator<SecureStorageService>(); ve Secure yerine Shared kullandım o zaman 1 yerde değiştirecem işte bunu yapmamak için aşağıdaki yapıyı kullanıyoruz ve bu locate yapısını çağırırkende şu şekilde çağırırsın  final LocalStorageService _preferenceService = locator<LocalStorageService>(); değişiklik yapacağın zamanda aşağıdaki kodda değişklik yapman yeterli olacak 
  //-----------------------tüm seçenekleri deniyoruz hepsini görelim-------------------
  //locator.registerSingleton<LocalStorageService>(FileStorageService()); //TODO: ilk bunu yaptık çalıştı sırayla hepsini deneyelim
  //locator.registerSingleton<LocalStorageService>(SecureStorageService()); //TODO: bunu da denedik çalıştı
  //locator.registerSingleton<LocalStorageService>(SharedPreferenceService());//TODO: registerLazySingleton DENEMEK İÇİN YORUM SATIRI YAPILDI
  //?registerSingleton bir kez nesneyi kaydeder ve hep onu kullanır 

  locator.registerLazySingleton<LocalStorageService>(()=>SecureStorageService());  
  //?registerLazySingleton var birde bu ise direkt nesneyi üretmede ne zaman bu nesneye ihitiyaç duyulursa bu nesneyi üret mesela benim uygulamam ilk başladığında aslında SharedPreferenceService ihtiyaç duymuyor önden yükleme yapmış oluyoruz lazy yazarsak ama ne zamn ki final LocalStorageService _preferenceService = locator<LocalStorageService>(); nesnesini üretsem işte o zaman initialize edielcek registerSingleton da uygulama daha açılırken kurucu method çalıştı yazardı registerLazySingleton da ise ilgili sayfaya gittiğimde kurucu method çalışacak
}

//!8.DERS 4.KISIM: ben bu yukardaki işlemleri yaptığım zaman widget ağacında yani uygulamanın içinden bir yerlerde biz bu SecureStorageService nesneye locator.get diyerek yada daha mantıklısı locator<LocalStorageService>(); diyip erişebiliriz

void main() {
  //!8.DERS 7.KISIM : ilk  FileStorageService denedik ve hata aldık sebebi: FileStorageService kurucusunda _createFile diye bir fonksiyon çalışıyor ve bu bir asenkron yani bizim uygulamamız bir an önce açılmaya çalışıyor ama uzun sürecek bir işlem varve bu daha bitmemiş bu gibi durumlarda biz daha runApp() çalıştırmadan önce uzun sürecek işlemleri hazır hale getirmek için WidgetsFlutterBinding.ensureInitialized(); yazmamız lazım bu ifade ile artık runApp() den önce uzun sürecek işlemlerimiz varsa onlar ayarlanacak
  WidgetsFlutterBinding.ensureInitialized();

  //!8.DERS 8.KISIM : daha sonra SecureStorageService denedik ve yine hata aldık bu hatayı 4_secure_storage.dart ta çözüyoruz

  //!8.DERS 10.KISIM : en sonda SharedPreferenceService deneyelim ve burda da hata aldık SecureStorageService aldığımız hatanın aynısı onunda kurucusu yok ve her SharedPreferenceService içine girince ikinci kez nesne üretmeye çalışıyor kurucu fonk. oluşturup nesne üretmeyi onun içinde yaparak bir kere nesne oluşturulmasını sağladık
  
  //!8.DERS 6.KISIM:setup fonk. oluşturduk fakat hiçbiryerde kullanmadık buraya gelip bu methodu widget treem oluşmadan öönce çağırıyorum
  setup();
  
  runApp(const MyApp());

  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      title: 'Flutter Storage',
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Storage Islemleri'),
        ),
        body:  Center(
          child: ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return  SharedPreferenceKullanimi(); 
            },));
          }, child: const Text("Shared Preferences Kullanimi")),
        ),
      );
  }
}

