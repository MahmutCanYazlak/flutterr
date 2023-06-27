import 'package:flutter/material.dart';

class TabOrnek extends StatefulWidget {
  const TabOrnek({super.key});

  @override
  State<TabOrnek> createState() => _TabOrnekState();
}

//with SingleTickerProviderStateMixin sonradan eklendi
class _TabOrnekState extends State<TabOrnek>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //vsync: tablar arasında geçilirken uygulanacak animasyon tab ların kullanımıana bakarsak class _TabOrnekState extends State<TabOrnek> WİTDH width diyip SingleTickerProviderStateMixin böyle bir yapı görürüz witdh anahtar kelimesiyle çoklu kalıtıma izin verilmez demiştik ama bu witdh kullanarak diğer sınıdların özeliklerlirini yine sınıflara aktarabiliyoruz animasyonlar kısmında öğreneceğiz
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab Kullanimi"),
        //BUTTOM: prefferried Size Widget olarak ya tappBar kullanılabilir yada appBar kullanılanilir ikiside prefferried size widget boyutu belli olan demek
        bottom: tabBarim(),
      ),

      //bottomNavigationBar a tabBar ımızıda atayabiliriz fakat rengi beyaz oldu bunun rengini aşağıda ayarlayacağız fakat farklı bie TabBar üzerinden ayarlayacağız sebebi: rengini ayarlamak için tabbar ı bir container içine alacağız eğer ki aynı tabbar ı kullansaydık yukardaki bottom hata verirdi çünkü o bizden prefferried size istiyor sen ona containera alsaydın doğrudan stetles widget gönderiyorrsun
      bottomNavigationBar: tabBarimBottom(),

      //tablara göre body kısmını değiştirmek için TabBarView kullanıyoruz
      //burada tab lara tıklamamıza göre body kısmının değişmesi için aşağıda TabBar a verdiğimiz controllerı burayada tanımlıyoruz
      body: TabBarView(controller: tabController, children: [
        //bu containerım tab 1 ile açılacak olan sayfam çünkü 0. indexte
        Container(
          color: Colors.redAccent,
          child: const Center(
            child: Text(
              "TAB 1",
              style: TextStyle(fontSize: 48),
            ),
          ),
        ),
        Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text(
              "TAB 2",
              style: TextStyle(fontSize: 48),
            ),
          ),
        ),
        Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text(
              "TAB 3",
              style: TextStyle(fontSize: 48),
            ),
          ),
        )
      ]),
    );
  }

  TabBar tabBarim() {
    return TabBar(controller: tabController, tabs: const [
      //Tab da bir widget
      //Tab(icon:const Icon(Icons.access_alarm_rounded), text: "Tab 1", child:const Text("Child 1 "),),//burda hata alırız eğer text verdiysen child vermicen , child verdiysen text vermicen

      Tab(
        icon: Icon(Icons.account_box_sharp),
        text: "Tab 1",
      ),
      Tab(icon: Icon(Icons.add_location), text: "Tab 2"),
      Tab(icon: Icon(Icons.access_alarm_rounded), text: "Tab 3"),
    ]);
  }

  Widget tabBarimBottom() {
    return Container(
      color: Colors.black,
      child: TabBar(controller: tabController, tabs: const [
        //Tab da bir widget
        //Tab(icon:const Icon(Icons.access_alarm_rounded), text: "Tab 1", child:const Text("Child 1 "),),//burda hata alırız eğer text verdiysen child vermicen , child verdiysen text vermicen
    
        Tab(
          icon: Icon(Icons.account_box_sharp),
          text: "Tab 1",
        ),
        Tab(icon: Icon(Icons.add_location), text: "Tab 2"),
        Tab(icon: Icon(Icons.access_alarm_rounded), text: "Tab 3"),
      ]),
    );
  }
}
