class Urun {
  final String _urunAdi;
  final String _urunKod;
  final String _urunOzellik;
  final String _kucukResim;
  final String _buyukResim;

  //yukardaki değerlerimiz private olduğu için diğer dosyalardan erişemiyorum erişebilmem için vscode bir dart getter and setter eklentisi kurdum ve private değişknelerimi seçip sağ tıklayıp getter and setter diyerek koda şunu diyorum tamam ben bunları değiştirmicem ama en azından okumama izin ver diyorum otomatik set yapılarıda kuruluyor ama biz değişkenlerimizi final yaptığımız için hata alıyruz set yapılarına zaten ihtiyacımız olmadığı içinde siliyoruz
  get urunAdi => this._urunAdi;

  get urunKod => this._urunKod;

  get urunOzellik => this._urunOzellik;

  get kucukResim => this._kucukResim;

  get buyukResim => this._buyukResim;

  Urun(this._urunAdi, this._urunKod, this._urunOzellik, this._kucukResim,
      this._buyukResim);

  @override
  String toString() {
    // TODO: implement toString

    //instance of hatası aldık nesnemizi yazdırmaya çalışınca toString dınıfını override ediyoz ederkende hepsini etmeyip kasmayalım sistemi ikisini yapalım bu ikisini yaparsa diğerlerinide yapar yani biz şunu dedik ne zamaki kullanııc urunleri ekrana yazdırmak isityor string olarak göstermek istiyor burdaki formatı kullan bu formatı kullanarak ekrana yazdır
    return "$_urunAdi - $_buyukResim";
  }
}
