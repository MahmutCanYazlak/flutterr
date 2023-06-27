import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Mahmut Can Yazlak"),
                accountEmail: const Text("canmahmutyazlak@gmail.com"),
                currentAccountPicture: Image.network(
                    "https://e7.pngegg.com/pngimages/666/815/png-clipart-dart-google-chrome-web-application-flutter-darts-blue-angle.png"),
                otherAccountsPictures: const [
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Text("MC"),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text("CY"),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Ana Sayfa"),
                        trailing: Icon(Icons.chevron_right_outlined),
                      ),
                    ),
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Ara"),
                        trailing: Icon(Icons.chevron_right_outlined),
                      ),
                    ),
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.account_box),
                        title: Text("Profil"),
                        trailing: Icon(Icons.chevron_right_outlined),
                      ),
                    ),
                    const Divider(),
                    //İNKWELL : dedector gibi tıklanma olayları atayabiliyorsun
                    InkWell(
                      onTap: () {
                        return;
                      },
                      splashColor: Colors.red,
                      child: const Card(
                        child: ListTile(
                          leading: Icon(Icons.home),
                          title: Text("Ana Sayfa"),
                          trailing: Icon(Icons.chevron_right_outlined),
                        ),
                      ),
                    ),
                    const Divider(),
                    //AboutListTile ile projemizde kullandığımız ürünlerin lisanslarını görüntüleyebiliyorsun
                    const AboutListTile(
                      applicationName: "Flutter Dersleri",
                      applicationIcon: Icon(Icons.save),
                      applicationVersion: "2.12.25",
                      child:Text('ABOUT US'),
                      applicationLegalese: null,
                      icon: Icon(Icons.keyboard),
                      aboutBoxChildren: [
                        Text("Ürün 1"),
                        Text("Ürün 1"),
                        Text("Ürün 1"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
  }
}