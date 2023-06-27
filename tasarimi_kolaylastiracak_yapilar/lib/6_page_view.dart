import 'package:flutter/material.dart';

class PageViewOrnek extends StatefulWidget {
  const PageViewOrnek(Key k) : super(key: k);

  @override
  State<PageViewOrnek> createState() => _PageViewOrnekState();
}

class _PageViewOrnekState extends State<PageViewOrnek> {

  //pageView içerisinde bulunan sayfalar arası geçişlerde , kontrollerinde falan  kullanacağız yapıdır controller
  //viewportFraction: vereceğim widgetlatrın ekranda görünme boyutu 0 ile 1 arasında değişiyor
  //keepPage bu sayfa bellekten silinecek mi silinmiyecek mi 
  var MyController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  bool yatayEksen = true; //chechBoxın Direction Kontrolü için
  bool pageSnapping = true; //chechBoxın pageSnapping için
  bool reverseSira = false; //chechBoxın reverse için

  @override
  Widget build(BuildContext context) {
    //PageView ın builder ve custom yapısıda buşlunmakta
    return Column(
      children: [
        Expanded(
          child: PageView(
            //aşağıda ki checkBox ımızın durumunu kontrol edip ona göre yatay yada dikey eksenini ayarlıyoruz
            scrollDirection:
                yatayEksen == true ? Axis.horizontal : Axis.vertical,
            reverse: reverseSira,
            controller: MyController,
            pageSnapping:
                pageSnapping, //en ufak harekette diğer sayfaya geçsin mi yoksa sürüklediğim kadarıyla ekranda kalsın mı bunu kontrol eder
            onPageChanged: (value) {
              //value hangi sayfaya geçildiyse onun index ini verir
              debugPrint("page change gelen index: $value");
            },
            //pageView e koyacağımız widgetları koyacağımız yapıdır children kısmı
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.indigo.shade300,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Sayfa 0",
                        style: TextStyle(fontSize: 30),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          MyController.jumpToPage(
                              2); //hangi sayfaya gideceğimizi belirtir
                        },
                        child: const Text("Controller ile 2.sayfaya git"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          MyController.jumpTo(
                              100); //hangi sayfaya gideceğimizi belirtir
                        },
                        child: const Text("X pixel zıpla"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            MyController.jumpToPage(
                                2); //hangi sayfaya gideceğimizi belirtir
                          },
                          child: const Text(""))
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.amber.shade300,
                child: const Center(
                  child: Text(
                    "Sayfa 1",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.teal.shade300,
                child: const Center(
                  child: Text(
                    "Sayfa 2",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 200,
            color: Colors.green.shade300,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Yatay eksende çalış"),
                    Checkbox(
                      value: yatayEksen,
                      onChanged: (value) {
                        setState(() {
                          yatayEksen = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Page Snapping"),
                    Checkbox(
                      value: pageSnapping,
                      onChanged: (value) {
                        setState(() {
                          pageSnapping = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Ters sırada çalış"),
                    Checkbox(
                      value: reverseSira,
                      onChanged: (value) {
                        setState(() {
                          reverseSira = value!;
                        });
                      },
                    )
                  ],
                ),
              )
            ]),
          ),
        )
      ],
    );
  }
}
