import 'dart:async';

abstract class SayacEvent{}
//eventlerimizi sınıf olarak yapıyoruz biz burdan arttir arttiri koyduğumuzda bu stream dinlendiği için gelen event e bakıyor bu event arttır mı  azalt mı eğer arttırmaysa sadece yine bu sınıfta gizli olarak belirlenmiş  _sayac arttiriyorum eğer gelen sayac event i azaltmaysa ve SayacEvent bunların üst sınıfı olduğu için ben uygulamamda böyle bir method yazabiliyorum eğer gelen arttirmaysa arttır azalatmaysa azalt diyiruz  arttırdık azalttık bunların hepsi bloc un içinde yer alıyor halbuki ben arayüzümde streami dinliyorum yeni değer ne ona göre arayüzümü güncellicem bu ikisiarasında da bir bağlantı kuruyoruz streamde sink ten gelen eventi dinle eğer arttirmaysa sayacı 1 arttir ve bu yeni state değerini bu sefer statemizin sinkine ekliyoruz böylece eventin _streami ile state in _sinki arasında bir bağlantı kuruyoruz işte burdaki yapıyı _mapEventToState methodu içinde yaptık. gelen arttirdan sonra değerimi arttirdim ve state _sinkine eklediğim için buda bir stream yapsıı olduğu için ve _sink e bir şey eklendiğinde stream otomatik çalışacağı için biz event in sinki tarafından yeni değeri eklediğimizde stete nin streaminden 0 olan sayaç 1 olarak çıkar bizde bu değeri arayüzümüzde bir stream builder kullanarak gösterebilirz azalat kısmıda aynı mantıkla çalışır //! işte bu kadar kodu yazmak yerine flutter_bloc isimli kütüphaneyi kullanacağız
class ArttirmaEvent extends SayacEvent{}

class AzaltmaEvent extends SayacEvent{}

class SayacBlock
{
  int _sayac = 0;

  //todo: state için streamController
  final _sayacStateStreamController = StreamController<int>();
  Stream<int> get sayac => _sayacStateStreamController.stream;
  StreamSink get _sayacStateSink => _sayacStateStreamController.sink;

  //todo: event için streamController
  final _sayacEventStreamController = StreamController<SayacEvent>();
  Stream<SayacEvent> get _sayacEventStream => _sayacEventStreamController.stream;
  StreamSink<SayacEvent> get sayacEventSink => _sayacEventStreamController.sink;



  SayacBlock() {
    //kurucuda event in streamini dinliyorum buraya yeni bir değer gelidiğinde _mapEventToState tetikleniyor ve bu methodda bana gelen eventin türüne bakıyor.
    _sayacEventStream.listen(_mapEventToState);
  }
  
  void _mapEventToState(SayacEvent event) {
    if (event is ArttirmaEvent)
    {
      _sayac++;
    }
    else {
      _sayac--;
    }

    _sayacStateSink.add(_sayac);
  }

  void dispose()
  {
    _sayacEventStreamController.close();
    _sayacStateStreamController.close();
  }
}