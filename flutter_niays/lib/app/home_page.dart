import 'package:flutter/material.dart';
import 'package:flutter_niays/locator.dart';
import 'package:flutter_niays/services/auth_base.dart';
import 'package:flutter_niays/services/firebase_auth_service.dart';
import 'package:flutter_niays/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../model/user_modell.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});

  Users user;

  AuthBase authServise = locator<FirebaseAuthServise>();

  @override
  Widget build(BuildContext context) {
final _userModel = Provider.of<UserModel>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Ana Sayfa"),
        actions: [
          FloatingActionButton(
            onPressed: () {
              _cikisYap(context);
            },
            backgroundColor: Colors.grey,
            elevation: 0,
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: user != null
              ? Text("Giriş Başarili ${user.userID}")
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context,listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }
}
