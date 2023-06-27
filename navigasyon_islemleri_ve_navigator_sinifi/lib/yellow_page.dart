import 'package:flutter/material.dart';

class YellowPage extends StatelessWidget {
  const YellowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yellow Page"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Yellow Page",
              style: TextStyle(fontSize: 24),
            ),

            //POP UNTİL KULLANIMI 2: eğerki iç içe bir çok sayfaya gittik stack yapımıza bir çok eleman eklendi ve biz ana sayfaya dönemk istersek popUntil te isFirst kullanırız stack yapısının ilk elemanına git gibisinden pop deseydik bir adım geri gelirdik
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("ana sayfaya dön")),

            // POP UNTİL KULLANIMI 3: eğer ki ne en başa nede bir geriye gitmek istemiyorsam ara sayfalardan birine gitmek istiyorsam ve eğer ki benimnavigator işlemlerim isimlendirilmiş ise o zaman aşağıdaki yöntem kullanılır bu şekilde ister en başa ister bir geriye istersende stack yapımızdaki ara elemanlardan birine gidebilirsin
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context,
                      (route) => route.settings.name == '/ogrenciListesi');
                },
                child: Text("ogrenci listesi sayfasına dön")),

            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, (route) => route.settings.name == '/');
                },
                child: Text("ana sayfaya dön 2.yöntem")),
            //PUSH NAMED REMOVE UNTİL KULLANIMI 1 : bu ise stack yapımızda yer alan X sayfasını mesela burda Yellow page i ana sayfadan sonraya eklemeyi sağlıyor. kullanımı : neyi push etmek istiyoruz '/yellowPage' route olarakra mesela ana sayfadan sonraya ekle diyoruz yada X sayfasını Y sayfasından sonraya ekle diyoruz route da route.isFirst yerine route.settings.name == '/' de diyebilirsin 
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context , '/yellowPage', (route) => route.isFirst);
                },
                child: Text("sarı sayfayı ana sayfadan sonraya koy")),
          ],
        ),
      ),
    );
  }
}
