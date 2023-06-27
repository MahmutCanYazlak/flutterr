import 'package:flutter/material.dart';

class KisiselFontKullanimi extends StatelessWidget {
  const KisiselFontKullanimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: const [
            Center(
              child: Text(
                'Kisisel Font Kullanimi Regular b',
                style: TextStyle(
                    fontFamily: "Genel",
                    fontSize: 20,
                    fontWeight: FontWeight
                        .w700 //pubspec.yaml Genen isimli fonst da iki tane asset kullandım biri normal regular diğeri ise bold ben fontumu kullanacağım yerde famil isimine Genel yazdığımda bold kısmını m ınormal regular asset ini mi kullanacağım bunu belirtmek için bir işaret koymalıyım işte bunu pubspec.yaml dosyasında weight 700 diyorum ve fontu kullanacağım yerde font weight te 700 dersem bold olan gelir
                    ),
              ),
            ),
            Center(
              child: Text('Kisisel Font Kullanimi Regular',
                  style: TextStyle(
                    fontFamily: "Genel",
                    fontSize: 20,
                  )),
            ),
            Center(
              child: Text(
                'Kisisel Font Kullanimi default',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Text(
                'Kisisel Font Kullanimi el yazisi',
                style: TextStyle(
                    fontFamily: "ElYazisi",
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
  }
}