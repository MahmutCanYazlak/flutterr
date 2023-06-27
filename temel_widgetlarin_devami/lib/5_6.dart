//projelerimize assetleri atamak için gidip ana projemize new folser diyerek assets isminde bir dosya oluşturduk onunda içine gidip tekrardan new folder diyerek images dosyasını ve fonts dosyalarını oluşturuyoruz daha sonra mesela projemize resim mi ekleyeceğiz gidip resmi oluşturduğumuz image dosyasının içine ekliyoruz daha sonra gidip projemizde yer alan pubspec.yaml dosyasını açıp orda assets olan kısmın yorum satırını kaldırıyoruz boşluklara dikkat edecek şekilde eklemiş olduğumuz resmin yolunu veriyoruz ör: - assets/images/  böyle yaparsan tüm resimleri asssets olarak alır eğer belli bir resmi alacaksan uzantısıyla beraber adınıda yazacaksın ve projemizi en baştan çalıştıracaksın

import 'package:flutter/material.dart';

class ImageOrnekleri extends StatelessWidget {
  const ImageOrnekleri({super.key});
  @override
  Widget build(BuildContext context) {
    String _img1 =
        "https://scontent.fasr1-1.fna.fbcdn.net/v/t1.6435-9/47379799_2138153186324017_8097486896109715456_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=wFTjfOCfryAAX8p8siv&_nc_ht=scontent.fasr1-1.fna&oh=00_AfDVnWpSN3-PMf-l9NgIzlCQpgByyoiN2NMnUsRzEL3d5w&oe=64537D5D";
    String _img2 =
        "https://media.istockphoto.com/id/1255835530/tr/foto%C4%9Fraf/modern-%C3%B6zel-suburban-ev-d%C4%B1%C5%9F.jpg?s=2048x2048&w=is&k=20&c=dfbBFzdY0ghpwcgqDsr6J5BuZnBhTbhXnj7dpOlxAKo=";
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, //FadeInImage deki resim satır boyunca yayılsın diye
          children: [
            IntrinsicHeight(
              //bu işlem satırımızda yer alan elemanları, satırımız içerisinde yer alan en BÜYÜK (herhangi bir containera git ve var olan boyuttan daha büyük height değeri ver diğer resimlerde ona bağlı olacak şekilde büyür) boyuttaki elamamnın boyuna getiriyor fakat bunun çalışması için Row içerisinde gidip y eksenine(cross) göre ayarlamayı stretch yapmalıyız (stretc in anlamı normalde y eksenine yayıl der burda IntrinsicHeight bu işlem ise en büyük resmin boyutuna göre ayarlıyor bu iki işlemin sonunda IntrinsicHeight ile en büyük resmin boyutu alınıyor strecth ile de resimler o boyuta yayılıyor) ve böylelikle satırımızda yer alan elamanların birinin büyük birinin küçük olmasını engellemiş oluruz
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.red,
                        child: Image.asset(
                          "assets/images/saray.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.yellow,
                        child: Image.network(
                          _img2,
                          fit: BoxFit.fill,
                        )),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.blue,
                        //CircleAvatar widget ını padding witgetı içerisine aldık
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: Text("M",
                                style:
                                    Theme.of(context).textTheme.displayLarge),
                            radius: 90,

                            //yukardaki Image.network() ler falan widget beklenen yere yazılır ama CircleAvatar içindeki backgroundImage bizden ImageProvider türünde bişey istiyor o yüzden buraya Image.network() yazamayız bizden ImageProvider beklenen yere direkt NetworkImage yazabiliriz eğer benden widget bekliyorsa Image.network(_img1) , Image.asset(_img1) eğer benden ImageProvider bekliyorsa NetworkImage veya AssetImage sınıflarını yazmamız gerekiyor
                            backgroundImage: NetworkImage(
                                _img1), //içine verdiğimiz childin arka planı
                            backgroundColor: Colors.lime,
                            foregroundColor: Colors.blue,
                            //backgroundImage:NetworkImage(_img1) ,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            //FadeInImage yeni bir widget bu widget internetten bir resim getridiğimizde o yüklenene kadar başka bir resmin gösterilmesini sağlıyor placeholder resim gelene kadar hangi resim gösterilsin. image hangi resim gelsin resmimizde büyük onu bir container içerisine alıyoruz ki ekranımı kaplamasın
            Container(
                height: 200,
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: _img1)),
            //Placeholder yeni bir widget bu widget uygulamamızda bir resim göstereceğiz fakat o resmi o an kullanmak istemiyorsak bunu kullanıyoruz yer tutucu yani belli bir alana çarpı kor bunun belli bir default Height değeri var 400 bu uygulamamızda sığmama hatası aldık bundan dolayı ya bir container oluştururuz yükseklik değeri falan veririz yada başka bir şey eklemicem dersende expanded ile geri kalan tüm ekrana yayabilirsin birde padding widgetı içerisine alıp etrafından boşluk bırakabilirsin
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Placeholder(color: Colors.red,),
            ))
          ]),
    );
  }
}
