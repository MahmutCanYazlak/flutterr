//CUSTOM SCROLL VİEW ile özel kaydırma işlemleri yapıyor ve birden çok liste türlerini bir arada kullanmana olanak sağlar

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomScrollVeSliversKullanimi extends StatelessWidget {
  const CustomScrollVeSliversKullanimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //Slivers bir widget listesi alır fakat alacağı widget lar SLİVER ile başlamalı dökümantasyondan okuduk
        slivers: <Widget>[





          //SLİVERAPPBAR
          SliverAppBar(
              backgroundColor: Colors.red.shade500,
              pinned:
                  true, //listeyi aşağı doğru kaydırırken pinned true ise yukarda normal appbar gibi gözükmeye devam eder false ise kaybolur
              expandedHeight:
                  207, //SliverAppBar ımız açıkken 207 pixellik yer kaplicak ekranda bir scroll olayı varsa eğer aşağı doğru çektiysen bu değer küçülür
              snap:
                  false, //doğrudan listeyi aşağı indirdiğimizde appbarda ki başlık kısmının açılmasıdır bu true ise floating bu da true olmalı yoksa hata
              floating:
                  false, // listenin altına indik sonra yukarıya doğru kaydırdığımızda biz bunu true yaparsak ilk benim 200 pixellik appbar ım gözükecek daha sonra listenin elamanlarını kaydırabileceğiz ama eğer false ise önce elemanlar kayar sayfanın en üst kısmına gelince appbar gözükür
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Custom ScrollView AppBar", style: TextStyle(color: Colors.black),),
                centerTitle: true,
                background: Image.asset(
                  "assets/image/araba.jpg",
                  fit: BoxFit.cover,
                ),
              )),






          //DİNAMİK OLMAYAN SLİVERLİST
          //slivers bir widget listesi alır fakat sen bu iki widget arasında padding bırakmak istediğinde doğrudan padding yazamıyorsun çünkü sliver içinde tüm widgetların Sliver.. ile başlaması gerek bizde SliverPadding i kullanıyoruz ve bunun içinde sliver propertysinin içinede paddingi uygulayacağın SliverListesini yazıyon
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverList(
              //SliverChildListDelegate bizden içinde widget olaca şekilde Childrenlar istiyor fakat children: yazınca hata alıyoruz fonk. üzerine gelip baktığımız zaman children isimlendirilmemiş parametre o yüzden doğrudan listemizi oluşturduk bu listemizin içinde widgetlar yazacağız biz bu yazdığımız widgetlarıda bir GET fonksiyonu haline getririp doğrudan fonksiyonunumuzu çağırdık
              //delegate üyeleri nasıl oluşturayım demek
              delegate: SliverChildListDelegate(SabitListeElemanlari()),
            ),
          ),



          //DİNAMİK OLAN SLİVERLİST
          SliverPadding(
            padding: EdgeInsets.all(5),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(_DinamikListeElemanlari,
                    childCount: 6)),
          ),




          //DİNAMİK OLAN SLİVERGRİD VE COUNTLU
          //delegate: elemanları oluşturuyor
          //gridDelegate: GridView ın çalışma mantığını söyler
          SliverGrid(
            delegate: SliverChildBuilderDelegate((_DinamikListeElemanlari),
                childCount: 10),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),



          //DİNAMİK OLMAYAN SLİVERGRİD VE EXTENDLİ
          SliverGrid(
            delegate: SliverChildListDelegate(SabitListeElemanlari()),
            gridDelegate:
                SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
          ),



          //SLİVERGRİD İN İSİMLENDİRİLMİŞ KURUCULU HALİ 
          //SliverList in isimlendirilmiş kuruculu hali yok fakar SliverGrid in var
          //burada dinamik olan _DinamikListeElemanlari yi kullanamıyoruz sebebi bu  SliverGrid.count bizden widget listesi bekliyor zaten GridView leri görürkende dinamik yapılar i,çin GridView.builder yapısında dinamik yapıyı kullanıyorduk ama Sliver içinde SliverGrid.builder yok zaten gerekte yok doğrudan SliverGrid içinde delegate yapısı sayesinde dinamik yapımızı kullanabiliyoruz
          SliverGrid.count(
            crossAxisCount: 4,
            children: SabitListeElemanlari(),
          ),



          //DİNAMİK OLMAYAN SLİVERFİXEDLİST
          //SliverFixedExtentList SliverList lere göre daha dinamik bir yapıda
          //itemExtent verdiğin değer containerın kaç pixel olacağını söylüyor senin gidip containerı oluştururken vermiş olduğun değerin anlamı kalmıyor burda listeyide aşağı doğru kaydırdığımızdan aşağı doğru X pixel büyüyor
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverFixedExtentList(
                delegate: SliverChildListDelegate(SabitListeElemanlari()),
                itemExtent: 300),
          ),



          //DİNAMİK OLAN SLİVERFİXEDLİST
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(_DinamikListeElemanlari,
                    childCount: 6),
                itemExtent: 50),
          ),

         
        ],
      ),
    );
  }

  //normalde builder diye propert nin içine BuildContext Context , int index derdik fakat burda builder isimlendirilmiş parametreler dışında ondan dolayı builder : DinamikListeElemanlari(context, index) demiyon doğrudan kullanabiliyon
  Widget? _DinamikListeElemanlari(
    context,
    index,
  ) {
    return Container(
      height: 130,
      color: _ratgeleRenkUret(),
      alignment: Alignment.center,
      child: Text("Dinamik Liste Elemanı id: ${index + 1}",
          style: TextStyle(fontSize: 18, color: Colors.black38)),
    );
  }
 
  //chat gpt den renklerin daha parlak gözükmesi için aldığım kod:
  Color _ratgeleRenkUret() {
  return Color.fromARGB(
    255,
    Random().nextInt(200) + 55,
    Random().nextInt(200) + 55,
    Random().nextInt(200) + 55,
  );
}

  List<Widget> SabitListeElemanlari() {
    return [
      Container(
        height: 130,
        color: Colors.yellow.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 1",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.blue.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 2",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.green.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 3",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.orange.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 4",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.purple.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 5",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 6",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
      Container(
        height: 130,
        color: Colors.cyan.shade300,
        alignment: Alignment.center,
        child: Text("Sabit Liste Elemanı id: 7",
            style: TextStyle(fontSize: 18, color: Colors.black38)),
      ),
    ];
  }
}
