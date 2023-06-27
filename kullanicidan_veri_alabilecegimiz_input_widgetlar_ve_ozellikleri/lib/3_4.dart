import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; //PUP DEV DEN E-MAİL_VALİDATOR PAKETİNİ KULLANMAK İÇİN 1

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  //DEĞERLERİ DEĞİŞKENLERE ATAMAK 2:
  //textFiledlerimde ki değerleri değişkelere atamak için değişken tanımladım
  String _email = "", _password = "", _userName = "";
  //DEĞERLERİ DEĞİŞKENLERE ATAMAK İÇİN KEY TANIMLAMA 2: global key tanımlaması aşağıda ki gibi global key birden fazla state tutabileceği için <FormState> diyoruz şu an oluşturduğum formun stateni erişsin nasıl ki biz statefulWidgetlar da bir state yapımız var bu form da aslında bir statefulWidgettır ve bununda bir state alanı vardır yani ordaki verileri tutması adına böyle bir key tanımlıyoruz sınıfın da en başına tanımladım ki içerdeki fonk. veya bu yapıyı başka bir yerde aldığımızda da erişebilelim diye.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("text form field kullamnımı")),
      body: SingleChildScrollView(
        //formun valided olması , değerlerin alınması resetlenmesi gibi durumlar için textFormField lerimizi form widgetı ile sarmalıyoruz
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          //kullanıcıdan veri alacağınız birden falza alan varsa ve save edeyim validator edeyim gibi şeyler varsa mutlaka textFormField i form içinde yazmalıyız  ve forma farklı yerlerden erişmek için bir key ataması yapıyoruz  
          child: Form(
            //DEĞERLERİ DEĞİŞKENLERE ATAMAK İÇİN KEY TANIMLAMA 3: key i formumza veriyoruz
            key: _formKey,

            autovalidateMode:
                AutovalidateMode.onUserInteraction, //doğrudan validator çalışması için always dersin ama kullanıcı o alana tıklayınca validator çalışması için onUserInteraction kullanırsın
            child: Column(
              children: [
                //textField deki çoğu özellik burda da var
                TextFormField(
                  initialValue: "Mahmut Can", //başlangıç değeri
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.purple),
                      labelText: "UserName",
                      hintText: "UserName",
                      border: OutlineInputBorder()),
                  //DEĞERLERİ DEĞİŞKENLERE ATAMAK 3: OnSaved çalıştığında parametrede ki değeri değişkenime aktaracam
                  onSaved: (newValue) {
                    _userName = newValue!;
                  },
                  validator: (String? value) {
                    if (value!.length < 4) {
                      return "Username en az 4 karekter olmalı";
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(

                  keyboardType: TextInputType.emailAddress,
                  initialValue: "MahmutCan@gmail.com", //başlangıç değeri
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.purple),
                      labelText: "e-mail",
                      hintText: "e-mail",
                      border: OutlineInputBorder()),
                  //DEĞERLERİ DEĞİŞKENLERE ATAMAK 3: OnSaved çalıştığında parametrede ki değeri değişkenime aktaracam
                  onSaved: (newValue) {
                    _email = newValue!;
                  },
                  //PUP DEV DEN E-MAİL_VALİDATOR PAKETİNİ KULLANMAK İÇİN 2:
                  validator: (String? value) {
                    if(value!.isEmpty)
                    {
                      return "e-mail boş olamaz";
                    }
                    //true false verir bize true verirse ! ile tersini aldık true ise doğru işlem false nı alarak tersi işleminiyapacağız
                    else if (!EmailValidator.validate(value)) {
                      return "geçerli bir mail giriniz";
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: "1231312", //başlangıç değeri
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.purple),
                      labelText: "password",
                      hintText: "password",
                      border: OutlineInputBorder()),
                  //DEĞERLERİ DEĞİŞKENLERE ATAMAK 3: OnSaved çalıştığında parametrede ki değeri değişkenime aktaracam
                  onSaved: (newValue) {
                    _password = newValue!;
                  },
                  //PUP DEV DEN E-MAİL_VALİDATOR PAKETİNİ KULLANMAK İÇİN 2:
                  validator: (String? value) {
                    if (value!.length < 6) {
                      return "password en az 6 karekter olmalı";
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      //DEĞERLERİ DEĞİŞKENLERE ATAMAK 1:
                      //butona bastığım zaman değerlerimi değişkene atayayım ki ben artık  bunu veritabanına mı yazcam bir yerde mi kullancam bu gibi olaylar için bu textFormField lerimde ki  değerleri bir değişkene atayım. eğer ki validator durumlarına uyarsa yukarda tanımladığım değişkenlere değerleri atanmasını istiyorum işte bundan dolayı her textFormFiled da onSaved gibi bir coolback fonk. var
                      //DEĞERLERİ DEĞİŞKENLERE ATAMAK İÇİN KEY TANIMLAMA 1::
                      //bu butona bastığım zaman OnSaved fonks. çalışmasını istiyorum ama önce gidip bu formu tetiklemem lazım git bu değerleri validet et eğer onaylıysa kullanıcı değerleri düzgün girdiyse bunları kaydet demem lazım ben bu forma nasıl erişem? - buton içinden taa yukarda tanımlanmış form erişmem için widgetları yapsıında gördüğümüz key ler vardı burda bir key ataması yapmamız lazım global bir key tanımlaması yapıyoruz ve widget treem de herhangi bir yerden erişebiliyorum yukarı gidip tanımlayalım
                      //DEĞERLERİ DEĞİŞKENLERE ATAMAK İÇİN KEY TANIMLAMA 4: burda validate yapmasını söyleyeceğiz hani normalde textFormField alanlarından çıkıldığında direkt validation oluyordu ama aslında burda bu validation olayını butonun  tıklanmasına veriyoruz
                      bool _validate = _formKey.currentState!
                          .validate(); //_formKey.currentState formun o anki statene eriş demek ve bu yapı null ifade dönderiyor
                      if (_validate) {
                        _formKey.currentState!
                            .save(); // _validate true ise ve save dediğimiz zaman yukarda tanımlamış oldupupmuz onSaved() fonksiyonları tetiklenecektir ve buradaki değerler değişkenlere atanacaktır.
                        String result =
                            " userName: $_userName\n e-mail: $_email \n password: $_password";
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red.shade300,
                            content: Text(result, style: TextStyle(fontSize: 20),),
                          ),
                        );
                          _formKey.currentState!.reset(); //eğer verilerimiz doğruysa textField deki değerleri sıfırmalamak için yine _formKey.currentState ile formun o anki statene eriş ve alanları resetle diyoruz
                      }
                    },
                    child: Text("0nayla"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
