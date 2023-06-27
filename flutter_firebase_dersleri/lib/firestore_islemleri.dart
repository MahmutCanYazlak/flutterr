//!FİRESTORE TEMEL BİLGİLER
//collection: klasöre benzetebiliriz mp3 dosyalarımız  var bu mp3 dosyalarımızı topladığımız klasör collection içerisindeki her bir mp3 dosyalarımız ise dökümantasyonumuz olacak
//collectionu direkt olarak birşey ekleyemiyorum önce başlatmam lazım ve her bir collectionu  birbirinden ayıran idlerimiz var 
//dökümanları bir arada tutan yapıya collection diyoruz verilerimi tutan yapıyada document diyoruz 
//bir document in içinde başka bir document te saklayabiliriz ama direkt olarak bunu yapamıyoruz collectionunun içinde start collection diyeceğiz  

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreIslemleri extends StatelessWidget {
   FirestoreIslemleri({super.key});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //!4.DERS 2.KISIM
  StreamSubscription? _userSubscription ;






  @override
  Widget build(BuildContext context) {


    //IDler
    debugPrint(_firestore.collection("users").id);//arayüzden bir koleksiyon eklemek istediğimiz zaman bizden isim istiyor biz users yazıyoruz ama aslında orda collection id diyor yani user isimli collection un id si aslında bir users dır
    debugPrint(_firestore.collection("users").doc().id);//eğer bunun içinde add ile birşey ekliceksen onun id bu burda çıkan ğid olacaktı ve bu her çalışdtığında değişiyor 




    return Scaffold(
      appBar: AppBar(title: const Text("Firestore islemleri")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                veriEklemeAdd();
              },
              child: const Text("veri ekle Add"),
            ),
            ElevatedButton(
              onPressed: () {
                veriEklemeSet();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("veri ekle Set"),
            ),
            ElevatedButton(
              onPressed: () {
                veriGuncelleme();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("veri güncelle"),
            ),
             ElevatedButton(
              onPressed: () {
                veriSil();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("veri sil"),
            ),
             ElevatedButton(
              onPressed: () {
                veriOkuOneTime();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text("veri oku On Time"),
            ),
             ElevatedButton(
              onPressed: () {
                veriOkuRealTime();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text("veri oku Real Time"),
            ),
            ElevatedButton(
              onPressed: () {
                streamDurdur();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
              child: const Text("Stream durdur"),
            ),
            ElevatedButton(
              onPressed: () {
                batchKavrami();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text("Batch Kavrami"),
            ),
            ElevatedButton(
              onPressed: () {
                transactionKavrami();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text("Transaction Kavrami"),
            ),
            ElevatedButton(
              onPressed: () {
                queryingData();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("Veri sorgulamak"),
            ),
            ElevatedButton(
              onPressed: () {
                kameraGaleriImageUpload();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white38),
              child: const Text("kamera galari image upload"),
            ),
          ],
        ),
      ),
    );
  }






  //!VERİ EKLEME 2.DERS 1.KISIM
  //todo: veri eklemek için iki method var set ve add


  //!ADD: add methodunda id değeri otomatik atanır eğer ıd varsa set i kullnırız
  //add methodunda direkt olarak kolekisyona dökümanı eklerken.  Bir koleksiyonu kullanmak için mutlaka ona bir döküman eklememiz gerek ona direkt olarak veri yazmaya başlayamıyoruz o yüzden _firesrore üzerinden öncelikle benim bir collectiona erişmem lazım
   veriEklemeAdd() async{
    //users koleksiyonuna bakacak eğer yoksa ekleyecek varsa aynı onun üzerinden devam edecek 
    Map<String , dynamic> _eklenecekUser = <String , dynamic>{};
    _eklenecekUser["isim"]="Ozan";
    _eklenecekUser["yas"]=23;
    _eklenecekUser["ogrenciMi"]=false;
    _eklenecekUser["adres"]={"il":"Hatay", "ilce":"Iskenderun"};
    _eklenecekUser["renkler"]=FieldValue.arrayUnion(["gri", "mor"]);//firestore de dizleri bu şekilde tanımlarız  mavi ve yeşil değerlerinde bir dizi tanımlanır ve bu dizi renkler altında tanımlanacak
    _eklenecekUser["createdAt"]=FieldValue.serverTimestamp();//kullanıcının ne zaman oluşturulduğunu veritabanında tutmak için bu komutla bu verinin firebase yazıldığı andaki tarih değerini createdAt in altına atacaktır
    
   await _firestore.collection("users").add(_eklenecekUser);
  }
  
  
  
  
  
  //!SET: set olması için bir dökümanın elimde olması lazım. SET: DÖKÜMAN ÜZERİNDEN ADD:COLLECTİON ÜZERİNDEN. EĞER ID BEN VERMİCEKSEM ADD , EĞER O DÖKÜMAN HAZIRSA BİLİYORSAM O DÖKÜMANIN NE OLDUĞUNU ID DEĞERİ VARSA SET KULLANIRIM
  //ben bu user ın artık id sini biliyorum veritabanımda artık o var 
   veriEklemeSet() async{
    //todo:NOT: set bizim burda vermiş olduğumuz documanın üzerine yazıyor verileri biz burda sadece okul değerini verirsek o documanda ki tüm değerleri siler. eğre ki elemanı eklesin ama var olan değerlerinde bozulmasını istemiyorsak set'in diğer parametresinde zorunlu olmayan SetOptions değişkenini kullanmamız gerekir marge:true dersek yeni değeri keler var olan değerlere dokunmaz
   await _firestore.doc("users/4YfJmydfpSI1b8D5Mb6n").set({
    "okul":"Ege Üniversitesi",
    "yas":FieldValue.increment(1)//her okumada 1 arttır dedik bu counter gibi çalışıyor normalde burda bir yas değeri var mesela 23 bunu güncellemek demek şu demek önce bunu oku 23 ü bul sonra onu 1 arttır 24 yap ondan sonra o veriyi al geriye yaz demek işte bu increment bu adımları tek bir seferde yapıyor yas değerini alacak 1 arttıracak yerine geri koyacak buraya eksi değerlerde koyabilirsin
   }, SetOptions(merge: true));

  //!2.DERS 2.KISIM id değerini öğrenmek 
  //eğer ki sistemin atayacağı otomatik id değerini yazmadan bilmek istiyorsam bu id değerini verimin içinde de iseyebilirim. çünkü o id değreini yarın öbürsügün sorgu yaparken gir bana içinde id değeri bu olan verileri göster gibi durumlar olabilir.
  //id kavramıı hem döküman için hemde koleksiyon kavramı için mevcut 
  var _yeniDocID = _firestore.collection("users").doc().id; //burda bunu üretsin ne olduğu benim için hiç önemli değil önemli olan benim burda bunu bilmem ve veritabanına yazmam

  await _firestore.doc("users/$_yeniDocID").set({
    "isim":"Mahmut",
    "userId":_yeniDocID,//aslında firebase bunu bize veriyordu zaten ama diyelim ki başka bir veri tutacağız id sini bilmek istiyoruz
    
  } ,SetOptions(merge: true));

  }

  

  //!VERİ GÜNCELLEME 2.DERS 3.KISIM
  //bir verimiz olacak ki biz bunu güncelleyelim veya silebilelim o yüzden document kullanacağız collectionsda da bir koleksiyonun hepsini silersin
  void veriGuncelleme() async{
    //butona basınca eğre ilgili döküman varsa günceller
    await _firestore.doc("users/4YfJmydfpSI1b8D5Mb6n").update({
      "isim":"Seren",
      "ogrenciMi":false,
      "olamayanKey":true,//eğer olmayan bir alan verirsen o alanı oluşturur eğer var olan bir alan olsaydı orayı güncellerdi
      "adres.ilce":"Akcadag",//adres kısmındaki ilçe alanını güncelledim bu adrs ksımını komplede güncelleyebilirdim
    });
  }

  //todo:NOT: set teki marge işleminden bunun farkı update yi kullanırsak muhakkak bir döküman olmalı eğer yanlış döküman girsen sisrem hata verir set dediğimide ise ordaki id olamasa bile bu dökümanı  oluşturacaktı verdiğimiz değerlerle birlikte 
  


  //!VERİ SİLMEK İÇİN 2.DERS 4.KISIM
  //todo: 1.Yol:
  //bir dökümasyonu silmek istiyorsak yine o dökümana erişmek gerekir 
  void veriSil() async{

    await _firestore.doc("users/4YfJmydfpSI1b8D5Mb6n").delete();

  //todo: 2.Yol:
  /*1.yöntem için iptal ettik
    await _firestore.doc("users/4YfJmydfpSI1b8D5Mb6n").update(
      {
        "okul":FieldValue.delete()
      }
    );
  */


  }
  

  //! VERİ OKUMAK İÇİN : 3.DERS 1.KISIM
  //TODO: veri okumak için de iki tane yöntem var 1:koleksiyon üzerinden ilerlediğimiz yapılar  2:dökümanın direkt kendisi üzerinden  yapabileceğimiz eylemler ve burda da yine  iki versiyonu var 1: one time (bir kerelik): uygulama açıldığında veya butona basıldığında veritabanına git o anki verileri al buraya getir bu one time. 2: Real time: biz belli bir koleksiyona yada dökümana listener atayabiliyoruz ordaki herhangi bir değişiklik olduysa(consoleden değiştiebiliriz , kullanıcı değiştirebilir) bu güncellenme real time anlık bir şekilde uyg yansıyabiliyor
  void veriOkuOneTime() async{
    //!burda one time kullandık 
    //todo. one time demek yani butona basıldığında sayfa açılşdığında bir kerelik o anki veritabanının içinde bulunan verilerin bir fotoğrafı çekiliyor biz buna get dediğimizde o anki verilerin fotoğrafı çekiliyor ve bize bunlar veriliyor ve bunlar bir kerelik 

    //todo:burda Colection üzerinden verilere eriştik.
    var _usersDocuments= await _firestore.collection("users").get();//veriler get ile gelir
    debugPrint(_usersDocuments.size.toString());
    //gizle
    //bu elemanlarımızın sayısını verir ama sıkıntı çünkü eleman sayısı kadar okuma yapar. direkt sayıyı veren bir method yok farklı yollarla bulabiliriz mesela firestore ye gidip yeni bir counters isimli collectio oluşturup  içine de userCounters isimli dovument oluştururuz ve her users collecitonuna yeni bir document eklediğimiz zaman bu userCounter değerini bir arttırırz böylece 100000 document imde olsa ben bu sayıyı tek okuma ile usersCounter üzerinden yapacağım. DAHA etkin bir yöntem ise cloud fuctionları kullanamak bunlarda user düğümüne bir kayıt oluşturuldupunda aşağıdaki kodları çalıştır diyebiliyoruz her users oluşturulduğunda bu counteı 1 , 1 atrrırırız ve bu işlemi clientten almış oluruz 
    debugPrint(_usersDocuments.docs.length.toString());//docs bize bir liste veriyor o zaman liste ile ilgili methodları kullanabiliriz. yukardaki size ile aynı işlri yaptı
    //?biz burda yukradaki size ve lengt ile toplam 3+3 = 6 değer yazıldı ama 3 kere okuma yazıldı nasıl? internete gidip firestoreden verileri getridik get ile bundan sonra yapacağıumız bütün işlemler hepsi local yani biz zaten olan bir şeyi farklı bir yöntemle kullanmış olduk sdece 3 okuma yaptık 

    //bütün collectiondaki verilerimin hepsini listelemek istiyorum
    for(var deger in _usersDocuments.docs)
    {
      debugPrint("Döküman id:${deger.id}"); //id değerlerine 
      Map userMap = deger.data();//data bir map türünde map ile ilgili methodları dönebilirim
      debugPrint(userMap["isim"]);//tüm döküman içindeki isim değerlerini gezdik
      
    }

    //todo: burda da döküman üzerinden verilere eriştik ilgili dökümanın id sini bilmemiz gerekir burada ama
    var _MahmutCan = await _firestore.doc("users/VcrosLJtPhx69g4aqLql").get();  
    debugPrint("MahmutCan ile ilgili tüm degerler:${_MahmutCan.data().toString()}");
    debugPrint("MahmutCan il degeri:${_MahmutCan.data()!["adres"]["il"].toString()}");//data bir map verilerin hepsinin olduğu daha sonra git ordan "adres" değerini al o da bir map o map in içinde de git "il" değerini ver dedik şu çalışmadı --->["adres.il"]

  }






  //! VERİ OKUMAK İÇİN : 4.DERS 1.KISIM
  void veriOkuRealTime() async{
    //!burda realTime kullandık
    //userları bir listede göstermek istiyorsam futureBuilder kullanabiliriz futureBuilder bizden future bekliyordu e burda da future veren kodu yani bir listede bütün userları göstermek istiyorsak bir okuma kısmında get bize future sunuyordu ya işte bunu futureBuilder ın future kısmına verirsek bize user ları verir
    //todo: realtime:
    //realtime: şu ana kadar öğrendiğim yaplarda ya bir butona basacaktım  yada ben bu kodları widgetımın initState kısmına yazacaktım sayfa ilk geldiği zaman gelecekti ve ondan sonra veritabanında herhangi bir değişiklik olduğunda bu değişiklik direkt olarak uygulama kısmına eklenmiyor taki bir butona basarız git veritabanına bir daha snapshoot(o anki veri) al.  ve o zaman değişikilk olurdu ama benim öyle bit uygulamam varki veritabanında veriler değişir değişmez  benim ekranıma yazsın çünkü her zaman bir butona basıp verileri tekraradan getiremem bu durumlarda firestore bize kolaylıklar sağlıyor
    //todo: kullanımı: ve STREAM
    //sürekli olarak firestore yı dinleyeceğiz sürekli olarak değişiklik var mı yok mu haber ver işte bunu yapan yapı STREAM yapısıdır. ve işte burda ister bütün collectionu users dite bit collectionumuz var 100 tane kayıt var herhngi bir değişikliğinde haber ver diyebiliriz istersekte MahmutCan dökümanı ile ilgileniyoruz ben sadece x id sine sahip döcümanı dinlemek istiyorum burdaki bir değişikliği bana aktar diyebiliriz

    //realTime ın çalışması için öncelikle veritabanını okuyan veriOkuRealTime() bu fonskiyonu bir kere  tetiklemem gerekiyor ki bu yapı kurulsun ben bunu gidip initstate yazarsam uyg. açılır açılmaz yapı kurulacaktı ama ben  burda butona bağladım



    //todo: burda verilerimizi collection üzerinden dinleyip okuduk

    var _userStream =await _firestore.collection("users").snapshots();//bu satır ile ben artık user ı dinlemek istiyorum demiş olduk ama daha dinlemedik
    //alttaki satır ise user collectionumu dinlicek ve herhangi bir değişikilkte burası sürekli tetiklenecek
    //todo. NOT:biz listen ettiğimiz şeyi her çalıştırdığımızda bir daha bir daha listenlara atama durumu var bunu çözmek için bu listen bize StreamSubscription diye birşey dönderiyormuş abone ol diyor users collectionuna abone olduk ben bunu dinlemeye aboneyim bana yapılan bütün değişiklikleri yolla bunu gidip yukarıda buidin üstüne tanimlicam ki diğer fonk. erişeyim _userSubscription dite tanımladım bunu dinlemeyi durdurmak istediğim zaman kullanabiliriz
     _userSubscription = _userStream.listen((event) {

      /*docs kısmını görmek için
      //docChanges  sadece değişeni verecek ve bu bir liste verir
      event.docChanges.forEach((element) {
        debugPrint(element.doc.data().toString()); //değişen veriyi verir
      });

      */
      
      //docs bir veri değiştiğinde bütün collectioinu verecek biz yukarda users collectionun tamamını dinliyoruz ve elemanların hepsini bize veriyor ama okuma yazma sayısı 1 dir
      event.docs.forEach((element) {
        debugPrint(element.data().toString()); //bütün collectiondaki elemanları tek tek verecek sonrada bu datayı yazdırabilirziz
      });
     }
      
    );


    debugPrint("-------------****************DOCUMANT DEĞİŞİKLİĞİ*****************----------------");

    //todo: burda verilerimizi document üzerinden dinleyip okuduk 
    var _userDocStream =await _firestore.doc("users/amw0UfGcszQhvNMvN6qE").snapshots(); //burda sadece ozan ı dinliyor diğerlerinde yapılan değişiklikleri göstermez
    _userSubscription = _userDocStream.listen((event) {
      //burda docs kullanamıyoruz çünkü biz diyoruz ki sen bir tane dökümanı dinlemek istiyorsun gidipte sana ben docs gibi bir liste vermeyeceğim direkt event.data() ile datayı veriyor yani burda bir liste vermediği için forEach ile gezmeye gerek yok
      event.data().toString();

    });

  
  }


  void streamDurdur() async{
    //artık bunu dinlemede diyebiliriz stream ile uygulama ve database arasında bir boru gibi bağlantı kuruluyor _userSubscription ile aboneliği açıyoruz ve bu aboneliği cansel ile kapatabiliyoruz
    await _userSubscription?.cancel();
    debugPrint("Stream durdu");


  //!not: herhangi bir şey yapmadan ekranda birşeyler değişiyorsa orada stream kullanılmıştır. realtime değişiklikler sürekli olarak dinleniyordur bizde artık bize  one time okumamı lazım yoksa stream lazım real time bir okumamı yapayım anlar onu uygularız
  }
  




  //!5.DERS 1.KISIM BATCH KAVRAMİ
  //verielerimizi for döngüsüyle toplu bir şekilde ekleyebiliriz evet ama diyelimki int. bağlantısı koğtu bir kısmını ekleyemedi bazı tutarsızlıklar ortaya çıkar bu toplu işlemlerde silme ekleme güncellem vb şeylerde BATCH kullanırız. kullanıcının fotoğrafı hem yorumlar collectionunda hem yorum hemde satış kısmında olabilir bu 3 kısımda da güncellenmesi için batch kullanırız batch ve transaction kavramlarında ya hep ya hiç kuralı vardır 100 tane işlemi yaptık ya hepsi olacaktır veri tabanında kaydedilektir yada herhangi birinde hata çıkarsa yapılan değişiklikler geri alıncaktır ondan dolayı klasik bir for döngüsünden farkı budur. batchler 1 seferde 500 tane işlem yapma sınırı var
  void batchKavrami() async{
    //! ÖNEMLİ NOT: WriteBatch _batch = _firestore.batch(); ----ile----_batch.commit(); bu iki yapı arasına batch nesnesini kullanarak işlemleri mi yaparsam ya hep ya hiç ya hepsi olacak yada hiçbiri bu işlemde veritabanı tutarlılığı için çok önemli



    //todo TOPLU EKLEME
    WriteBatch _batch = _firestore.batch();
    CollectionReference _counterColRef=_firestore.collection("counters");
    
    /*
    for(int i=0; i<100 ;i++)
    {

    var _yeniDoc = _counterColRef.doc();
    _batch.set(_yeniDoc,{"sayac":++i , "id":_yeniDoc.id});
    }

    */

    //todo TOPLU GÜNCELLEME
    /*
    var _counterDocs=await _counterColRef.get();
    _counterDocs.docs.forEach((element) { 
      //element.reference o an gezilen elemanın hepsini veriyor bize
      _batch.update(element.reference, {"createdAt":FieldValue.serverTimestamp()});
    });
    */



    //todo TOPLU SİLME
    //FİRESTORE DİREKT OLARAK BİR KOLEKSİYONU BİR KEREDE SİLMEYE İZİN VERmiyor ama güncelleme kıamsındaki gibi bir mantıkla yapabiliriz
    var _counterDocs=await _counterColRef.get();
    _counterDocs.docs.forEach((element) { 
      _batch.delete(element.reference);
    });


    await _batch.commit();
  }







  //!6.DERS 1.KISIM TRANSACTİON KAVRAMİ
  
  void transactionKavrami() {
    //birden fazla art arda gelen işlmeleri tek bir kalemde yapmamızı sağlıyor ve burda önemli olan şey o an ki anlık veri batch de oan ki değer umrumuzda değildi. bu transacrion şöyle mesela biz banka hesabımızdan arkdaşımızın hesabına 100 tl para atçağız önce bizim bakiyemiz okunur daha sonra bakiyemiz 100 tl azalır ve arkadaşımızın hesabındaki para 100 tl artar işlemler bu şekilde fakat internette sorun oldu bakiyemiz azaldı ama para gitmedi işte transectionda şöyle olur herhangi birinde hata çıkarsa tüm işlem iptal olmalı aksi taktirde tutarsız veri olur.burda toplu okuma, yazma yok burda önemli olan o anki değer önemli önce veri okunması ve buna uygun işlemlerin yapılması lazımbir başka örnek ise eğer bir alanı birden fazla kişi güncelleyebiliyorsa o zamanda transaction kullanılır

    _firestore.runTransaction((transaction) async{
      //1.Can ın bakiyesini öğren 
      //2.Can dan 100 tl düş 
      //3.Ozan a 100 tl ekle 
      //bu adımların hepsini tek seferde yapacağız

      //1:can ın o anki bakiyesini öğrenmek için
      DocumentReference<Map<String, dynamic>> canRef = _firestore.doc("users/0RJvSbWl0AHYMqheNDxF");
      //1:ozan ın o anki bakiyesini öğrenmek için
      DocumentReference<Map<String, dynamic>> ozanRef = _firestore.doc("users/amw0UfGcszQhvNMvN6qE");
      var _canSnapshot =(await transaction.get(canRef)); //can datasının o anki hali
      var _canBakiye = _canSnapshot.data()!["para"];
      if (_canBakiye>100) {
        var _yeniBakiye=_canSnapshot.data()!["para"]-100;
        transaction.update(canRef, {"para":_yeniBakiye}); //bu veriyi can da güncelle
        transaction.update(ozanRef,{"para":FieldValue.increment(100)});//ozan danda güncelle
      }



    });


  }
  








  //!7.DERS 1.KISIM VERİLERİ SORGULAMAK

  void queryingData() async{
    //biz sorgulamaları document üzerinden yapamayız collectionlar üzerinden yaparız çünkü document üzerinde kısmi sorgulama yok ne kadar alan varsa biz o documenti okuduğumuzda getirilecekti ama ben mesela users collectionu üzerinde mesela yaşı 30 dan küçük olanları getir şeklinde sorgu yazabilirm yada e-maili şu olanı bana getir diyebilirim

    var _userRef =  _firestore.collection("users");
    //var _userRef = _firestore.collection("users").limit(2); normalde şarta uyan 100 değer varsa 100 ü de gelir ama sen bunu limitleyebilirsin 2 dersen 2 kayıt gelir
    var _sonuc =await _userRef.where("yas",whereIn: [23,39]).get();
    //birden fazla veri gelebilir o yğzden for 
    for (var user in _sonuc.docs) {
      debugPrint(user.data().toString());
    }

      debugPrint("*************************");

    var _sonuc2 =await _userRef.where("renkler",arrayContains:"kirmizi").get();
    //birden fazla veri gelebilir o yğzden for 
    for (var user in _sonuc2.docs) {
      debugPrint(user.data().toString());
    }


      debugPrint("************SIRALAMA*************");

    var _sirala = await _userRef.orderBy("yas", descending: true).get();//descending true ise azalan şekilde sıralar
    for (var user in _sirala.docs) {
      debugPrint(user.data().toString());
    }


      debugPrint("************LİKE*************");
      //firebase de tam bir like işlemi yok bunun için elastic search , Algolia  vb şeyler kullanman lazım biz burda mail adresi can ile başlayanları getirmek için bir kod yazacağız(startAt ve endAt) ve biz bu yöntemleri kulllnamka için önce orderBy ile sıralamamız lazım 
      //todo: burada like yapacağın kısım tek tırnak içinde olmalı
    var _stringSearch = await _userRef.orderBy("email").startAt(['can']).endAt(['can' + '\uf8ff']).get();
    for (var user in _stringSearch.docs) {
      debugPrint(user.data().toString());
    }
    

  }



  //!8.DERS 1.KISIM VERİLERİ SORGULAMAK
  //profil resimlerimizi saklamak istiyoruz diyelim. işte bu gibi durumlarda resimleri veritabanında saklamak yerine storage da yani bizim firebase imizde ki harddiskte saklayıp direstore da da yani veritabanında da bunun inidirilebilir linkini saklamamız lazım. resimlerimiz firebase storage da tutulacak bunun için projemize firebase_storage paketini ekliyoruz.bu örnekleri göstermek içinde image_picker isimli paketi indiriyoruz image picker galeriden veya kameradan hemen resim eklememizi sağlayan bir paket
  //firebase console ye gidip storage kısmından get started diyip test DEĞİL diğerini üsttekini seçiyon daha sonra rules kısmında  write: if true; diyordun ki yazadabilesin
  
  void kameraGaleriImageUpload() async {
    final ImagePicker _picker = ImagePicker();//nesne oluşturduk
    
   XFile?  _file = await _picker.pickImage(source: ImageSource.camera);//burdan kamera yada galeriyi seçiyorsun
   var _profileRef= FirebaseStorage.instance.ref("users/profil_resimleri");//buraya user_id şeklinde ekleme yaparak her user ın id side farklı olacağı için profil resmi altında farklı isimli dosyalar olacak
   var _task =_profileRef.putFile(File(_file!.path));//putFile bizden file istiyor ama yukardaki _file XFile paketimizin kullandığı özel kullandığı bir sınıf. biz burdaki yöntemle böylece dart taki file oluşturmuş olduk XFile kullanark

    //yükleme işi bittikten sonra git indirileblir linkini al veritabanına yaz diyoruz aslında
   _task.whenComplete(() async{
    var _url = await _profileRef.getDownloadURL();//url elde edip veritabanına yazacağız
      debugPrint(_url);
      //bu işlemin sonunda foto çekince sana bir link verdi bu link çektiğim foto firebase e gitti firestore ye eklendi o resme  erişmem için verilen linktir o 
      //url de elde ettikten sonra artık ben aşağıdaki adımları yapıyorum böylelikle resmi seçtiğimizde hem firebase ye yüklemiş olcağız hemde yüklediğimiz resimin firestore ye yazmış olacağız
      _firestore.doc("users/amw0UfGcszQhvNMvN6qE").set({
        "profile_pic":_url.toString()
      }, SetOptions(merge: true));
   });

  }
  



}
