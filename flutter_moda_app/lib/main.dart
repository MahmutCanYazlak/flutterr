import 'package:flutter/material.dart';
import 'package:flutter_moda_app/detay.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const ModaApp());

class ModaApp extends StatelessWidget {
  const ModaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa>
    with SingleTickerProviderStateMixin {
  bool isRed = true;
  late TabController control;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            indicatorColor: Colors.grey,
            controller: control,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.more,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.navigation,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ]),
      ),
      appBar: AppBar(
        title: Text(
          "MODA' ms",
          style: GoogleFonts.aboreto(
            textStyle: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                return;
              },
              icon: const Icon(
                Icons.photo_camera,
                color: Colors.grey,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(
          children: [
            //üst tarafataki profil listesi
            Container(
              color: Colors.transparent,
              height: 140,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    listeElemani("assets/images/model1.jpeg",
                        "assets/images/chanellogo.jpg"),
                    const SizedBox(
                      width: 30,
                    ),
                    listeElemani("assets/images/model2.jpeg",
                        "assets/images/chloelogo.png"),
                    const SizedBox(
                      width: 30,
                    ),
                    listeElemani("assets/images/model3.jpeg",
                        "assets/images/louisvuitton.jpg"),
                    const SizedBox(
                      width: 30,
                    ),
                    listeElemani("assets/images/model1.jpeg",
                        "assets/images/chanellogo.jpg"),
                    const SizedBox(
                      width: 30,
                    ),
                    listeElemani("assets/images/model2.jpeg",
                        "assets/images/chloelogo.png"),
                    const SizedBox(
                      width: 30,
                    ),
                    listeElemani("assets/images/model3.jpeg",
                        "assets/images/chanellogo.jpg"),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            //card yapısı yerine Material kullanacağız
            Padding(
              padding: const EdgeInsets.all(16.0),
              //MATERİAL: card gibi fakat daha fazla özelliğe sahip
              child: Material(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: Container(
                  height: 501,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/images/model1.jpeg"),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 172,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daisy",
                                  style: GoogleFonts.aboreto(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "34 mins ago",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle: const TextStyle(fontSize: 12),
                                      color: Colors.grey.shade500),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.grey))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "This official website features a ribbed knit zipper jacket"
                        " that is modern and stylish it looks very temparement"
                        "and is recommended to friends",
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            color: Colors.grey.shade700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          InkWell(
                            //detay sayfasına veri göndermek için fakat gönderdiğin veri hangi resime basarsan o resmin img gitçek
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detay(
                                    imgPath: "assets/images/modelgrid1.jpeg" , dtyImgPath: "assets/images/dress7.jpg"),
                              ));
                            },
                            //!HERO
                            //Hero kullanımı: bu bize bir keçiş efekti sağlar bunu kullanırken tag propertsini mutlaka yazmalıyız ve bu tag, geçiş yapacağım sayfalarda aynı değerde olmalı 1 , 2 gibi değerler verebileceğin gibi burda yapmış olduğumuz gibi resim falanda verebilirsin yeterki aynı olsun bu tag in aynısını detay sayfasında da yapıyoruz önemli olan şey bu sayfada ki tag ile diğer sayfadaki tag aynı olsun
                            child: Hero(
                              tag: "assets/images/modelgrid1.jpeg",
                              child: Container(
                                height: 200,
                                width:
                                    (MediaQuery.of(context).size.width - 50) /
                                        2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/modelgrid1.jpeg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Detay(
                                        imgPath:
                                            "assets/images/modelgrid5.jpeg", dtyImgPath: "assets/images/dress3.jpg"),
                                  ));
                                },
                                child: Hero(
                                  tag: "assets/images/modelgrid5.jpeg",
                                  child: Container(
                                    height: 95,
                                    width: (MediaQuery.of(context).size.width -
                                            100) /
                                        2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/modelgrid5.jpeg",
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Detay(
                                        imgPath:
                                            "assets/images/modelgrid3.jpeg", dtyImgPath: "assets/images/dress4.jpg"),
                                  ));
                                },
                                child: Hero(
                                  tag: "assets/images/modelgrid3.jpeg",
                                  child: Container(
                                    height: 95,
                                    width: (MediaQuery.of(context).size.width -
                                            100) /
                                        2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/modelgrid3.jpeg"),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.brown.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "#Louis vuitton",
                                style: GoogleFonts.montserrat(
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    color: Colors.brown.shade900),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 25,
                            width: 63,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.brown.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "#Chloe",
                                style: GoogleFonts.montserrat(
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    color: Colors.brown.shade900),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(color: Colors.grey.shade700),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.reply,
                            color: Colors.brown.withOpacity(0.3),
                            size: 25,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "1.7k",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown.withOpacity(0.4))),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.message,
                            color: Colors.brown.withOpacity(0.3),
                            size: 25,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "4431",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown.withOpacity(0.4))),
                          ),
                          const SizedBox(
                            width: 92,
                          ),
                          
                          //İCONUN RENGİNİ DEĞİŞTİRMEK İÇİN
                          // Diyelim ki iconun rengi başlangıçta kırmızı olsun yukarda tanımladık

                          IconButton(
                            onPressed: () {
                              if (isRed) {
                                // Eğer icon rengi kırmızı ise beyaz yap
                                setState(() {
                                  isRed = false;
                                });
                              } else {
                                // Icon rengi beyaz ise kırmızı yap
                                setState(() {
                                  isRed = true;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.favorite_sharp,
                              color: isRed
                                  ? Colors.red
                                  : Colors.brown.withOpacity(
                                      0.3), // Koşula göre renk belirle
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            "7.5k",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.brown.withOpacity(0.4))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listeElemani(String imagePath, String logoPath) {
    return Column(
      children: [
        //!STACK YAPISI:
        //stack yapısı sayesinde elamanlar üst üste binebiliyor bir kab mantığı gibi çalışıyor
        Stack(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover)),
            ),
            //logomuzun stack yapımızın 1.elemanı olan resmin sağ alt tarafına gelmesini istiyorum bunun için Positioned widgetını kullanabiliriz margin ve paddinglerlede ayaralanabilrdi ama bu yöntem daha kolay
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(logoPath), fit: BoxFit.cover)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.brown.shade300,
          ),
          child: const Center(
              child: Text(
            "Fallow",
            style: TextStyle(
                fontFamily: "Moda", fontSize: 14, color: Colors.white),
          )),
        )
      ],
    );
  }
}
