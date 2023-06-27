import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_api/detay_sayfasi.dart';
import 'package:flutter_market_api/model/detay_model.dart';
import 'package:flutter_market_api/model/products_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//!Products
Future<List<Products>> _getUrunler() async {
  try {
    
    var response = await Dio().get("https://fakestoreapi.com/products");
    List<Products> _userList = [];
    if (response.statusCode == 200) {
      _userList =(response.data as List).map((e) => Products.fromMap(e)).toList();
    } else {
      _userList = [];
    }
    return _userList;
  } on DioError catch (e) {
    return Future.error(e);
  }
}

class _MyAppState extends State<MyApp> {
  late Future<List<Products>> urunGetir;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urunGetir = _getUrunler();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Market Ana Sayfa'),
        ),
        body: Center(
            child: FutureBuilder(
          future: urunGetir,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var urunListesi = snapshot.data!;
              return ListView.builder(
                itemCount: urunListesi.length,
                itemBuilder: (context, index) {
                  var urun = urunListesi[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return UrunDetaySayfasi(urun.id);
                      },              
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        trailing: Image(image: NetworkImage(urun.image)),
                        leading: CircleAvatar(child: Text(urun.id.toString())),
                        subtitle: Text(urun.price.toString()),
                        title: Text(urun.title),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("veri yok");
            }
          },
        )),
      ),
    );
  }
}
