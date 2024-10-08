import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_ecommerce/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'firebase_options.dart';


Future<void> main() async {
  //  Add Widgets Binding
final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

// Init GetX Local Storage
  await GetStorage.init();

// Await Native Splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AutenticationRepository()),
  );

  
  runApp(const App());
  


}