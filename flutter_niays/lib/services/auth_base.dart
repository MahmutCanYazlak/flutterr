
import 'package:flutter_niays/model/user_modell.dart';
abstract class AuthBase {
  Future<Users> currentUser();
  Future<Users> signInAnonymously();
  Future<bool> signOut();

  //!google_sign_in paketini import ettik
  Future<Users> signInWithGoogle();
  //!flutter_facebook_login paketini import ettik
  //Future<Users> signInWithFacebook();
  Future<Users> signinWithPhoneNumber();
  Future<Users> signInWithEmailandPassword(String email, String sifre);
  Future<Users> createUserWithEmailandPassword(String email, String sifre);

  
 
}