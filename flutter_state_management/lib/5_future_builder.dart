import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/model/5_cat_fact_model.dart';

//!FUTURE PROVİDER:
//futureProvider da future olan değerlerin ağaca enjekre edilmesidir.
//benim şimdiye kadar future ihtiyacım oluyordu ya veritabanına bağlanırken yada internetten veri getirken asyn await işlemleri yapmam gerekiyordu ama aync aeait yapmam gereken bir yerde provider lullanamam bu gibi durumlarda future provider kullanırım yani biz doğrudan provider üzerinden erişmek istiyorsam ve bu eğer future ise future provider kullanırım


//bir kedi leri gösteren api kaynağı bulduk onu kullanmak için dio kütüphanesini import ettik
//her bir istekte ido yu yeniden initialize etmektense lazım olduğunda widget treemde bana dio yu verecek bir provider tanımlarız ve klasik provider olacak çünkü dio nun initialize edilmesinde herjhangi bir async await durumları yok 


final HttpClientProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: "https://catfact.ninja/")); //bundan sonra yapacağım bütün istekler bu linke doğru olacak diyoruz 
});

//en sonda elde edeceğim yapı kediler ile igili bilgiler ve direkt oalrak provider ı kullanamam çünkü burada async await lik bir durum var ondan dolayı futureBuilder kullan ve bu provider ile içinde kedi modellerinin bulunduğu bir liste geriye dönderilecek
//!6.DERS 2.KISIM 1 apiden gelen verileri limiti x tane max lengti şu kadar olsın diye link üzerinde filtreleyebiliriz ama bunu dio üzerinden hatta provider dan nasıl uygularız ona bakacağız ilk başta tek bir değeri gösterelim bu ref i watch lediğim yerde ref.watch(catFactsProvider(x)) diye bir parametre geçtik işte bunu yapmak içinde futureProvider.family diyoruz ve int şeklinde ekleme yapyoruz aşağıdaki satırda olduğu gibi ve biz aşağıda x e 4 dedik ve int olarka tanımladık string bir ifade yazamayız
 
//!6.DERS 3.KISIM 1 diyelimki api kaynağımıdaki diğer filtreleme özelliğinide göndereceğiz diyelim gidip LimitDegeri gibi max değerini yazamıyoruz çünkü family 1 parmetre alırdı dışarıdan bize diyoruzki bir parametre alıyor evet ama biz bu parametreyi içinde birden çok değer alan bir map yapısı şeklinde düzenleyebiliriz ve artık limitDegeri içinde string ve dynamic değerler tutan bir map olur

//!6.DERS 3.KISIM 2
final catFactsProvider = FutureProvider.autoDispose.family<List<Datum>,Map<String , dynamic>>((ref, parametreMapi) async 

//!6.DERS 2.KISIM 2
//final catFactsProvider = FutureProvider.family<List<Datum>,int>((ref,LimitDegeri) async 

//!5.DERS 
//final catFactsProvider = FutureProvider<List<Datum>>((ref) async 
{
  final _dio = ref.watch(HttpClientProvider);
  //!6.DERS 3.KISIM 4
  final result = await _dio.get("facts",queryParameters:parametreMapi 
  /*
  {
    "limit":parametreMapi["limit"],
    "max_length":parametreMapi["max_degeri"]
  }
  */
    );
  //!6.DERS 4.KISIM autoDispose u kullandığımız zaman keepAlive fonksiyonunu kullanabiliriz bu şu işe yarıyor eğer ki sayfada bir hata alırsak ve geri çıkıp tekrar girersek tekrar int. gitmeyi engelliyor getirdiklerini kullanıyor yani aslında hafızada tutuyor
  ref.keepAlive();

  //!6.DERS 2.KISIM 4 bu filtreleme değerinide burada tanımlıyoruz bunu tanımlamak için queryParameters diyte bir map yapısı istiyor ve bu map yapısınıda bizim api kaynağımızda "limit" diye geçiyordu değer oalarkta LimitDegerini yolluyoruz limitDegerinde de 4 değeri var 
  //final result = await _dio.get("facts",queryParameters:{"limit":LimitDegeri});

  //final result = await _dio.get("facts"); 6.ders için //todo: yukarda baseUrl in sonuna facts gelirse kediler ile ilgili datalar gelir
  List<Map<String , dynamic>> _mapData = List.from(result.data["data"]);//results bir map yapısı verir bunun içinde bir çok bilgi var ama ben bunun içinde body kısmını istiyorum o yüzden data dedik veri kaynağımda da ilgilendiğim yer in ismi data o yüzden "data" dedik ve List.from demek içindeki değerlerle yeni bir liste oluştur 
  List<Datum> _kediListesi = _mapData.map((e) => Datum.fromMap(e)).toList(); //burasu _mapData nın liste olduğunu anlamadık _mapData ya gidip veri tipine bu bir List e içinde map ler var veri türü olarak ta key string valulerı ise dynamic dedik   
  return _kediListesi;
});

