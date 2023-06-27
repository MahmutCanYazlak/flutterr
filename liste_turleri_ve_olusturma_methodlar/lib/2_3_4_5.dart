//eğer bizim tek bir çocuğa ihtiyacımız varsa SingleChildScrollView kullanırız birden fazla çocuğumuz varsa listView kullanırız ama eğer çoook falza elemanımız varsa bu ikisnide kullanmak dinamik olmaz bunlar yerine ListView.builder ı kullannaırız. ListView.builder ın güzelliği elemanlar ekrana geldikçe oluşturulması ve ekrandan kaybolduğunda onların aldığı kaynakların belleğin sisteme geri verdiğinden dolayı bu yöntem daha etkili bu dart projemizde hem dinamik olmayan KlasikListViewKullanimi() örneğini yapacağız hemde dşnamik olan DinamikListViewBuilderKullanimi() ni göreceğiz ve bununyanında dinamik olan ListView.separated u da göreceğiz bunun içinde  DinamikListViewSeparetedKullanimi() fonksiyonunu yapacağız

//DIŞARDAKİ YAPYI HAZIR KULLANMAK İÇİN YAZILMIŞ KOD:dışardaki yapıları hazır kullanmak istersek eğer googla pub.dev yazıyoruz ve kullanmak istediğiin yapının adını yazıyorsun mesela biz toast yapısı kullanacağız daha sonra karşımıza çıkan seçeneklerden populeritesi yüksek olan kurulumu kodları düzgün olan birini seçiyorsun seçtikten sonra pubspec.yaml dosysına gidip aldığın yapının sürümğ olur o sürümü flutter_easyloading: ^3.0.0 bunun gibi dependencies: altına yapıştırıyorsun daha sonra yukardaki butonlardan get packages yapıp kodlarına yapıyı dahil ediyorsun ondan sonra bu yapıyı kullanmak istediğin projeye import işlemini sağlıyorsun eğer import işlemi hata vermezse doğru gitmişsin demek paketi import ettiğin zaman hata alırsan yanlış yapıyorsun demek. daha sonra aldığımız yerin kodunda main dosyasına   builder: EasyLoading.init(), böyle bir şey eklememizi istemiş onu yaptık sonra gelip burda ListTile ın onTop özelliği içinde bunu kullandık ve biz bı yapıya customize işlemleri için pubdev e baktığımız zaman adamlar main dart dosyası içinde bir fonksiyon yapmışlar onların kodunu alıp main.dart projemize uyarlıyoruz


import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';

