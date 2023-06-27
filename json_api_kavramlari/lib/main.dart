//!JSON: büyük verilerimizi string türünde tutmamızı sağlayan bir formattır.
//!APİ : Json türünde veriler saklayan veri kaynağıdır

 import 'package:flutter/material.dart';
import 'package:json_api_kavramlari/1_local_json.dart';
import 'package:json_api_kavramlari/5_remote_api.dart';
 
 void main() => runApp(const MyApp());
 
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   @override
   Widget build(BuildContext context) {
     return const MaterialApp(
       title: 'Material App',
       home: MyHomePage()
     );
   }
 }

 class MyHomePage extends StatelessWidget {
   const MyHomePage({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
           title: const Text('Http Json'),
         ),
         body:  Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green), 
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocalJson(),));
            },
             child:const Text("Local Json"),),
             ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange), 
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>RemoteApi(),));
            },
             child:const Text("Remote APİ"),)
           ]),
         ),
       );
   }
 }
