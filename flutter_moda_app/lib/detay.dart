import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class Detay extends StatefulWidget {
  var imgPath;
  var dtyImgPath;
  Detay({this.imgPath, this.dtyImgPath});

  @override
  State<Detay> createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  Color UrunDetayRengi = Colors.grey;
  late PaletteGenerator _generator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarRenginiBul();
  }

  void appBarRenginiBul() async {
    //bu bir future ama biz yukarda bu future yapısını future olmayan bir yapıya atamaya çalışıyorduk o yüzden bu yapıyı ayrı bir method içine aldık
    //aşağıdaki yapı bir future uzun sürecek şu an bir değer yok PaletteGenerator çalışacak ve daha sonra değer oluşacak  o yüzden buraya async ve await yapısını ekledik böyle yapınca da PaletteGenerator ne kadar sürerse artık iş sonunda _generator a o değer atanacaktır
    //secilenUrun e erişemiyorum sebebi yukarısı widget kısmı burası State kısmı stateden widget içindeki değişkenlere erişmk için widget.DeğişkenAdı yazarsın
    _generator =
        await PaletteGenerator.fromImageProvider(AssetImage(widget.imgPath));
    //iamege beklenen yere image.asset vb.yazıyon provider beklenen yere ise AssetImage yazıyon burda olduğu gibi
    if (_generator.lightVibrantColor == null) {
      UrunDetayRengi = _generator.dominantColor!.color;
    } else
      UrunDetayRengi = _generator.lightVibrantColor!.color;
    //build methodunu tekrardan çalıştıracak ve   backgroundColor: appBarRengi, bu kısmın değiştiğini görecek

    print(UrunDetayRengi);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!HERO
      //burda da diğer sayfadaki tag in aynısını verdik ki bağlantılı olsun diğer sayfada containera bağlı resmi gönderdik o resim burada imgPath değişkenin içinde var ve böylelilke diğer sayfada inkwell in ontab üzerinden gönderdiğimiz resim dinamik olarak burda güncellenecek
      body: Stack(
        children: [
          Hero(
            tag: widget.imgPath,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  //imgPath doğrudan erişemedik onun için widget.imgPath diyoruz bunun anlamı bunun bağlı olduğu widgeta git ordaki değişkeni oku
                  image: DecorationImage(
                      image: AssetImage(widget.imgPath), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 4,
              child: Container(
                height: 240,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: UrunDetayRengi,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 110,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                border:
                                    Border.all(color: Colors.grey, width: 3),
                                image: DecorationImage(
                                    image: AssetImage(widget.dtyImgPath),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LAMINATED",
                              style: GoogleFonts.actor(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Louis vuitton",
                              style: GoogleFonts.actor(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width - 185,
                              child: Text(
                                "One button V-neck sling long-sleeved waist female stitching dress",
                                style: GoogleFonts.actor(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Divider(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 22, top: 3, bottom: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$7999",
                            style: GoogleFonts.actor(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade400,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 28,
                            child: FloatingActionButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward_ios),
                              backgroundColor: Colors.brown.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height / 2,
              left: 20,
              child: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "LAMINATED",
                          style: GoogleFonts.actor(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios , color: Colors.white,)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
