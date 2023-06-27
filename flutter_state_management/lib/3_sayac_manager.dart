//busines lojict imin yani işlemlerimin olduğu sınıf
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_state_management/model/3_sayac_model.dart';


//bu manager sınıfının state i nu manager ın bana sürekli olarak döndereceği yapı aslında bir sayac modeldir çünkü bu sayacModel burada olacak ki ben bunun içindeki sayac değerine erişebileyim 
class SayacManager extends StateNotifier<SayacModel> {
  //sayacManeger ın kurucusunu boş geçtik sayacManger ı ilk çalıştırdığımızda herhangi bir parametre geçmeyelim.
  //super dediği StateNotifier bu sınıfa bir parametre yolla demek. yani burdan bir nesne üretildiğinde üst sınıfıma sayac degerimi 0 a atayarak bir başlangıç yapıyorum
  SayacManager(): super(SayacModel(0));

  //busines logic işlemlerini tanımlarız yani benim işimi yapacak methodlarımı oluştururuz
  void arttir()
  {
    //state diye hazır bir yapı var bu state yapısı bu sınıfın oluşturulduğu yani StateNotifier<SayacModel> -----içindeki----> SayacModel yapısı. yani bizim state dediğimiz yapı bir sayacModel dir sayacModel de sayacımın değeri var 
    //state++ diyemem çünkü artık bu bir int değer değil 
    var oankisayacDegeri = state.sayacDegeri;
    state  = SayacModel(oankisayacDegeri +1 );
    
  }

  void azalt()
  {
    var oankisayacDegeri = state.sayacDegeri;
    state = SayacModel(oankisayacDegeri -1);
  }
}




//! buraya gidp bu oluşturduğumuz sınıfın StateNotifierProvider oluştururuz fakat biz tüm providerları all_providers.dart dosyasında tanımladığımız için bu sınıfın da provider ını all_providers.dart kısnmına yazdık





