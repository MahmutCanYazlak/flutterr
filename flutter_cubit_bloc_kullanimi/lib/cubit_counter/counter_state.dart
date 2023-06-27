part of 'counter_cubit.dart';

//!STATE: arayüzümüzde gördüğümüz değer veri değiştiğinde ekrana tekrardan çizilmesi gerekn veridir
//bizim counter örneeğimizde statemiz bir iint sayı aslında sınıflar üzerinden ilerlemeye gerek yok ama biz zor olan sınıf üzerinden gidelim 
@immutable
abstract class CounterState {
  //burdaki int stetimizi CounterState isimli sınıf ile sarmalıyoruz
  final int sayac;
  const CounterState({required this.sayac});//bir nesne üretildiğinde bu sayaç değerini bana mutlaka versinler 

}


//CounterInitial ise bizim sayac değeri ekrana ilk hangi değerle başlicak bu sınıfı kullanmaya pek gerekte yok
class CounterInitial extends CounterState {
  const CounterInitial({required int baslangicDegeri}):super(sayac: baslangicDegeri); //CounterInitial, CounterState ın bir alt sınıfı old. için ve CounterState de bir tane kurucu method old. için super diyip onun kurucusunu mutlu etmem gerek {} içine almam isimlendirilmiş parametre olması için required deme sebebim ise null olabileceğinden dolayı
}


//counter_cubit.dart dosyasında başlangıç değerini verdikten sonra mesela 20 ile başladı butona bastığımda bu sayıyı arttırascam azalatcam işte bu stateleri tutmak içinde aşağıdaki sınıfı kendimiz oluşturduk ve bu sınıfıda Counter statede türetecem ki hepsi bir çatı altında toplansın ve CounterState üzerinden üretince onun kurucu methodunu mutlu etmem gerekecek
class MyCounterState extends CounterState{
  const MyCounterState({required int sayacDegeri}):super(sayac: sayacDegeri);

}

//todo: bu state sınıfı int sayımızı sarmalayan bir sınıf başkada birşey değil burda çok daha fazla şey oloabilirdi 