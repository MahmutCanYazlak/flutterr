import 'package:flutter/material.dart';

class DropDownButtonKullanimi extends StatefulWidget {
  const DropDownButtonKullanimi({super.key});
  @override
  State<DropDownButtonKullanimi> createState() =>
      _DropDownButtonKullanimiState();
}

class _DropDownButtonKullanimiState extends State<DropDownButtonKullanimi> {
  String? _secilenSehir = null;
  String? _secilenSehir2 = null;
  List<String> _tumSehirler = ["Sivas", "Ankara", "İstanbul", "Adana"];
  @override
  Widget build(BuildContext context) {
    return Center(
      // DROP DOWN BUTTON : bizden bir liste bekliyor bu listeyi parametre olarak alıyor items diye bir liste items a baktığımızda bunun içinde  DropDownMenuItem lar olan bir liste olmalıymış ve türü dynamicmiş burda iki tane kavram var   biri bu öğelerin ekranda nasıl görüneceği yani biz bursayı bursa olarak yazmak yerine bir resim olarak gösterebiliriz burda sorun yok ama kullanıcı ona tıkladığında bize bir değer gelmesi gerekir işte bu değerin türünü DropdownButton<...> buraya yazıyoruz mesela string yazalım adam bursayı seçtiyse bana bursa değeri gelsin generic type olarak belirttik
      //DropdownButton içinde belirlediğin generic type value değerinin tipi aslında

      child: Column(
        children: [
          DropdownButton<String>(
              items: [
                DropdownMenuItem(child: Text("Malatya şehri"),value:"Malatya"), //child: bu listenin nasıl görüneceğini yazıyoruz value: bu seçilirse value olarak ne alacam
                DropdownMenuItem(child: Text("Aydın şehri"), value: "Aydın"),
                DropdownMenuItem(child: Text("Hatay şehri"), value: "Hatay"),
                DropdownMenuItem(child: Text("Bursa şehri"), value: "Bursa")
              ],

              //başlangıç value sı vermemiz gerek buraya verdiğin değer listede var olan value değerlerinden biri olmalı yoksa hata alırsın bu value değeri hangisinin seçildiğini belirliyor
              value: _secilenSehir,

              //hint bir widgettır ve bu butonumuzda secilenSehir değişkenimize null değer atarsan yani hiçbir değer seçilmemişken ne gösterilsin onu söyler bunu görmek için _secilenSehir değişkenine null değer atıyoruz
              hint: Text("Şehir seçiniz"),
              icon: Icon(Icons.add),
              iconSize: 30,
              underline: Container(
                  height: 4,
                  color: Colors
                      .blue), //altını çizmek için container belirledik ve boyutunuda küçük verdik

              style: TextStyle(color: Colors.red.shade400),

              //bunları yapmamıza rağmen butona hala tıklayamıyoruz butonun çalışabilir olması için onChanged fonksiyonu veriliyor bize bu fonksiyon lamda isimsiz bir fonksiyon veriyor bize ve değer olarakta string bir değer dönderiyormuş  onChanged in farkı boş fonksiyonumuz parametre de String bir değer alıyor bu değer kullanıcının yeni seçmiş olduğu değerin valuesini üstüne alıyor
              onChanged: (String? yeni) {
                _secilenSehir = yeni;
                debugPrint("çalıştı $_secilenSehir");
                //debugconsalede değerin değiştiğini görüyoruz fakat emülatörde değişmiyor burda flutterı uyarmamız gerekiyor durum değişti sen ekranı bir daha build et build methodunu çalıştır bu değişikliği görki value değeri ekrana yansısın
                setState(() {});
              }),


          //diyelimki 81  tane ilimiz var her ili bu şekilde tek tek girmek yerine daha kolay bir yol var yukarda bir liste tanımlarız ve gelip burda items: yerine o listemizi veririz fakat bir sorunla karşılaşırız items bizden içinde DropdownMenuItem ların olduğu bir liste oluşturuyordu ama bizim listemiz içinde Stringleri tutuyor. bir yapıyı başka bir yapıya dönüştürmek için map() fonksiyonunu kullanırız (koleksiyon olan map değil fonksiyon olan map) bu fonksiyon _tumSehirler adlı listenin elemanlarını tek tek geziyor listemizde 4 elaman var bu yapı 4 kere çalışacak ve sonucunda da elemanları gezip bize yep yeni bir yapı oluşturabilir items bizden DropdownMenuItem ların olduğu bir liste istiyordu o zaman ben string elemanlarımı tek tek gezip her birini DropdownMenuItem a dönüştürebilirim ama kod hala kızıyor bunun sebebi map yapısı bize bir iterable verir bu bizden bir liste bekliyor bu map in bittiği yerde çıkan sonucu toList() e çevireceğiz 
          DropdownButton<String>(
              items: _tumSehirler
                  .map((String oAnkiSehir) => DropdownMenuItem(
                        child: Text(oAnkiSehir),
                        value: oAnkiSehir,
                      ))
                  .toList(),
                value: _secilenSehir2,
                hint: Text("şehir seçiniz"),
               onChanged: (String? yeni) {
                _secilenSehir2 = yeni;
                debugPrint("çalıştı $_secilenSehir2");
                //debugconsalede değerin değiştiğini görüyoruz fakat emülatörde değişmiyor burda flutterı uyarmamız gerekiyor durum değişti sen ekranı bir daha build et build methodunu çalıştır bu değişikliği görki value değeri ekrana yansısın
                setState(() {});
              }
              )
        ],
      ),
    );
  }
}
