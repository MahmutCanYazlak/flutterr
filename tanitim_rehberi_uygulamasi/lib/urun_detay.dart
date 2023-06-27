import 'package:flutter/material.dart';
import 'package:tanitim_rehberi_uygulamasi/data/model/urun.dart';
import 'package:palette_generator/palette_generator.dart';//palette generator kullanımı için biz bu palette dosyasını burada kullanacağız

//burada palette generator un çalışması için statefulWidget lazım çünkü programımız baladığı zaman rengi gri faha sonra future fonksiyonumumz gidip resimden baskın rengi bulduktan sonra renk değişiyor bir değişiklik varsa stateful widget kullanalıydık ki set state ile yapımızı güncelleyelim
class UrunDetay extends StatefulWidget {
  //bunun çalışması için mutlaka secilen ürüne ihtiyacımız var
  final Urun secilenUrun;
  const UrunDetay(this.secilenUrun, {super.key});

  @override
  State<UrunDetay> createState() => _UrunDetayState();
}

class _UrunDetayState extends State<UrunDetay> {

  //appbar ın rengini güncelleyeceğimiz için gidip onu bir değişken içine aldık 
  Color appBarRengi = Colors.grey;
  //urun_listesi.dart isimli dosyamızda listemizi doldururken kurucu fonk. içinde doldurduk bunun sebebi kurucu fonk. bir kere çalışır fakat build yapısı flutter da uygulama açıkken birden çok kez çalıştırılıyor. burda da ordaki mantık gibi stateful widgetlarda da  initSatate denilen bir alanımız var bu statefulwidget ekrana gelmeden önce initState widget ı bir kere çalışıyor ondan sonra istersen set state diyerek 70 kere çalıştırın önemi olmuyor   initState bir kere çalışıyor ve biz bunu şu durumlarda kullanıyoruz değişkenlerimizin ilk atamlarını yaaparken meslea burda diyor ki (PaletteGenerator _generator) mutlaka bunu initialize edin diyor etmiyosanızda başına late ekleyin yani ben burayı doğrudan initialize edemem late diyorumbuda şu demek ben seni kullanmadan önce mutlaka initialize edecem hata verme demek ve bunu initState içinde initialize edelim
  late PaletteGenerator _generator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarRenginiBul(); //aşağıdaki önemli not için yorum satırı yaptık ÇALIŞMADI tekrar eski yönteme döndük
    //ÖNEMLİ NOT: bu aşağıda ki kod şu işe yarıyor: Bizim buildimiz bitmeden verdiğimiz fonksiyonu çalıştırmıyor yani diyoruz ki önce mesela e-faturaya tıkladım önce o ekrana gelsin ondan sonra uzun sürecek işlem burda appBarRenginiBul çalışsın demiş oluyoruz böylece üst üste widget binme hatalarını almamış oluyoruz.yani şu işe yarıyor önce bi buildi yapsın sistem ve eğer ki appBarRenginiBul() fonk. çalışıyorsa 1.build yapımız çalışmış bitmiş ondan sonra appBarRenginiBul() işlemlerini yapmışız ve orda setState() diyerek build yapısını tekrardan oluşturmuş oluyoruz 
    //WidgetsBinding.instance.addPersistentFrameCallback((_) => appBarRenginiBul());
   
   
  }

  void appBarRenginiBul() async
  {
   
      //bu bir future ama biz yukarda bu future yapısını future olmayan bir yapıya atamaya çalışıyorduk o yüzden bu yapıyı ayrı bir method içine aldık 
      //aşağıdaki yapı bir future uzun sürecek şu an bir değer yok PaletteGenerator çalışacak ve daha sonra değer oluşacak  o yüzden buraya async ve await yapısını ekledik böyle yapınca da PaletteGenerator ne kadar sürerse artık iş sonunda _generator a o değer atanacaktır
      //secilenUrun e erişemiyorum sebebi yukarısı widget kısmı burası State kısmı stateden widget içindeki değişkenlere erişmk için widget.DeğişkenAdı yazarsın
     _generator = await PaletteGenerator.fromImageProvider(AssetImage("images/${widget.secilenUrun.buyukResim}")); 
     //iamege beklenen yere image.asset vb.yazıyon provider beklenen yere ise AssetImage yazıyon burda olduğu gibi
     if(_generator.darkMutedColor == null)
     {
      appBarRengi = _generator.lightVibrantColor!.color;
     }
     else
     appBarRengi = _generator.darkMutedColor!.color;
    //build methodunu tekrardan çalıştıracak ve   backgroundColor: appBarRengi, bu kısmın değiştiğini görecek 
     
     print(appBarRengi);
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
           
            backgroundColor: appBarRengi,
            flexibleSpace: FlexibleSpaceBar(
               title: Text(widget.secilenUrun.urunAdi),
              background: Image.asset("images/" + widget.secilenUrun.buyukResim),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Text(widget.secilenUrun.urunOzellik , style: Theme.of(context).textTheme.subtitle1),
              ),
            ),
          )
        ],
      ),
    );
    
  }
  
}
