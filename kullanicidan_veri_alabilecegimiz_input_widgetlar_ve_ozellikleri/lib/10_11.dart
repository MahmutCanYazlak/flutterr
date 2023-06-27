import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class StepperOrnek extends StatefulWidget {
  const StepperOrnek({super.key});

  
  
  @override
  State<StepperOrnek> createState() => _StepperOrnekState();
}

class _StepperOrnekState extends State<StepperOrnek> {

  //bu aşağıdaki değerlere her zaman erişeceğim için burda tanımlıyorum
  int _aktifStep=0;
  String isim="" , mail="" , sifre="" ;

  //Kaç tane Steps elemanımızın olmadığını bilmeyedebilirdik o yüzden bir liste oluşturup aşağıda oluşturduğum step listesini ona atacağım
   List<Step> tumStepler=[];
  
  //GELİŞMİŞ STEP YAPILARI 2:ola ki bir validation da hata varsa kullanıcımız bu değer göre state deki işaretleri değiştireceğiz ünlem işareti falan çıkarmak için
  bool hata=false;
  
  //GELİŞMİŞ STEP YAPILARI 1:burda normalde globalkey tanımlarken textfiledlarımız  form içine alıp yapardık fakat 3 eleman için almaya gerek yok dedik ve her biri için ayrı oluşturduk aynı zamanda step lerimizin düzgün çalışması için her biri için ayrı ayrı key tanımlanması daha mantıklı
  var key0 = GlobalKey<FormFieldState>();//1.step
  var key1 = GlobalKey<FormFieldState>();//2.step
  var key2 = GlobalKey<FormFieldState>();//3.step 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //tumStepler = _tumStepler();
  }

  @override
  Widget build(BuildContext context) {
    //GELİŞMİŞ STEP YAPILARI 6 :not: normalde bu tumStepler = _tumStepler(); bu satır initState içindeydi fakat state şekilleri güncellenmiyordu bunun sebebi eğer ben bunu initState de yaparsan bu bir kere oluşturuluyor ama bu adımı build içine yazarsam ve her setState dediğimde buil yapısı tekrar çalışacağı için yeni değerlerle bu adımlar tekrar oluşacağı için kelm resmi koyduğum state tikli olacak _stateleriAyarla her seferinde değişiyor ama state kısmı ilk ne atadıysak öyle kalıyor ondan dolayı build dışına yazarsan değişikliği görmezsin
    tumStepler = _tumStepler(); // _tumStepler() bu method çağırılıyor geriye bir liste dönderiyor ve bu listeyi tumStepler içine atıyor ve artık ben tumStepler bunu uyg. herhangi bir yerinde kullanabilirim
    return Scaffold(
      appBar: AppBar(title: Text("Stepper Ornek"), backgroundColor: Colors.red, elevation: 0,),
      body: SingleChildScrollView(
        //currentStep : o an aktif olan step
        //onStepTapped : bir stepi iptal edip diğer stepe tıkladığımızda aktif olan step
        //onStepContinue : butonlara basıldığında tetiklenen method
        //onStepCancel : geri gitmemizi sağlayan geri gel mbutonu
        //controlsBuilder : burdaki varsayılan iconları kendimize göre güncellemk istiyorsak yazmamız gereken property
        child: Stepper(

          //GELİŞMİŞ STEP YAPILARI 8
          controlsBuilder: (context, details) {
            return Row(
           children: <Widget>[
             ElevatedButton(
               
               onPressed: details.onStepContinue,
               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
               child: Text('Continue to Step ${details.stepIndex + 1}'),
             ),
             SizedBox(width: 30,),
             ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
               onPressed: details.onStepCancel,
               child: Text('Back to Step ${details.stepIndex - 1}'),
             ),
           ],
         );
          },
          currentStep: _aktifStep,
          steps: tumStepler, //GELİŞMİŞ STEP YAPILARI 4
          /*
          //GELİŞMİŞ STEP YAPILARI 5
          //diğer steplere tıklanınca geçmeyi engelledim ki hata olursa eğer kullanıcı diğer steplere geçmesin contuine butonu ile diğer steplere geçsin 
          onStepTapped: (tiklananStep) {
            setState(() {
            _aktifStep=tiklananStep;  
            });
          },
          */
          onStepContinue: () {

            /*
            //Contiune yaparken şunu bilmeliyiz acaba Contiune son eleman mı ona bakmalıyız ki bir aonraki elemana gitmemesi gerekiyor
            //_aktifStep 0-1-2 değerlerini alır burda 3 eleman var çünkü. tumStepler.length 3 değerini verecek bundan 1 çıkartma sebebi _aktifStep en fazla 2 olabilir 
            if(_aktifStep < tumStepler.length-1)
            {
              setState(() {
              _aktifStep++;
                
              });
            }
            else{
              //artık son step e gelmiştir herhangi bir şey yapmasın
            }
            */



            //GELİŞMİŞ STEP YAPILARI 7: 
            
            setState(() {
            _ileriButonuKontrolu();
            
              
            });
            
            
          },
           onStepCancel: () {
            //burda da aktifStep ilk elemanda mı onun kontrolünü sağlamalıyız
            if(_aktifStep > 0)
            {
              setState(() {
              _aktifStep--;
                
              });
            }
            else{
              //artık ilk step e gelmiştir herhangi bir şey yapmasın
              setState(() {
                _aktifStep=0;
              });
            }
            
          },
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      //content: göstereceğim yapı?
      Step(
        title: Text("UserName giriniz"),
        subtitle: Text("UserName altBaşlik"),
        //step yapımızın tikli mi çarpı şekilnde mi olacak onu verir
        state: _stateleriAyarla(0),
        isActive: true,
        content: TextFormField(
          
          key: key0,
          decoration: InputDecoration(
            hintText: "UserNameHint",
            labelText: "UserNameLabel",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          //GELİŞMİŞ STEP YAPILARI 3
          validator: ( girilenDeger) {
            if(girilenDeger!.length <6)
            {
              return "En az 6 karekter giriniz";
            }
          },
          onSaved: (newValue) {
            isim = newValue ?? "";
          },
          //kendim yazdım her klavyeyeden harf girildiği zaman validate kontrol edilsinki ilk baştakiş hata mesajı güncellensin 
          onChanged: (value) {
            if(key0.currentState!.validate())
            {
              "";
            }
          },
        ),
      ),
        Step(
        title: Text("mail giriniz"),
        subtitle: Text("mail altBaşlik"),
        //step yapımızın tikli mi çarpı şekilnde mi olacak onu verir
        state: _stateleriAyarla(1),
        isActive: true,
        content: TextFormField(
          
          key: key1,
          decoration: InputDecoration(
            hintText: "mailHint",
            labelText: "mailLabel",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          //GELİŞMİŞ STEP YAPILARI 3
          validator: (String? girilenDeger) {
            if(!EmailValidator.validate(girilenDeger!))
            {
              return "geçerli bir e-mail adresi giriniz";
            }
            setState(() {
              
            });
          },
          onSaved: (newValue) {
            mail=newValue ?? "";
          },
          onChanged: (value) {
            if(key1.currentState!.validate())
            {
              "";
            }
          },
        ),
      ),
       Step(
        title: Text("Şifre giriniz"),
        subtitle: Text("Şifre altBaşlık"),
        //step yapımızın tikli mi çarpı şekilnde mi olacak onu verir
        state: _stateleriAyarla(2),
        isActive: true,
        content: TextFormField(
          
          key: key2,
          decoration: InputDecoration(
            hintText: "ŞifreHint",
            labelText: "ŞifreLabel",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          //GELİŞMİŞ STEP YAPILARI 3
          validator: (String?  girilenDeger) {
            if(girilenDeger!.length <6)
            { 
              return "Şifre en az 6 karekter olmalı";
              
            }
          },
          onSaved: (newValue) {
            sifre=newValue ?? "";
          },
          onChanged: (value) {
            if(key2.currentState!.validate())
            {
              "";
            }
          },
        ),
      ),

    ];
    return stepler;
  }
  //GELİŞMİŞ STEP YAPILARI 4
  StepState _stateleriAyarla(int oAnkiStep) {
    //yukarda hangisinde hata çıktıysa sadece onun state şeklini değiştircem
    if(_aktifStep==oAnkiStep)
    {
      if(hata)
      {
        //hata varsa
        return StepState.error;
      }
      else
      {
        //hata yoksa ve _aktifState oankiState ise
        return StepState.editing;
      }
    }
    else
    {
      //aktifState oAnkiState eşit değilse
      return StepState.complete;
    }
  }
  
  void _ileriButonuKontrolu() {
    switch(_aktifStep)
    {
      case 0:
        if(key0.currentState!.validate())
        {
          key0.currentState!.save();
          hata = false; //hatayı false atatık çünkü başka bir adımda bu true atanmış olabilir şu durumda herhangi bir hata yoktur
          _aktifStep++;//hata yı false ataığımız için bir arttırdıkkki kullanıcı ilerleyebilsin
          
        }
        else
        hata=true; //validet olmadıysa hata çıkmıştır bir sonraki step e geçmesin 
      break;
    

    case 1:
        if(key1.currentState!.validate())
        {
          key1.currentState!.save();
          hata = false;
          _aktifStep++;
        }
        else
        hata=true; 
      break;
    

    case 2:
        if(key2.currentState!.validate())
        {
          key2.currentState!.save();
          hata = false;
          
          //eğer kullanıcı buraya kadar doğru girdiyse everilerini burda kullanıcının değerlerini gösterebileceğimiz bir method tanımlayalım
          formTamamlandi();
        }
        else
        hata=true; 
      break;
    }
  }
  
  void formTamamlandi() {
    debugPrint("girilen degerler:\n \t İsim=>$isim\n \t Mail=>$mail\n \t Şifre=>$sifre");
  }
}
