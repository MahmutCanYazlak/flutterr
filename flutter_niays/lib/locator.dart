//!get_it paketini import ettik
import 'package:flutter_niays/repository/user_repository.dart';
import 'package:flutter_niays/services/fake_auth_service.dart';
import 'package:flutter_niays/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance; //gidip mainde setupLocator fonksiyonunu çağırmamız gerekiyor

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthServise());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => UserRepository());
}