import 'package:flutter/material.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/10_11.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/3_4.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/5.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/7_8.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/9.dart';
import 'package:kullanicidan_veri_alabilecegimiz_input_widgetlar_ve_ozellikleri/stepper_kullanimi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int maxLineCount = 1 ;
  //VERİ ATAYABİLMEK İÇİN 1: ana yapımızı stateful widgeta çevirdik ve controller tanımlıyoruz TextEditingController bu sınıftan nesne ürettik
  late TextEditingController _emailController; //hata verdi: initalize edecem merak etme demek için late ifadesini kullandık


  //FOCUSNODE KULLANIMI 1:
  late FocusNode _focusNode;



  //İNİTSTATE ile stateful widgetlarda initialize işlemlerinin yapılmasının beklendiği kısımdır.(kurucu fonksiyonda da yapılabilir.) bu işlemleri build içinde yapma build birden çok kez çalıştırılır her çalıştığında tekrar tekrar olmasını istemeyiz ama initState bu widget oluştuğunda 1 kere çalıştırılır ondan sonrada bir daha bir daha çalıştırılmıyor. yani özetli İNTİSTATE:statefulWidgetımız ekrana yazılmadan önce çalıştırılan ve 1 kere çalıştırılır ve genelde de atamaları burda yaparız. ve burdaki controller aslında bizim textFiled in durumunu tutan yapı olduğu için bir kere oluşturalım ve tekrar tekrar kullanalım o yüzden bunu initState içinde yaparız

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //buranın altına tanımlanır
    _emailController = TextEditingController(
        text: "canmahmut@gamil.com"); //text içinde vereceğemiz ifadeyi yazarız


    //FOCUSNODE KULLANIMI 2: 
    _focusNode = FocusNode();


    //FOCUSNODE KULLANIMI 4: örnek:focus üzerinde olduğu zaman text fildimizin 3 kat büyümesini focus üzerinden kalktığında eski haline dönmesini istiyoruz
    //ADDLİSTENER((){}) : listener bir şeydeki değişikliği sürekli olarak dinleyen bir yapıdır aslında
    _focusNode.addListener(() {
      setState(() {
      if(_focusNode.hasFocus){
        //hasFocus:içine girildiyse
        maxLineCount=3;
      }
      else{
        maxLineCount=1;
      }
        
      });
     });

  }


  //DİSPOSE: initState de ilk değeri atanır ,build tekrar tekrar çalışbalir ,setState ekranı günceller ,DİSPOSE ise bu widget artık mesela burdan başka bir sayfaya gittiğimizde bu widget artık yok edilecekse dispose ile de yok etmek istediğimiz ifadeleri buraya yazarız . yani bu şu işe yarar initStete içerinden yapmış olduğumuz tanım bu widget silinse bile mesela pushreplacement yaptığımızda bu sayfanın yerine yep yeni bir sayfa açtık herşey widgetlar falan bellektek silinirken  bu controller yapıları , listinirlar silinmiyor onları kendimiz elle yok etmemiz gerekir yoksa bellek sızıntısı sorunu ile karşılaşırız 
  //dispose işlemleri stateful widgetta yok
  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();//buranın üstüne tanımlanır
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.orange)),
      title: 'Form İşlemleri',
      debugShowCheckedModeBanner: false,
      home: StepperOrnek(),
    );
  }

  Scaffold TextFieldislemleri() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            //TEXTFİELD: kullanıcının klavyeden veri almasını sağlayan yapılardırtek bir veri alacaksak bu kullanılır birden çok veri alınacaksa textFormField kullanılır
            //NOT: TextField yapısında baktığımızda stateles içerisinde olmasına rağmen ekranda yazı yazabiliyoruz veriler anlık değişebiliyor ama statelesta böyle bir yapı olamaz demiştik. fakat textField yapısı stafulWidget tır ondan dolayı yapabiliyoruz kendi içerisinde değişiklik yapmaya izin veriyor eğer ki genel olarak ekranda anlık değişiklik yapılacaksa stateles widget olmazdı statelesWidget içinde stateful yapıları kullanabiliyoruz
            child: TextField(
              //FOCUSNODE KULLANIMI 3: focus yapısını textfield a verdik
              focusNode: _focusNode,
              //klavye sınırlandırmak için
              keyboardType: TextInputType.number,
              //klvyedeki butonun şeklini değiştirir
              textInputAction: TextInputAction.next,
              //birden fazla textfield varsa hangisinin seçili olacağını karar verir
              autofocus: true,
              //max kaç satır gözükeceğini belirler
              maxLines: maxLineCount,
              //max karekter sayısını belirler
              maxLength: 20,
              
              //her bir ifade eklediğimide bir şey değiştiği zaman aşağıdaki fonskiyon tetiklenir
              onChanged: (value) {
                if (value.length > 3) {
                  print(value);
                }
              },
              //alanı onaylayınca tetiklenir
              onSubmitted: (value) {
                print("Submit:" + value);
              },
              cursorColor: Colors.pink,
              
              decoration: InputDecoration(
                  //başlık gibi
                  labelText: "telefon numarası",
                  //ne girilmesi gerektiğine dair info veriyor
                  hintText: "5xx xxx xx xx",
                  //icon: Icon(Icons.phone),
                  //label ın içine ikon eklemek için aşağıdaki iki seçeneği kullanabilirsin
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: Icon(Icons.workspace_premium_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  //içini doldurmak için
                  filled: true,
                  fillColor: Colors.orange.shade200),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              //VERİ ATAYABİLMEK İÇİN 2: bu controlleri textFiled e vermemiz gerekir
              controller: _emailController,
              //klavye sınırlandırmak için
              keyboardType: TextInputType.number,
              //klvyedeki butonun şeklini değiştirir
              textInputAction: TextInputAction.next,
              maxLength: 20,
              onChanged: (value) {
                if (value.length > 3) {
                 //VERİ ATAYABİLMEK İÇİN 3: yazdığımız her bir değirin text kısmında anlık olarak oraya yazdırmak için: ilk başta _emailController.text kullandık fakat her değişiklikte imleç başa dönüyor onu değiştirmek işçin _emailController.value içinde ki offset yapısını değiştirdik değerimiz kadar ilerden başlat imlecimizi dedk
                 _emailController.value=TextEditingValue(text: value,selection: TextSelection.collapsed(offset: value.length));
                 setState(() {
                   
                 });
                }
              },
              //alanı onaylayınca tetiklenir
              onSubmitted: (value) {
                print("Submit:" + value);
              },
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                  labelText: "mail adresi",
                  hintText: "birisi@example.com",
                  prefixIcon: Icon(Icons.mail),
                  suffixIcon: Icon(Icons.add_link),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  filled: true,
                  fillColor: Colors.green.shade200),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_emailController.text),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _emailController.text = "deneme@gmail.com";
          //setState demeden doğrudan textFiel içindeki değerimiz değişti bu TextFild e özel ama bizim alttaki text kısmımız güncellenmdi oranında güncellenmesi için setState yapısnı kullanıyoruz değişkenimizin içindeki yapı değişti ve onu kullanana bir yapı var setState diyerek build yapsını tekrar çalıştır diyoruz
          setState(() {
            
          });
        
        },
        child: Icon(Icons.account_tree),
      ),
    );
  }
}
