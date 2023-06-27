import 'package:flutter_niays/services/auth_base.dart';

import '../model/user_modell.dart';

class FakeAuthService implements AuthBase {
  //sanki arkadaşımız backend ile uğraşıyor ama işlemleri uzun sürecek onu beklememek için bizde fake bir servis oluşturduk
  String userID = "4431090201";
  @override
  Future<Users> currentUser() async{
    return await Future.value(Users(userID: userID));
  }

  @override
  Future<Users> signInAnonymously() async{
    return await Future.delayed(
        const Duration(seconds: 2), () => Users(userID: userID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }
  
  @override
  Future<Users> signInWithGoogle() {
    return Future.value(Users(userID: "google_user_id_123456"));
  }
  
  // @override
  // Future<Users> signInWithFacebook() {
  //   // TODO: implement signInWithFacebook
  //   throw UnimplementedError();
  // }
  
  @override
  Future<Users> signinWithPhoneNumber() {
    return Future.value(Users(userID: "phone_user_id_123456"));
  }
  
  @override
  Future<Users> createUserWithEmailandPassword(String email, String sifre) {
   return Future.value(Users(userID: "created_user_id_123456"));
  }
  
  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) {
    return Future.value(Users(userID: "sign_in_user_id_123456"));
  }
}
