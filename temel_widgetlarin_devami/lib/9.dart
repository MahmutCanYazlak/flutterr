import 'package:flutter/material.dart';

class PopupMenuKullanimi extends StatefulWidget {
  const PopupMenuKullanimi({super.key});

  @override
  State<PopupMenuKullanimi> createState() => _PopupMenuKullanimiState();
}

class _PopupMenuKullanimiState extends State<PopupMenuKullanimi> {
  String? _secilenSehir = null;
  List<String> renkler = ["mor", "lacivert", "yeşil", "sarı"];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
        
        
          //BU YÖNTEM DİNAMİK BİR YAPI DEĞİL
          /* return <PopupMenuEntry<String>>//PopupMenuButton bizden PopupMenuEntry olduğu bir liste istiyormuş  PopupMenuEntry soyut bir sınıf
        [
          PopupMenuItem(child: Text("Malatya") , value: "Malatya"), //PopupMenuItem ise PopupMenuEntry nin somut sınıfı
          PopupMenuItem(child: Text("Sivas") , value: "Sivas"),
          PopupMenuItem(child: Text("Elazığ") , value: "Elazığ"),
        ]; 
        */

          //BU YÖNTEM DİNAMİK BİR YAPI
          return renkler
              .map((String oAnkiRenk) =>
                  PopupMenuItem(child: Text(oAnkiRenk), value: oAnkiRenk))
              .toList(); //liste olarak bizden PopupMenuItem istiyor PopupMenuEntry in somut sınıfı
        },

        icon: Icon(Icons.ad_units_rounded),
        //icon yada child verebilirsin ikisini verirsen hata alırsın
        //child:  Text("$_secilenSehir"),

        onSelected: (String sehir) {
          _secilenSehir = sehir;
          debugPrint("seçildi $_secilenSehir");
          setState(() {});
        },
      ),
    );
  }
}
