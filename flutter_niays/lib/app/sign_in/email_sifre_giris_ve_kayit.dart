import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_niays/common_widget/social_log_in_button.dart';
import 'package:flutter_niays/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class EmailveSifreLoginPage extends StatefulWidget {
  const EmailveSifreLoginPage({super.key});

  @override
  State<EmailveSifreLoginPage> createState() => _EmailveSifreLoginPageState();
}

class _EmailveSifreLoginPageState extends State<EmailveSifreLoginPage> {
  String? _email, _password;
  String? _buttonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  void _formSubmit(BuildContext context) {
    _formKey.currentState!.save();
    debugPrint("Email: $_email, Şifre: $_password");
    final _userModel = Provider.of<UserModel>(context, listen: false);
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız yok mu? Kayıt Olun"
        : "Hesabınız var mı? Giriş Yapın";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Giriş / Kayıt"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_pin_outlined,
                    size: 170,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    
                    onSaved: (newValue) {
                      _email = newValue;
                    },
                    keyboardType: TextInputType.emailAddress,
                    
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      hintText: "Email adresinizi giriniz",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: "Şifre",
                      hintText: "Şifrenizi giriniz",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SocialLoginButton(
                    buttonText: _buttonText!,
                    onPressed: () => _formSubmit(
                        context), //stefull widgetlarda context değerini göndermene de gerek yok heryerden erişebilirsin
                    buttonColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      _degistir();
                    },
                    child: Text(
                      _linkText!,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
