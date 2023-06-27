import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_niays/app/sign_in/email_sifre_giris_ve_kayit.dart';
import 'package:flutter_niays/common_widget/social_log_in_button.dart';
import 'package:flutter_niays/model/user_modell.dart';
import 'package:flutter_niays/viewmodel/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _misafirGirisi(context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    Users _user = await _userModel.signInAnonymously();
    if (_user != null) {
      debugPrint("Oturum açan user id: ${_user.userID.toString()}");
    }
  }

  // void _facebookIleGiris(BuildContext context) async{
  //   final _userModel = Provider.of<UserModel>(context, listen: false);
  //   Users? user = await _userModel.signInWithFacebook();
  //   if (user != null) {
  //     debugPrint("Oturum açan user id: ${user.userID.toString()}");
  //   }
  // }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    Users? _user = await _userModel.signInWithGoogle();
    if (_user != null) {
      debugPrint("Oturum açan user id: ${_user.userID.toString()}");
    }
  }

  void _emailVeSifreGiris(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => const EmailveSifreLoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        title: Text("NIAYS", style: GoogleFonts.aboreto(fontSize: 45)),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle_sharp,
                    size: 180,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      "Giriş Yap",
                      style: GoogleFonts.alice(fontSize: 45),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SocialLoginButton(
                      buttonText: "Google ile giriş yap ",
                      buttonColor: Colors.white,
                      textColor: Colors.black,
                      buttonIcon: Image.asset("images/google-logo.png"),
                      onPressed: () {
                        _googleIleGiris(context);
                      }),
                  SocialLoginButton(
                      buttonText: "Facebook ile giriş yap",
                      buttonColor: const Color(0xFF334D92),
                      buttonIcon: const Icon(
                        Icons.facebook,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  SocialLoginButton(
                    buttonIcon: const Icon(
                      Icons.email,
                      size: 30,
                      color: Colors.white,
                    ),
                    buttonText: 'Email ve şifre ile giriş yap',
                    onPressed: () {
                      _emailVeSifreGiris(context);
                    },
                    buttonColor: Colors.grey.shade500,
                  ),
                  SocialLoginButton(
                    onPressed: () => _misafirGirisi(context),
                    buttonText: 'Misafir girişi',
                    buttonColor: Colors.green,
                    textColor: Colors.white,
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  SocialLoginButton SocialLoginButtons(String metin, Color TextColor,
      Color ButtonColor, Widget? image, Function()) {
    return SocialLoginButton(
        buttonText: metin,
        buttonColor: ButtonColor,
        textColor: TextColor,
        buttonIcon: image,
        onPressed: Function());
  }

  Future<UserCredential> signInAnonymously() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }
}
