import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial(baslangicDegeri: 20)); //burda bir başlangıcDegeri vermem gerek

  //bu sınıf içinde state denilen bir şey veriliyor bu state dediğimiz şey bize <CounterState> veri türünü temsil ediyor CounterState i onun içinde de sayac değeri var 
  //veri bekliyorum veri istiyorum CounterState verecek ama bu stateyi methodlarla değiştirebilirim bu fonksiyonların isimlerinide kafamıza göre verebiliriz arayüzümden bu methodlara erişeceğim buda var olan statti güncellemicek yepyeni bir state verecek yayınlamak için emit denilen bir anahtar kelime geliyor karşımıza. içinde de State var bu state dediğimiz ise CounterState nin ilk değeri ilk değerde initial ile başladığımız için 20 

  void arttir(){
    emit(MyCounterState(sayacDegeri: state.sayac+1)); //state değeri vereceğiz evet ama dönüş tipi CounterState olacak fakat CounterState soyut sınıf onun somut sınıflarını kullanacağız state diyerekte o anki counterState elde ettim sınıfın içinde de sayac diye bir değer vardı onu elde ettim ve onu arttırıp yepyeni bir MyCounterState nesnesi oluşturup yolluyorum ve emit ile de bunu yaıyorum git bunu 
  }
  void azalt(){
    emit(MyCounterState(sayacDegeri: state.sayac-1));
  }

  //artık cubit imiz hazır bu oluşturduğumuz cubit i ağacımıza entegre edelimki lazım olan herhangi bir yerde buna erişelim 
}
