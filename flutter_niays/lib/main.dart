import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_niays/app/landing_page.dart';
import 'package:flutter_niays/locator.dart';
import 'package:flutter_niays/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

void main() async {
  //bu kısmları videodan izlenip kuruldu
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "NİAYS",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: ChangeNotifierProvider(
          create: (context) => UserModel(),//ağacımıza burada UserModel i ekledik ve bu sayede tüm ağaç UserModel i kullanabilecek ve burda ki değişikliklere görede arayüzümü güncelleyebilirim
          child:  LandingPage(),
        ));
  }
}