class FutureBuilderKullanimi extends ConsumerWidget {
  const FutureBuilderKullanimi({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    //!6.DERS 3.KISIM 3 
    //todo:BURADA BİRDEN FAZLA PARAMETRE İÇİN MAP YAPISINI GÖNDERDİĞİMİZ ZAMAN VERİLER GELİMİYOR BUNUN SEBEBİ FAMİLY BİZDEN IMMUTABLE DEĞİŞKEN İSTİYOR(int boolean string) AMA MAP MUTABLE BİR YAPIDA DIŞARIDAN DEĞİŞTİRİLEBİLİR BİR YAPI BUNU IMMUTABLE YAPMALIYIZ SAPITMA SEBEBİ BİZ PROVİDERLARI BUİLD İÇİNDE TANIMLIYORUZ BUİLDDE TEKRAR TAKRAR ÇALIŞIR VE HER SEFERİNDE YEP YENİ İSTEKTE BULUNUYOR BUNU ENGELLEMEK İÇİNDE //! CONST YAZIYORUZ
    var _liste = ref.watch(catFactsProvider(const{
      //buradaki isimlendirmeler api kaynağındaki isimler ile aynı olmalı 
      "limit":4,
      "max_length":30
    }));

    //!6.DERS 2.KISIM 3 catFactsProvider(4) değerini tanımladık 
    //var _liste = ref.watch(catFactsProvider(4));

    //var _liste = ref.watch(catFactsProvider);6.ders için//todo: bu bize AsyncValue<List<Datum>> diye bir şey veriyor aynı şey streamProvider içinde geçerli ve bunun when methodunu kullanıyoruz 
    return Scaffold(
      appBar: AppBar(title:const Text("Future Provider")),
      body: SafeArea(
        //todo when:::::
        //!when: tek bir sonucun durumlarını farklı farklı 1 kerede ele alıypruz. sen bunu dinliyorsun data geldiğinde data kısmı hata çıkarsa error kısmınıloading veri gelirkende loading kısmı asyn await kısım aslında freeze den geliyor unionClass diye bir kavram var dartta yok ama when eklentisi bunu sağlıyor artık bunu kullanırsam future buildera da ihtiyacım yok
        child: _liste.when(data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            
            return ListTile(
              title: Text(data[index].fact),
            );
          },);
        }, error: (error, stackTrace) {
          return Text("hata çıktı: ${error.toString()}");
        }, loading: () {
          return const Center(child: CircularProgressIndicator(),);
        },)
      ),
    );
  }
}


//!6.DERS 1.KISIM
// riverpod un providerlarında iki tane var bunlar family ve autodispose
//todo family:
//family i biz providerlarımıza dışarıdan paramete yollayarak kullanırız bu sadece futureProvider değil diğer providerlarda da bu kullanılabilir. ve  family dışarıdan sadece 1 tane parametre istiyor ama eğer ki birden fazla değer göndereceksek tanımladığımız parametre int gibi bir parametre değilde bir map yapısı gönderebilirsin
//todo autoDispose.family:
//eğer bı state daha erişilmicekse bunun verilerini silecek ve tekrar girdiğim de bir daha bu verileri geri getirecek yani otomatik olarak ilgili state yi yok ediyor eğer future işlemi varken bunu kullanmak önerilir

