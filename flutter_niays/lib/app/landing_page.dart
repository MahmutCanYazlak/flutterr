// ignore_for_file: await_only_futures

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_niays/app/home_page.dart';

import 'package:flutter_niays/app/sign_in/sign_in_page.dart';
import 'package:flutter_niays/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  /* final AuthBase
      authServise; //!normalde buranın veri tipi FirebaseAuthServise ti fakat bunların ana sınıfı olan AuthBase i kullandık böylece ilerde herhangi bir değişiklik olduğunda sadece burayı değiştirmemiz yeterli olacak
  const LandingPage({
    super.key,
    required this.authServise,
  }); */
  
  @override
  Widget build(BuildContext context) {

    final _userModel = Provider.of<UserModel>(context);

    //state methoduu çağırarak _state değişkenine değer atıyoruz ve ordaki notifyListeners() metodu ile dinleyenleri haberdar ediyoruz.
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(
          user: _userModel.user!       
        );
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
