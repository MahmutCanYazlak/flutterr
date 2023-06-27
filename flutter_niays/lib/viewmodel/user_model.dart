//!privider ı import ettik
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_niays/locator.dart';
import 'package:flutter_niays/model/user_modell.dart';
import 'package:flutter_niays/repository/user_repository.dart';
import 'package:flutter_niays/services/auth_base.dart';

enum ViewState {
  Idle,
  Busy
} //user kısmında  ki view ın durumunu belirlemek için

class UserModel with ChangeNotifier implements AuthBase {
  userMNodel() {
    //ne zamanki bir nesne üretirsek kullanıcı var mı yok mu diye bakacak
    currentUser();
  }

  ViewState _state = ViewState.Idle;

  final UserRepository _userRepository = locator<UserRepository>(); //userModel UserReposity deki bazı alanları kullamak istiyor
  Users? _user;

  Users? get user => _user;

  set user(Users? value) {
    _user = value;
    notifyListeners(); //user değiştiğinde dinleyenleri haberdar etmek için
  }

  ViewState get state => _state;

  set state(ViewState value) {
    //_state değişkenine yeni değer atandığı zaman notifyListeners() metodu ile dinleyenleri haberdar ediyoruz.
    _state = value;
    notifyListeners();
  }

  @override
  Future<Users> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata$e");
      return Future.value(null);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Users> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki signInAnonymously user hata$e");
      return Future.value(null);
    } finally {
      //finally bloğu try catch bloğu çalışsa da çalışmasa da çalışır
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki signOut user hata$e");
      return Future.value(false);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Users> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki signInWithGoogle user hata$e");
      return Future.value(null);
    } finally {
    
      state = ViewState.Idle;
    }
  }
  
  @override
  Future<Users> signinWithPhoneNumber() async{
    
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signinWithPhoneNumber();
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki signinWithPhoneNumber user hata$e");
      return Future.value(null);
    } finally {
      //finally bloğu try catch bloğu çalışsa da çalışmasa da çalışır
      state = ViewState.Idle;
    }
  }
  
  @override
  Future<Users> createUserWithEmailandPassword(String email, String sifre) async{
   try {
      state = ViewState.Busy;
      _user = await _userRepository.createUserWithEmailandPassword(email, sifre);
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki createUserWithEmailandPassword user hata$e");
      return Future.value(null);
    } finally {
      state = ViewState.Idle;
    }
  }
  
  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) async{
     try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithEmailandPassword(email, sifre);
      return _user!;
    } catch (e) {
      debugPrint("Viewmodeldeki signInWithEmailandPassword user hata$e");
      return Future.value(null);
    } finally {
      state = ViewState.Idle;
    }
  }

  
  
  // @override
  // Future<Users> signInWithFacebook() async{
  //   try {
  //     state = ViewState.Busy;
  //     _user = await _userRepository.signInWithFacebook();
  //     return _user!;
  //   } catch (e) {
  //     debugPrint("Viewmodeldeki signInWithFacebook user hata$e");
  //     return Future.value(null);
  //   } finally {
  //     //finally bloğu try catch bloğu çalışsa da çalışmasa da çalışır
  //     state = ViewState.Idle;
  //   }
  // }


  }