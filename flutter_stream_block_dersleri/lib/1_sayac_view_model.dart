//burda benim state yapım int sayı bu blac yapısının temeli için bir sınıf tamımlayalım genelde bu sınıfa ViewModel denir bu ViewModel statemiz ile arayüzümüz arasında bir köprü
import 'dart:async';

class SayacViewModel {
  int _sayac = 50;
  final StreamController<int> _controller = StreamController.broadcast();
  Stream<int> get  myStream => _controller.stream;
  Sink get _mySink => _controller.sink;

  //_sinki private yapmam sebebimiz bu _sinke git sayaç değerini 1 arttır yaz 1 azalt yaz _sink e yeni değerler geldikçe bu streami dinleyen yerler güncellenecek ama ben bunları ui kodlarında sink üzerindeden değilde kendi yaptığım methodlar üzerinden yapayım ki ui da bu kodaları yazan direkt olaran anlasın
  //biz bu aşağıdaki kodları yaptığımızda bizim streamimizi dinleyen yerlere bu yeni değer otomatik olarak gidecek
  SayacViewModel()
  {
    _mySink.add(_sayac);//o anki sayacımın değerini geçebilirim burda _sayac değeri 0 olduğu için beni oluşturup oluşturmaz dinleyen streamlere 0 sayısını yollayacam ondan sonra işlemler yapılacak
  }
  void azalt()
  {
    _mySink.add(--_sayac);
  }

    void arttir()
  {
    _mySink.add(++_sayac);
    
  }


  //todo: appBar içinde bu değeri gösterirken hata alıyorduk onu çözmek için tanımlnmış bir fonskyion init()
  int init()
  {
    return _sayac;
  }
}