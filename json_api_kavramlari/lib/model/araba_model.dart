//!2.DERS 1:
//MODEL SINIFLARI: ile debugPrint(arabalarListesi[1]["model"][1]["fiyat"].toString()); bu görünümden kurtulmamızı sağlıyor bu yapı okunaklı değil helede json yapısı kalabalık ise bunları demek bu bir liste ve Araba verileri tutuyor List<Araba> arabalarListesi = jsonObject; bunu demek içinde model sınıfını oluşturmam gerekiyor. arabalar.json daki verileri barındıran dart sınıflarına model sınıfı diyebiliriz quickType isimli site bu işleri yapıyor. bu sitede dönüştürmek istediğimiz jsonın neresini kopyaladığımız çok öndemli eğer ki arabalar.json da [ ...] burdan başlarsak kopyaladığımız şey içinde arabalar olan bir listedir ama ben burda sadece arabayla ilgili verileri istiyorum dediğimde sadece {..} kısmını almamız gerekiyor quickType da 1:Use method names fromMap() & toMap() 2:Make all properties final 3:Make all properties required 4:Null Safety seçeneklerini seçip dilide Dart seçip projemizede model dosyasını oluşturup içine de birden fazla model olacağı için araba_model.dart isimli dosya oluşturup burayta yapıştırıyoruz
//bu kodları yaptıktan sonra elimizde Araba isimine sınıfımız var
 

// To parse this JSON data, do
//
//     final araba = arabaFromMap(jsonString);


import 'dart:convert';


//!Map den aldığın string değerleri araba nesnesine dönüştür demek 
Araba arabaFromMap(String str) => Araba.fromMap(json.decode(str));

//!araba nesnesini map e dönüştür demek
String arabaToMap(Araba data) => json.encode(data.toMap());

class Araba {
    final String arabaAdi;
    final String ulke;
    final int kurulusYil;
    final List<Model> model;

    Araba({
        required this.arabaAdi,
        required this.ulke,
        required this.kurulusYil,
        required this.model,
    });

    factory Araba.fromMap(Map<String, dynamic> json) => Araba(
        arabaAdi: json["araba_adi"],
        ulke: json["ulke"],
        kurulusYil: json["kurulus_yil"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "araba_adi": arabaAdi,
        "ulke": ulke,
        "kurulus_yil": kurulusYil,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
    };
}

class Model {
    final String modelAdi;
    final int fiyat;
    final bool benzinli;

    Model({
        required this.modelAdi,
        required this.fiyat,
        required this.benzinli,
    });

    factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelAdi: json["model adi"],
        fiyat: json["fiyat"],
        benzinli: json["benzinli"],
    );

    Map<String, dynamic> toMap() => {
        "model adi": modelAdi,
        "fiyat": fiyat,
        "benzinli": benzinli,
    };
}
