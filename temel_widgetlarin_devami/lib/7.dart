import 'package:flutter/material.dart';

class TemelButonlar extends StatefulWidget {
  const TemelButonlar({super.key});

  @override
  State<TemelButonlar> createState() => _TemelButonlarState();
}

//butonlara gidip bu şekilde tek tek style atayabiliriz ama diyelim 20 butonumuz var hepiyle tek tek uğraşmak istemiyorsan main fonksiyonunda theme ayarlarsın ayrı bir buton tassarımı yapacağın zamanda gidip o butonda style yaparsın biz main kısmında göstermek için theme ayarladık
class _TemelButonlarState extends State<TemelButonlar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TextButton basit bir text yapımız varsa ve bununnda buton olmasını istiyorsak textButton kullanabiliriz
        TextButton(
            onPressed: () {},
            onLongPress: () {
              debugPrint("butona uzun basıldı");
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text("text buton")),

        TextButton.icon(
            onPressed: () {},
            style: ButtonStyle(
              //BUTONUN TÜM DURUMLAR İÇİN
              //backgroundColor: MaterialStateProperty.all(Colors.red),
              foregroundColor: MaterialStateProperty.all(Colors.yellow),
              overlayColor: MaterialStatePropertyAll(Colors.black),
              //BUTONUN FARKLI DURUMLARI İÇİN
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //BUTONA BASILMA DURUMU
                if (states.contains(MaterialState.pressed)) {
                  return Colors.amber;
                }
                //BUTONUN ÜSTÜNDEN GEÇME DURUMU bunun çalışması için projemizi chormdedan açıyoruz
                if (states.contains(MaterialState.hovered)) {
                  return Colors.blue;
                }
                //DİĞER DURUMLAR İÇİN null yani varsayılan değeri demek
                else {
                  return null;
                }
              }),
            ),

            //color verirken doğrudan veremiyoruz çünkü butonların durumları vardır mousenin üstüne gelme durumu basılma durumu ondan dolayı state vermemiz gerek onuda MaterialStateProperty diyerek veriyoruz all diyerek tüm durumlarda anlamına getiriyoruz

            icon: Icon(Icons.add),
            label: Text("icon buton")),

        ElevatedButton(
            onPressed: () {},
            //state göre farklı farklı yapılar kullanmicaksam eğer MaterialStateProperty bunun yerine çok daha kolay bir yapımız var bu yapı aşağıdaki gibi bu yapıda state kontrolü yapılmıyor burada da isimlendirmeler farklı primary gibi
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.yellow,
              shape: OvalBorder(),
              side: BorderSide(color: Colors.black, width: 3.0),
            ), // primary butonun rengi onprimary yazının rengideğiir ve temada değişir yukardaki MaterialStateProperty yapıda tek tek belirtmen gerek
            child: Text("Elevated button")),

        ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("icon Elevated button")),

        OutlinedButton(onPressed: () {}, child: Text("Outlined button")),

        OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            //butonumuzun etrafını oval yapmak ve etrafına kırmızı bir şerit döndük
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(), side: BorderSide(color: Colors.red)),
            label: Text("icon outlined button")),

        OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            //butonumuzun etrafını oval yapmak için başka bir yöntem
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2, color: Colors.red),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
            ),
            label: Text("icon outlined button")),
      ],
    );
  }
}
