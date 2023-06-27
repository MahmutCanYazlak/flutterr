import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_bloc_kullanimi/cubit_counter/counter_cubit.dart';

//!CUBİT: cubit te sadece state ler önemlidir eventler için ayrı bir yapı yok direkt olarak fonsiyonlar üzerinden stetimizi değiştirebiliriz
//cubit oluşturmak için önce flutter_block paketini indir daha sonra bloc isimli extensions u inidr ve lib e sağ tıkla new cubit seçeneği çıkar ona tıkla

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //materialApp ctrl . diyince burdan bloc provider ı seçmemiz lazım bir cubit i bloc u ağaca entegre etmem lazım
    return BlocProvider<CounterCubit>(
      create: (context) =>
          CounterCubit(), //state i değiştirecek methodlar bunun içinde
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    debugPrint("build tetiklenid");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            /* Text(
              context.watch<CounterCubit>().state.sayac.toString(), //ağaca enjekte ettiğimiz counter cubit i bul bunun içinde state var state ise CounterState ti be onun içinde ki sayac değeri ile ilgileniyorum diyorum
              style: Theme.of(context).textTheme.headlineMedium,
            ), */

            //!burda bir text değeri güncelleniyor fakat ekranın hepsi build oluyor bunu engellemek için riverpod da yaptığımız şeyi burda da yapıyoruz nerenin güncellenmesini istiyorsaj onu BLOCKBUİLDER içine alıyoruz bunun iiçne yazılan değerler ise <cubit imin stateni tutuan sınıfın adı , bu cubitten nasıl bir state çıkacak> 
            BlocBuilder<CounterCubit,CounterState>(
              builder: (context, CounterState state) {
                return Text(state.sayac.toString(), //but-rayada artık context.watch demiceğiz de state diyeceğiz bu state CounterState . diyince içindeki verileri erişiyoruz
                style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().arttir();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context
                  .read<CounterCubit>()
                  .azalt(); //state değişimi ile burda ilgilenmediğimiz için read yaptık benim burdaki amacım read diyerek ağacımdaki CounterCubit i bulayım ki onun üzerinden arttır ve azalt methodlarını çağırayım
            },
            tooltip: 'Increment',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
