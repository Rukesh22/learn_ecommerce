import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_ecommerce/features/screens/login/login.dart';
import 'package:learn_ecommerce/features/screens/onboarding.dart';
import 'package:learn_ecommerce/features/screens/signup/verify_email.dart';
import 'package:learn_ecommerce/navigation_menu.dart';
import 'package:learn_ecommerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:learn_ecommerce/utils/exceptions/platform_exceptions.dart';

class AutenticationRepository extends GetxController {
  static AutenticationRepository get instance => Get.find();

  //Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Called from main.dart an app launch

  // Note to use the override you have to click @override dispose => void otherwise it will not initilize
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //Function to show relevant screen
 //Function to show relevant screen
  screenRedirect() async {
    final user=_auth.currentUser;
    if(user != null)
    {
      if(user.emailVerified)
      {
        Get.offAll(()=> const NavigationMenu());
      }
      else
      {
        Get.offAll(()=>VerifyEmailScreen(email:_auth.currentUser?.email));
      }
      
    } else{
          //Local Storage
    deviceStorage.writeIfNull('IsFirstTime', true);
    //Check if it's the first time launching the app
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
      }
    
}


//Email - Login

Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// EmailAuthentication - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // LogoutUser -Valid for any autentication
Future<void> logout() async {
  try{
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  } on FirebaseAuthException catch (e) {
    throw TFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message; 
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    if (kDebugMode) print('Something Went Wrong: $e');
  }
}                        
}
