//kullanıcı ile İlgili işlemlerin yapılacağı hangi kaynağın seçileceği gerekli mantıkların kurulacağı yer burasıdır.

import 'package:flutter_niays/locator.dart';
import 'package:flutter_niays/model/user_modell.dart';
import 'package:flutter_niays/services/auth_base.dart';
import 'package:flutter_niays/services/fake_auth_service.dart';
import 'package:flutter_niays/services/firebase_auth_service.dart';
 
enum AppMode { DEBUG, RELEASE }
 
//burada karar vereceğimiz için AuthBase içindeki fonskiyonların burada da tanımlanması gerekiyor
class UserRepository implements AuthBase {


   final FirebaseAuthServise _firebaseAuthServise = locator<FirebaseAuthServise>();
   final FakeAuthService _fakeAuthService = locator<FakeAuthService>();


 
  AppMode appMode = AppMode.RELEASE;
 
  @override
  Future<Users> currentUser() async{
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      return await _firebaseAuthServise.currentUser();
    }
  }
 
  @override
  Future<Users> signInAnonymously() async{
  if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      return await _firebaseAuthServise.signInAnonymously();
    }
  }
 
  @override
  Future<bool> signOut() async{
   if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthServise.signOut();
    }
  }
  
  @override
  Future<Users> signInWithGoogle() {
    if (appMode == AppMode.DEBUG) {
      return _fakeAuthService.signInWithGoogle();
    } else {
      return _firebaseAuthServise.signInWithGoogle();
    
      
    }
  }
  
  @override
  Future<Users> signinWithPhoneNumber() {
    if (appMode == AppMode.DEBUG) {
      return _fakeAuthService.signinWithPhoneNumber();
    } else {
      return _firebaseAuthServise.signinWithPhoneNumber();
    }
  }
  
  @override
  Future<Users> createUserWithEmailandPassword(String email, String sifre) {
     if (appMode == AppMode.DEBUG) {
      return _fakeAuthService.createUserWithEmailandPassword(email, sifre);
    } else {
      return _firebaseAuthServise.createUserWithEmailandPassword(email, sifre);
    }
  }
  
  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) {
    if (appMode == AppMode.DEBUG) {
      return _fakeAuthService.signInWithEmailandPassword(email, sifre);
    } else {
      return _firebaseAuthServise.signInWithEmailandPassword(email, sifre);
    }
  }


  
  
  // @override
  // Future<Users> signInWithFacebook() {
  //       if (appMode == AppMode.DEBUG) {
  //     return _fakeAuthService.signInWithFacebook();
  //   } else {
  //     return _firebaseAuthServise.signInWithFacebook();
    
      
  //   }
  // }
}