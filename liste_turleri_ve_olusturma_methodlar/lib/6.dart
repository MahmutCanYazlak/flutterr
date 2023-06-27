import 'package:flutter/material.dart';

class ListviewLayoutProblemleri extends StatelessWidget {
  const ListviewLayoutProblemleri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Layout Problems"),
      ),
      body: Container(
        //EĞER gidip listView ı bir column içine alırsan Listview ın içi doldu olmasına rağmen emülatörde boş bir ekran gelir bunun sebebi Column çalışma mantığından kaynaklanır columnun genişliği ve yüksekliği belirli column derki children olarak gelen elemanların boyutları kadar o elemana yer ayırayım mesela text geldi boyutu 200 belli container geldi boyutu 300 belli bunlara yer verir listview e sorar senin boyutun ne kadar listview arsızdır ve infinity bütün hespini almak ister column da bunun nerde biteceğini bilemez ve listviewden sonra gelecek elemanı nereye koyacağını bilemez container da bu sorunu yaşamamazın sebebi conrainer çocuk alır column çocuklar alır belli boyuttadır ve içine alacağı elemanların boyutunu bilmek isterki ondan sonraki çocuğun nereye geleceğini bilsin ona göre yerleştirsin bu sorunu çözmek için listView ı expanded içine alırız yani artık listView da boyutu belli deriz diğer elamnalardan sonra kalan boşluğuna kadar yayılmak istiyorum deriz mantıken zaten hata olarakta debug consolede en üstte given unbounded height bunu der. Bu hatanın diğer çözüm yolu shrinkWrap: true, bunu aktif etmek içindeki elemanlar kadar yer kapla demek yani boşluğa yayılmicak artık ama bunda da şu sorun olabilir sığmama sorunu olabilir levha hatası
        //aynı işlem satır içinde geçerli satırlarda da bu sorun var ve çözümü aynı

        child: Container
        (
          height: 200,
          child: Row(children: [
            Text("başladı"),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    color: Colors.orange.shade200,
                  ),
                  Container(
                    width: 200,
                    color: Colors.orange.shade400,
                  ),
                  Container(
                    width: 200,
                    color: Colors.orange.shade400,
                  )
                ],
              ),
            ),
            Text("bitiş"),
          ]),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.yellow),
        ),
      ),
    );
  }

  Column ColumnIcindeListe() {
    return Column(
      children: [
        Text("başladı"),
        Expanded(
          child: ListView(
            //container içinde child varsa çocuğu kadar yer tutar çocuğu yoksada parent ı kadar yer tutar içine listView olacak şekilde çocuk tanımlayalım listVieinde içine bir çocuk container tanımlayalım ve incelediğimiz zaman listView ekranın tamamını kaplamış ama çocuk olan container ekranın 3 te 1 eğer listView ın sadece çocuklarının olduğu yeri kaplamasını istiyorsak  shrinkWrap: true deriz ve böylelikle LİstView ekranın tamamını değil içindeki çocukların kapladığı yeri kapsar listViewın dışındaki Container da böylelikle ekranın tamamını değil listView ın boyutu kadar yer tutar yani özetle shrinkWrap: true ise listWiev çocukları kadar yer kaplar false ise parent ı kadar yer kaplar given unbounded height bu hatayı almak için bu özelliği yorum satırı yaptık

            //shrinkWrap: true,
            children: [
              Container(
                height: 200,
                color: Colors.orange.shade200,
              ),
              Container(
                height: 200,
                color: Colors.orange.shade400,
              )
            ],
          ),
        ),
        Text("bitti"),
      ],
    );
  }
}
