import 'package:flutter/material.dart';

class CheckBoxListTileKullanimi extends StatefulWidget {
  CheckBoxListTileKullanimi({super.key});

  @override
  State<CheckBoxListTileKullanimi> createState() =>
      _CheckBoxListTileKullanimiState();
}

class _CheckBoxListTileKullanimiState extends State<CheckBoxListTileKullanimi> {
  //checkbox ı seçtiğimizde tik falan gelsin onu istiyorsak yine burda stateful widget kullanıp setState methodunu tekrardan çalıştırmamız lazım ve bunun içinde biz değerlerimizi dışarı alıyorduk
  bool checkboxState = true; //checkBoxTile kullanımı için
  String sehir = ""; //radiolistTile kullanımı için
  bool switchState = false; //switchListTile kullanımı için
  double sliderdeger = 10; //slider için
  String secilenRenk = "Kirmizi"; //dropDownbUTOON KULLANIMI
  //DropDownButton da şehirler gibi birden çok elemanım varsa bunları tek tek DropDownMenuItem ile vermek saçma olur bununu yerine listelerde bulunan map methodunu kullanarak aynı görüntüyü daha dinamik bir şekilde elde edebiliriz
  List<String> sehirler = ["Ankara", "Bursa", "İzmir", "Adana"];
  String secilenSehir="Ankara"; //DropDownButton nun dinamik bir şekilde kullanılması için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diğer Form Elemanları"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            //value:checkbox ımın seçili veya seçili olmaması hakkındaki bilgiyi veriyor true yada false checkbox da bir değişiklik olduüu zaman tetikleniyor ve bize bool bir değer gönderiyor
            CheckboxListTile(
              value: checkboxState,
              onChanged: (value) {
                setState(() {
                  checkboxState = value!;
                  debugPrint(value.toString());
                });
              },
              activeColor: Colors.red,
              title: Text("CheckBox title"),
              subtitle: Text("CheckBox subtitle"),
              secondary: Icon(Icons.add),
              selected: true,
            ),

            //geriye nasıl bir değer döndereceğini RadioListTile<...> burda belirtebilirsin mesela ben illerin ismini dönderebileceğim gibi plaka kodlarınıda dönderebilirim buraya yazdığın veri tipine göre onChanged olaylarının da tipi belirlenir
            //groupValue : ile listtile ları bir grup içie alıp onlardan sadece birinin seçilmesini sağlayabilirsin bunun için bir fonks. yazalım
            RadioListTile<String>(
              value: "Malatya",
              groupValue: sehir,
              onChanged: (value) {
                setState(() {
                  debugPrint(value);
                  sehir = value!;
                });
              },
              title: Text("Malatyaa"),
              subtitle: Text("Radio Subtitle"),
              secondary: Icon(Icons.map),
            ),
            RadioListTile<String>(
              value: "Hatay",
              groupValue: sehir,
              onChanged: (value) {
                setState(() {
                  debugPrint(value);
                  sehir = value!;
                });
              },
              title: Text("Hatay"),
              subtitle: Text("Radio Subtitle"),
              secondary: Icon(Icons.map),
            ),
            RadioListTile<String>(
              value: "Aydın",
              groupValue: sehir,
              onChanged: (value) {
                setState(() {
                  debugPrint(value);
                  sehir = value!;
                });
              },
              title: Text("Aydın"),
              subtitle: Text("Radio Subtitle"),
              secondary: Icon(Icons.map),
            ),

            SwitchListTile(
              value: switchState,
              onChanged: (value) {
                setState(() {
                  switchState = value;
                  debugPrint("anlaşma onaylandı: $switchState");
                });
              },
              title: Text("Switch title"),
              subtitle: Text("switch Subtitle"),
              secondary: Icon(Icons.map),
            ),

            //ben slider ı değiştirdikçe onChanged tetikleniyor ve value değeri sliderDeger kısmına atanıyor ben de setState diyince değişiklik ekrana yansıyor
            Slider(
              value: sliderdeger,
              onChanged: (value) {
                setState(() {
                  sliderdeger = value;
                  debugPrint("slider değer: $sliderdeger");
                });
              },
              min: 10,
              max: 20,
              divisions: 20,
              label: sliderdeger.toString(),
            ),

            DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text("kırmızı"),
                      ],
                    ),
                    value: "Kirmizi"),
                DropdownMenuItem<String>(child: Text("mavi"), value: "mavi"),
                DropdownMenuItem<String>(child: Text("sarı"), value: "sari"),
              ],
              onChanged: (String? value) {
                setState(() {
                  secilenRenk = value!;
                });
              },
              hint: Text("seçiniz"),
              value: secilenRenk,
            ),

            DropdownButton<String>(
                items: sehirler.map((e) {
                  return DropdownMenuItem<String>(child: Text(e), value: e);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                 secilenSehir =value!;
                    
                  });
                },
                hint: Text("seçiniz"),
                value: secilenSehir,)
          ],
        ),
      ),
    );
  }
}
