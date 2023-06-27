
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/firestore_islemleri.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';



void main() async {
  //bu kısmları videodan izlenip kuruldu
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Firebase Dersleri'),
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
  final String _email = "canmahmutyazlak@gmail.com";
  final String _password = "password123";

  //FirebaseAuth initalized kısmı videoda normalde documanda var fakat ben bu kısmı bulamadım kendim yazdım
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    //!2.DERS 1.KISIM----------
    //!authentication state:
    //-->bizim firebase userımız o an login olmuş mu veya login olmamış mı ve bu değişiklikler olurken kullanıcı oturumu açarken veya oturumu kapattığında tetiklenen bir yardımcı Stream yapısı

    //!Stream:
    //-->anlık olarak değişiklikleri herhangi bir setState vs demeden direkt olarak bize ileten yapılar

    //authStateChanges ile burda ki değişiklikleri dinliyoruz bu bize eğer varsa bir user verir eğer bu null sa kullanıcı oturumu kapatmış eğer kullanıcı oturum açarsada oturum açık yazacak
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User oturumu kapali');
      } else {
        debugPrint('User oturum açik ${user.email} ve email durumu ${user.emailVerified}');
      }
    },
    //uygulama ilk açıldığında bu tetiklenir kullanıcı oturum açtığı için direkt bana bu bilgiyi verdi ve yarın öbürgün ben bir butona basıp oturumu kapattığımıda da burası yine çalışcak herhangi bir setState vs dememe gerek yok bu şu işe yarayacak:bu 2.DERS 2.KISIM daki kodları en başa kullanıcı log outa bastığında gidilecek sayfayı mesela login sayfasını buranın içinde yapabiliriz yani sürekli olarak her log out olduğunda şu sayfaya git dememize gerek yok bu sürekli olarak kulağı bizim fireBase userımızda acaba şuan var mı / yok mu bi ilk çalıştırıldığında tetiklenir bir de kullanıcı oturum açmışsa ve oturumunu kapatmışsa burası tetiklenir 
    //!-----------------
    );
  }

  @override
  Widget build(BuildContext context) {
    return FirestoreIslemleri();
  }

  Scaffold firebaseAuthenticationIslemleri() {
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            onPressed: () {
              createUserEmailAndPassword();
            },
            child: const Text("Email/Sifre Kayit"),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            onPressed: () {
              loginUserEmailAndPassword();
            },
            child: const Text("Email/Sifre Giris"),
          ),
           ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.orange)),
            onPressed: () {
              signOutUser();
            },
            child: const Text("Oturumu Kapat"),
          ),
           ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
            onPressed: () {
              deleteUser();
            },
            child: const Text("Kullanıcıyı Sil"),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.purple)),
            onPressed: () {
              changePassword();
            },
            child: const Text("Parola Degistir"),
          ),
           ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.brown)),
            onPressed: () {
              changeEmail();
            },
            child: const Text("email Degistir"),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber)),
            onPressed: () {
              googleIleGiris();
            },
            child: const Text("google ile giriş yap"),
          ),
           ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal)),
            onPressed: () {
              loginWithPhoneNumber();
            },
            child: const Text("telefon numarasi ile giriş yap"),
          ),
          
        ],
      ),
    ),
  );
  }

  //!kullanıcıyı e-mail ve şifre ile kaydetme işlemi
  void createUserEmailAndPassword() async {
    //kullanıcyı bu şekilde kaydediyoruz
    try {
      var _userCredential = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      debugPrint(_userCredential.toString());


      //!2.DERS 2.KISIM mail kontrolünün yapılması
      //!------------------
      //ben bir kullanıcıyı kayıt etikten sonra kullanıcının sistemi doğrudan kullanmasını istemiyorumda gidip e-mailini onaylamasını istiyorum işte onu createUserEmailAndPassword() içinde yapacağız user oluşturulurken kontorlleri sağlamalıyız
      //bu işlemleri yapınca mail adresimize bir mail geliyor ordaki linke tıklayınca emailVerified etmiş oluyoruz
      var _myUser = _userCredential.user;//oturum açmış kullanıcı 
      if(!_myUser!.emailVerified)
      {
       await _myUser.sendEmailVerification();
      }
      else
      {
        debugPrint("Kullanıcının maili onaylanmış ilgili sayfaya gidebilir");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
      //!------------------

  }

  //!kullanıcının e-mail ve şifre ile girişi
  void loginUserEmailAndPassword() async {
    try {
      var _userCredential = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint(_userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());

     //bu buton tetiklenince de  authStateChanges ksımı tetiklenir 2.ders 1.kısımdaki yer
    }
  }

  //!2.DERS 2.KISIM oturumu kapatmak için
  //OTURUMU KAPATMAK İÇİN
  void signOutUser() async{
    


    //!2.DERS 7.KISIM google ile oturumu kapatmak
    //!----------------------
    //otutumu kapatmak için ayrı bir buton yapmıyoruz da giriş yaparkanki GoogleSignIn ni kullanacağız çünkü çıkış yaparken döndüreceği durumlar vs benim için önemli değil
    //bu komut ise google tarafında çıkış yapmasını sağlayacak böylece gmail e giriş yaptıptığında her seferinde gmail mi girebileceğim bir ekran sunmuş olacak
    var _user = await GoogleSignIn().currentUser; //google ile sign in olmuş bir user varsa onu _user değişkenine atacak 
    if(_user != null)//eğer null değilse çıkış yapacak
    {
      await GoogleSignIn().signOut();
    }
    //!----------------------

    //yukardaki şart olmazsa yani google ile giriş yapılmadıysa da her türlü firebase den çıkış yapılacak çünkü bu butonu normal email-şifre ile kayıt olan kullnıcılarda kullanıdığı için eğer ki google sign in olunduysa google den çıkış yapılacak eğer goole dan giriş yapılmadıysa her türlü firebase den çıkış yapılacak DERS2 2.KISIM kodu alttaki kod yani
    //signOut geriye herhangi bir şey döndermez geçerli kullanıcının oturumu kapatılır. ve ben bu butonu tetikleyince otomatik olarak [authStateChanges] kısmı tetiklenecek çünkü benim kullanıcımın authStateChanges durumu sürekli olarak yenileniyor
    await auth.signOut();//bu firebase kısmından çıkış yaparken
    
  }
   
  //!2.DERS 3.KISIM hesabını silmek için
  void deleteUser() async{
    if(auth.currentUser != null)
    {
     await auth.currentUser!.delete();//kullanıcı hesabını silecekse giriş yapmış olmalı o yüzden current user ı elde edip delete ile siliyoruz
    }
    else
    {
      debugPrint("Kullanıcı oturum açmadığı için silinemez");
    }
  }

  //!2.DERS 4.KISIM şifre güncellemk için
  void changePassword() async{
    //bir kullanıcı şifresini veya e-mailini değiştirmek istiyorsa giriş yapmıştır o yüzden currentUser ile o anki kullanıcı üzerinden işlem yapacaktır
    //todo: NOT: biz mobilde firebase auto kullanarak oturum açtığımızda bu oturum uygulama kapanıp açılsa veya sayfalar arası gezsek dahi sürekli olarak açık kalıyor taki kullanıcı oturumu kapat butonuna basna kadar veya uygulamamnın cash memoryisini silene kadar ve mesela 3 gün 4 gün uygumamızı aynı oturumda kullandı ve biz şifreyi , emaili güncelle gibi aslında güvenlik açığı olacak bir istekete bulunduğumuzda firabase hata fırlatıyor. bu çok hassas bir işlem şifreyi güncellemek veya e maili güncellemek o yüzden bundan önce bir daha oturum aç yani email ve şifreni bir daha ver bana diyor 
    try {
    await auth.currentUser!.updatePassword("password123");//yeni sifre yazılır
    await auth.signOut();//şifre güncellendikten sonra kullanıcıyı bi oturumdan atsın
      
    }
    //not daki hata çok genel bir şey olduğu için ona özel bir kontrol yapıyoruz
    on FirebaseAuthException catch(e){
      //erğer ki not ta yazdığımız hata çıkıyorsa şifresini değiştirmeden önce tekrardan bir oturum açmalı ki bu isteği gerçekleşsin eğer bu hata gerçekleşirsede yapacağımız işlemleri if içine yazıyoruz
      if (e.code == "requires-recent-login") {
        debugPrint("reauthenticate olunacak");
        var credential = EmailAuthProvider.credential(email: _email, password: _password); //şifreyi değiştirmeden öncei bilgileri istiyor
         await auth.currentUser!.reauthenticateWithCredential(credential);
        //re authenticate olduktan sonra şifre güncellemeyi yapsın
         await auth.currentUser!.updatePassword("password123");
         await auth.signOut();
         debugPrint("Şifre güncellendi");
      }
    }
     catch (e) {
      debugPrint(e.toString());
    }
  }

  //!2.DERS 5.KISIM mail güncellemk için
  
  void changeEmail() async{
    
    try {
    await auth.currentUser!.updatePassword("mahmutcanyzlk@gmail.com");//yeni mail yazılır
    await auth.signOut();      
    }  
    on FirebaseAuthException catch(e){  
      if (e.code == "requires-recent-login") {
        debugPrint("reauthenticate olunacak");
        var credential = EmailAuthProvider.credential(email: _email, password: _password); //eski bilgilerle  reauthenticate oluyor
         await auth.currentUser!.reauthenticateWithCredential(credential);        
         await auth.currentUser!.updateEmail("mahmutcanyzlk@gmail.com");
         await auth.signOut();
         debugPrint("mail güncellendi");
      }
    }
     catch (e) {
      debugPrint(e.toString());
    }
  }
  


  //!2.DERS 6.KISIM google ile giriş yapmak
  //todo:NOT----->>>>google ile giriş yapmak hizmetini kullanmak için: CLI çoğu şeyi ayarlıyor ama sen bazı kısımları ayrıca yapman lazım sms , google .. gibi şeylerde bunu yapman lazım  https://firebase.flutter.dev/docs/manual-installation/android bu adreste neler yapmamız gerektiğini anlatıyor
  //0: Authentication da Sign-in  method da google aktif etmemiz gerek
  //1: SHA sertifikasına ihtiyacımız var onu oluşturmamız lazım terminale gidip projemizin içindeyken cd android->ls->.\gradlew signinReport--> terminalden SHA1 de yazan kodu alıp firebase consolede projemizin ayarlar kısmında en altta android için SHA certificate yazan yere add diyip ekliyorsun aynı yere terminaldeki SHA-256 yıda ekliyorsun bunlar bu projede google ile girişi desteklememiz için yapmamız gerekenlerin bir kısmı
  //2: AYNI YERDEN google_hizmetleri_json dosyamızı indiriyoruz ve bu dosyayı projemizde android->app in altına kopyalamamız lazım
  //----- https://firebase.flutter.dev/docs/manual-installation/android bu adreste neler yapmamız gerektiğini anlatıyor
  //3: android/build.gradle ye ---> classpath 'com.google.gms:google-services:4.3.8'
  //4:android/app/build.gradle ---> apply plugin: 'com.google.gms.google-services'
  //5:android/app/build.gradle ---> min sdk version 21 yaptık
  //6: bu işi yapacak paketimizi indiriyoruz google_sign_in

  //-----https://firebase.flutter.dev/docs/auth/social adrsinde google ile olan kodları alıp buraya yapıştırıyorum
  
  void googleIleGiris() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();//signIn methodu tetiklendiğinde kullanıcıya bir arayüz sunacak ve kullanıcı burdan google hesabını seçip giriş yapacak

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;//daha sonra bu bize bir googleAuth oluşturacak 

  //burada da credential var bu adam başarılı bir giriş yaptı onun bilgileride bunlar
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
   //credential bilgileri doğruysada başarılı bir şekilde google hesabını girmiştir ve uygulamayı kullanmak istiyor demek
   await FirebaseAuth.instance.signInWithCredential(credential);
  }


  //!2.DERS 7.KISIM telefon numarası ile giriş yapmak
  //0: Authentication da Sign-in  method da phone enable etmemiz gerek ve orda bir numara ve o numaraya göndereceğin kodu giriyorsun
  //1: bizden SHA1 kodunu istiyor biz onu google ile giriş için yapmıştık nasıl elde edildiğini google ile giriş kısmına bakabiliriz
  //2: https://firebase.google.com/docs/auth/flutter/phone-auth?hl=tr dökümantasyonundan aldığımız kodları fonksyionumuza yapıştırıyoruz

  void loginWithPhoneNumber()
  async{
    await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+905378969957', //firebase consolde de eklediğimiz(0:adımdaki) numarayı ekliyoruz


    //todo: telefon numramız bazen otomatik olarak doğrulanır o durumlarda verificationCompleted() fonk çalışır. buda bize elde etmek istediğimiz credential verir ama eğer otomatik tanımlama olmazsa codeSent: kısmı çalışır
    //verificationCompleted methodu tetiklendiğinde biz başarılı bir şekilde giriş yapmışızdır. kullanıcıya bir sms vs bazen androidlerde öyle oluyor firebase bize bir sms yolluyor ama kullanıcın illa bunu girmesi gerekmiyor ve direkt olrak diyorki evet bu onaylanmıştır bu numraya sahip kullanıcı budur. o yüzden direkt olraka bu fonksiyon tetikleniyor ve biz bu fonksiyonda kullanıcıyı sistemimize dahil ederiz
    //bu fonksiyon: bize credential verir biz bu credentialkullanarak aynı google da olduğu gibi bu credential kullanarak bu kullanıcıyı firebase Authentication users kısmına ekliyoruz
    verificationCompleted: (PhoneAuthCredential credential) async{
      debugPrint("verification completed tetiklendi");
      await auth.signInWithCredential(credential) ;
      debugPrint(credential.toString());

      },

      //kullanıcı yanlış bir telefon numarası vs verdiğinde verificationFailed bu fonksiyon teteiklenir
    verificationFailed: (FirebaseAuthException e) {
      debugPrint(e.toString());
    },

    //todo: eğer tel. numarası otomatik tanımlanmazsa firebase bize bir kod yollar. burda kullanıcıya bir arayüz sunarız kullanıcının bu kodu girmesi için kullanıcı oraya 440931(firebase de ki doğru kodu girerse) _credential oluşturarak kontrol ederiz eğer kullanıcının giridiği kod doğruysa başarılı bir şekilde sisteme giriş yapar 
    //kullanıcı numarasını yazdı ve 6 karekterli bir sayı yollanıyor ve kullanıcıya işte burda o sayıyı yazacak bir arayüz beklenir ve o sayıyı kullanarakta kullanıcının oturum açmasını yani verificationCompleted(credential) içindeki  credential oluşturmamız beklenir
    codeSent: (String verificationId, int? resendToken) async{
      debugPrint("codeSent tetiklendi");
      String _smsCode = "440931"; //bunu kullanıcıdan aldığımızı varsayalım
      //girdiğimiz kod ile firebase in bize gönderdiği kodun doğru olup olmadığını kontrol edeceğiz
      var _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: _smsCode);
      //_credential oluşturduktan sonrada bunla kullanıcının giriş yapmasını signInWithCredential diyerek beklememiz lazım
      await auth.signInWithCredential(_credential) ;

    },
    //belli  bir süre koun yenilenmesi yani direkt olarak firebase bize her istediğimizde sms atmazda belli bir süre veriyoruz o süreden sonra tetiklenen yer çok kullanımı yok default bu 30 sn dir 30 sn boyunca cihaz fiebase bana bir mesaj atsada ben onu işlesem diye bekliyor 30 sn geçtikten sonra burası iptal edilip debugKısmı ekrana yazılıyor
    codeAutoRetrievalTimeout: (String verificationId) {
      debugPrint("code auto retrieval timeout");
    },
  );

  }  
}

