// ignore_for_file: await_only_futures, null_check_always_fails, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_niays/services/auth_base.dart';
import '../model/user_modell.dart';

import 'package:google_sign_in/google_sign_in.dart'; //!google_sign_in paketini import ettik

class FirebaseAuthServise implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Users> currentUser() async {
    try {
      User user = await _firebaseAuth.currentUser!;
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint("HATA CURRENT USER : $e");
      return null!;
    }
  }

  @override
  Future<Users> signInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user!);
    } catch (e) {
      debugPrint("HATA SIGN IN ANONYMOUSLY : $e");
      return null!;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut(); //google hesabından da çıkış yapmak için
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("HATA SIGN OUT : $e");
      return false;
    }
  }

  @override
  Future<Users> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? _googleUser = await googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication? _googleAuth =
          await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User? _user = sonuc.user;
        return _userFromFirebase(_user!);
      } else {
        return null!;
      }
    } else {
      return null!;
    }
  }

  //bu sınıftaki ovveride fonksiyonları bizlerden Users türünde veri bekliyor fakat currentUser bize User türünde verir aşağıdaki fonksiyon bu iki türü birbirine çevirir ve böylece benim uygulamamda  kullanacağım yapı Firebase değilde Users olur
  Users _userFromFirebase(User user) {
    if (user == null) {
      return null!;
    } else {
      return Users(userID: user.uid);
    }
  }

  @override
  Future<Users> signinWithPhoneNumber() async {
     User? _user = await FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.verifyPhoneNumber(                
      phoneNumber: '+905378969957',
      verificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint("verification completed tetiklendi");
        UserCredential _sonuc=  await _firebaseAuth.signInWithCredential(credential);
        _user = _sonuc.user;
        
        
      },
      verificationFailed: (FirebaseAuthException e) {
      },
      codeSent: (String verificationId, int? resendToken) async {
        debugPrint("codeSent tetiklendi");
        String _smsCode = "440931"; 

        var _credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: _smsCode);

        UserCredential _sonuc= await _firebaseAuth.signInWithCredential(_credential);
         _user = _sonuc.user;
     
      },
      codeAutoRetrievalTimeout: (String verificationId) {
         debugPrint("code auto retrieval timeout");
         
      },
    );
      if(_user != null)
      {
        return _userFromFirebase(_user!);
      }
      else{
        return null!;
      }
      
  }
  
  @override
  Future<Users> createUserWithEmailandPassword(String email, String sifre) async{
    try {
      UserCredential sonuc = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user!);
    } catch (e) {
      debugPrint("HATA CREATE USER : $e");
      return null!;
      
    }
  }
  
  @override
  Future<Users> signInWithEmailandPassword(String email, String sifre) async{
    try {
      UserCredential sonuc = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user!);
    } catch (e) {
      debugPrint("HATA SIGN IN USER : $e");
      return null!;
    }
  }

  // @override
  // Future<Users> signInWithFacebook() async{
  //    final _faceboolLogin = FacebookLogin();
  //    FacebookLoginResult _faceResult =await _faceboolLogin.logIn(['public_profile', 'email']);//facebooktan hangi bilgileri almak istiyorsak onları yazıyoruz
  //     switch (_faceResult.status) {
  //       case FacebookLoginStatus.loggedIn:
  //         if(_faceResult.accessToken != null && _faceResult.accessToken!.token != null){
  //           UserCredential _firebaseResult = await _firebaseAuth.signInWithCredential(FacebookAuthProvider.credential(_faceResult.accessToken!.token));
  //           User? _user = _firebaseResult.user;
  //           return _userFromFirebase(_user!);
  //         }
  //         break;
  //       case FacebookLoginStatus.cancelledByUser:
  //         print("Kullanıcı facebook girişi iptal etti");

  //         break;
  //       case FacebookLoginStatus.error:
  //         print("Hata çıktı : ${_faceResult.errorMessage}");

  //         break;
  //     }
  //     return null!;

  // }
}