class listview_kullanimi extends StatelessWidget {
  listview_kullanimi({super.key});
  List<Ogrenci> tumOgrenciler = List.generate(
      500,
      (index) => Ogrenci(index + 1, "Ogrenci adi : {$index+1}",
          "Ogrenci soyadi : {$index+1}"));
  //List.generate listemizi farklı elemanlarla doldurmak için kullanılır parametreleri sırasıyla : listemiz kaç elemanlı olsun , index değeri (bu sıfırdan başlar ve senin 1. parametrede verdiğin değerden 1 eksiğine kadar kendiğinden gider ) ,  ogrenci nesnesini oluştur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Öğrenci Listesi"),
      ),
      //LİSTVİEW.BUİLDER() ListView ın isimlendirilmiş bir kurucusudur bizden bir itemBuilder ister birde itemCount bekler itemBuilder her bir eleman ekrana yazılmadan önce tetiklenen bir lamda ifadesidir itemCount ise göstereceğim listede kaç tane eleman olacak mesela biz burda TumOgrenciler listesinin.length kadar eleman göstermek istedğimi belirttim doğrudan int değerde verebilirisin itemBuilder a detaylı bakarsak bu bir callback fonksiyondur ve her bir eleman ekrana yazılmadan önce çalıştırılır ve bize iki tane parametre verir 1.parametresi BuildContext context yapısıdır hani bunun içinde context e ihtiyaç olur diye veriliyor 2.paremetresi ise int index tir 0 dan başlar ve itemCoun ta gider 500 elaman varsa index max 499 olur ve biz her seferinde listede nasıl bir eleman görmek istiyorsak onu yazarız biz şu an düz bir text widget oluşturalım ve adımızı yazalım
      //LİSTVİEW.SEPARATED() buda  ListView ın isimlendirilmiş başka bir kurucusudur listView.Builder ile aynıdır tek farkı ListViewSeparator itemBuilder , İtemCoun ile beraber separatorBuilder denilen başka bir yapı daha alır bu yapıda bir callback fonksiyondur bununda parametreleri itemBuilder ile aynıdır
      body: DinamikListViewSeparetedKullanimi(),
    );
  }

  ListView DinamikListViewSeparetedKullanimi() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        var oAnkiOgrenci = tumOgrenciler[index];
        return Card(
          
          color: index % 2 == 0 ? Colors.red.shade200 : Colors.blue.shade200,
          child: ListTile(
            
            //ONTAP listedeki elemanlara basılma durumunu göstermek için
            onTap: () {
              debugPrint("eleman tıklandı $index");

              //DIŞARDAKİ YAPYI HAZIR KULLANMAK İÇİN YAZILMIŞ KOD:EasyLoading yapımız sayesinde 2 ye bölünen değerlerin renginin farklı bölünmeyenlerin renginin farklı yapmaya çalıştık burdaki yapı ile şunu göstermeye şalıştık: main.dart projesindeki configLoading fonksiyonunun her sayfada her farklı renkte bir daha yazmak mı gerekiyor ? hayır . custom ı belirtmek ve genel ayarları belirtmek için configLoading() fonksiyonunu kullanırız lazım olduğu yerde değişiklik yapmak istediğim zaman bu şekilde tekrar tekrar configLoading fonksiyonunu yazmadan bu şekilde ezme işlemi yaparak kullanabilirim eğer vermezsekte configLoading() de yazmış olduğumuz renkler falan kullanılıyor değişiklik yapmak istediğimizde de bu şekilde değiştirebiliyoruz
              if (index % 2 == 0) {
                EasyLoading.instance.backgroundColor = Colors
                    .red; //main.dart klasörüne eklediğimiz configLoading fonksiyonundaki yapı gibi
              } else {
                EasyLoading.instance.backgroundColor = Colors.blue;
              }
              //DIŞARDAKİ YAPYI HAZIR KULLANMAK İÇİN YAZILMIŞ KOD:showToast bizden status değeri istiyor başka üzerine gelip  baktığımız zaman diğer değerleri isimlendirilmiş parametre {} o zaman onları verirken dart dilinde öğrendiğimiz gibi yapmalıyız parametre ismi : değeri
              EasyLoading.showToast(
                "Eleman Tıklandı ",
                dismissOnTap: true,
                duration: Duration(seconds: 3),
                toastPosition: EasyLoadingToastPosition.bottom,
              );
            },

            //onLongPress listedeki elemanlara uzun basılma durumunu göstermek için
            onLongPress: () {
              _alertDialogIslemleri(context,oAnkiOgrenci);
            },
            title: Text(oAnkiOgrenci.ad),
            subtitle: Text(oAnkiOgrenci.soyad),
            leading:
                CircleAvatar(child: Text(oAnkiOgrenci.id.toString())),
          ),
        );
      },
      itemCount: tumOgrenciler.length,
      separatorBuilder: (context, index) {
        //4 indexte bir divider çizmesini istedik
        var yeniIndexDegeri = index + 1;
        if (yeniIndexDegeri % 4 == 0) {
          return Divider(
            thickness: 2,
            color: index % 2 == 0 ? Colors.blue.shade200 : Colors.red.shade200,
          );
        }
        return SizedBox(); //separatorBuilder da her türlü bir widget vermeliyiz if sağlanmadığı durumda boş kutu çizmesini istedik
      },
    );
  }

  ListView DinamikListViewBuilderKullanimi() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: index % 2 == 0 ? Colors.red.shade200 : Colors.blue.shade200,
            child: ListTile(
              onTap: () {
                debugPrint("eleman tıklandı $index");
              },
              
              title: Text(tumOgrenciler[index].ad),
              subtitle: Text(tumOgrenciler[index].soyad),
              leading:
                  CircleAvatar(child: Text(tumOgrenciler[index].id.toString())),
            ),
          );
        },
        itemCount: tumOgrenciler.length);
  }

  ListView KlasikListViewKullanimi() {
    //listviewimizin bizden içinde widgetlar olan bir liste istiyor ama biz gidip içinde ogrencş olan bir liste verdik map yapısı sayesşnde bunu dönüştüreceğiz
    return ListView(
        children: tumOgrenciler
            .map((Ogrenci e) => ListTile(
                  title: Text(e.ad),
                  subtitle: Text(e.soyad),
                  leading: CircleAvatar(child: Text(e.id.toString())),
                ))
            .toList());
  }

  void _alertDialogIslemleri(BuildContext MyContext , Ogrenci secilen) {
    //SHOWDİALOG materialdesign kurallarına bağlı olarak bir diyalog çizer eğer ios uygulaması yapıyorsanda bunun yerine showCupertinoDialog olacak bu da ios a özgü bir yapı sunuyor özellikleri nerdeyse aynı
    //--->showDialog bizden bir CONTEXT değeri bekliyor context deiğimiz şey benim widget tree (ağacım) oluşurken hep bir önceki yapıya dair mesela bu liste oluşurken bize bir build contex veriyordu ya build methodunda bu aslında şu demek : ben bu listeyi neyden sonra veya neyin içine oluşturayım bilgisiydi burda da showDialog bizden bir context bekliyor diyor ki ben bu dialog benceresini widget treesini neresine açayım _alertDialogIslemleri() bu fonksiyonda context değeri tanımlı değil bunu çağırdığım yre gidiyorum onLongPress in içine bakıyorum burda bir context değeri varmı evet ListView ımız oluşurken itemBuilder her seferinde sürekli bize context değeri "VERİYORDU"  ben bu context değerini alıyorum ve _alertDialogIslemleri(context) diyerek buna verebilirim context değerleri sayesinde veri alıp verebiliriz ve daha sonra gelip fonksiyonumuzy tanımlarken paremetre değerini veriyoruz void _alertDialogIslemleri(BuildContext MyContext) seni çağıran insan mutlaka bunu vermeli çünkü içerdeki yapılar buna ihityaç duyuyor ve MyContext yapımızı showDialoga atayabiliriz böylelikle dialog pencerem açılırken nereye açılacağını bilecek
    //--->ve showDialog bizden bir builder değeri bekliyor bunu sürekli görüyoruz listelerde vs. bu ekrana bir widget oluşturma için kullanılan callback yani geri çağrılan fonksiyon bu dialog çalışırken bu builder tetikleniyor builderın üzerine gelip baktığımız zaman bu bir fonksiyonmuş ve buildContext "VERİYORMUŞ" ve geriyede widget dönderiyormuş BuildContext verme sebebi şu olabilir adam bunu kullanıyorsa içerlerde biryerde contexte ihtiyaç duyabilir yukarda _alertDialogIslemleri(context) olduğu gibi ihityaç duyarsa bu değeri kullansın burda widget tree nin yeni hali var yeni hali dediğimiz showDialog açıldıktan sonraki hali var  lazımsa bunu alıp burdan kullanabilir

    showDialog(
      barrierDismissible: false, //boşluğa tıklandığı zaman dialog penceremizin kapanmasını önlüyor
        context: MyContext,
        builder: ( context) {
          return AlertDialog(
            title: Text(secilen.toString()), //çalıştırınca instance of ogrenci hatası aldık bunun sebebi biz secilen değişkenini stringe çevirip yazdırmak istiyoruz ama sistem bun nasıl stringe çevireceğini bilmiyor bunun için Ogrenci sınıfımıza gidip toString sınıfını override edeceğiz
            //alert dialogda title olarak o an seçilmiş olan listedeki öğrencinin bilgisini yazdırmak istiyorum tumOgrenciler e erişebiliyorum ama hangi index te onu alamıyorum o bilgiyi bize DinamikListViewSeparetedKullanimi() methodunda index yapısı her seferinde dönüyordu ona bu fonksiyonumuza parametre olaran gönderebiliriz
            //dialogumuz içindeki şeyler fazla olup ekrana sığmayabilir o yüzden bnu scrool içine alalım
            content: SingleChildScrollView(
              //ListBody column gibi fakat listeler içinde bunu tanımlarsak daha güzel özellikler sağlıyor bize
              child: ListBody(
                children: [
                  Text("can" * 100),
                  Text("mahmut" * 100),
                  Text("yazlak" * 100),
                ],
              ),
            ),
            //ACTİONS: dialoğumuzun içinde butonlarda olabilir ekranı kapatmak için vs bunları actions içine yazıyoruz actions dediğimiz yapı içinde birsürü widget olan bir listedir
            actions: [
              //BUTTONBAR butonlarımızı buttonBar içine koyabilirsin koymasanda aynı gözükecek ama buttonBar ın butonlarla alakalı özellikleri var
              ButtonBar(
                children: [
                  TextButton(onPressed: () {}, child: Text("Tamam")),
                  TextButton(onPressed: () {
                    Navigator.pop(context); //BU yapıyı sonra göreceğiz şu anlama geliyor bu yapı : o an açık olan ekrandan bir geri gelinmesini sağlıyor bu Navigator.pop(context) yapısı bizden context istiyor diyo ki tamam ben geriye gideyim ama nereye gidecem alert diyalog açıldığında pop yapısı ile tekrar listView yapısına dönmek için context kullanıyoruz contexte bu bilgiler var ondan dolayı bizden bunu istiyor. alertdialog context ile bu yapıyı kullandığı zaman alertdialog açıkkken geriye gidildiğinde ben tekrardan listwive dönecem. inspector ile widget tree mize baktığımız zaman AlertDialog ListView ın altına değil yanına gelmiş bu şu işe yarıyor showdialog bizden context bekliyordu ya ve biz buna Mycontext diye bişey yolladık context değerimiz itembuilderımızın bize verdiği contexi almışız buna yollamışız ve context kendinden önceki yapıların bilgisini taşır. Listvievimizi oluştururken scafoldun içinde kendinden önceki yapıları tuttuğu için scaffoldu vs hemen altına alert dialogu ekliyor
                  }, child: Text("Kapat")),
                ],
              )
            ],
          );
        });
  }
}

//bizler genelde verilerimizi internetten veya veritabanından getirtiriz bunun için bir sınıf yaptık ve yukardaki liste mizde de bu listemizi List.generate ile dolduruyoruz

class Ogrenci {
  final int id;
  final String ad;
  final String soyad;

  Ogrenci(this.id, this.ad, this.soyad);

  @override
  String toString() {
    // TODO: implement toString
    return  "İsim: $ad , Soyisim: $soyad , İd: $id" ;
  }
}
