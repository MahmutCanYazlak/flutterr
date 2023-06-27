import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_api_kavramlari/model/5_user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({super.key});

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserList() async{
    try {
      //Dio verilen path e gitmeye çalışacakve getirdiği verileri response diye bu değişkeninin içine atacak 
      var response =await Dio().get("https://jsonplaceholder.typicode.com/users");

      //kontroller yapabiliriz
      //200 başarılı demek 
      List<UserModel> _userList = [];
      //bu kod sürekli değişir kodu öğrenmek için api aldığın yeri incele de ve networkü seç ordan status code görürsün
      if(response.statusCode==200)
      {
        //benim response içinde verimin bulunduğu kısım data kısmıdırresponse.data
        //local de yapmış olduğumuz örnekte data string olarak geliyordu biz onu jsonDecode diyerek json formatına çeviriyordık dio da bu bize jsonDecode yapılmış hali veriyor 
       _userList = (response.data as List).map((e) => UserModel.fromMap(e)).toList();
       //bu fonskiyonumuzu amacı içinde geriye içinde UserModel ler bulunan bir List e döndermekti burda da bunu yaptık
      }
      return _userList;
      
    }
     on DioError catch (e) {    
      return Future.error(e);
    }
  }

  late final Future<List<UserModel>> userGetir ;

  @override
  void initState() {
    // TODO: implement initState
    userGetir = _getUserList();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Remmote Api with Dio',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Remmote Api with Dio'),
        ),
        body:  Center(
          child:FutureBuilder<List<UserModel>>(
            future: userGetir,
            builder: (context, snapshot) {
           if (snapshot.hasData) {
             var userList = snapshot.data!;
             return ListView.builder(
               itemCount: userList.length,
               itemBuilder: (BuildContext context, int index) {
                var user = userList[index];
                 return ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.address.toString()),
                  //user adressler instanse hatasını aldık bunun için 5_user_modeol.dart dosyamıza gidip adress kısmındaki verileri seçip ampül kısmında generateToString diyorsun tabi bunun için vsCode Dart Data Class Generator eklentisini kuruyorsun
                  leading: Text(user.id.toString()),
                 );
               },
             );
           }
           else if(snapshot.hasError)
           {
            return Text(snapshot.error.toString());
           }
           else
           {
            return CircularProgressIndicator();
           }

          },),
        ),
      ),
    );
  }
}
