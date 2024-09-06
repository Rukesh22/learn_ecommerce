
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/features/controllers/signup/signup_controller.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';

class LoginController extends GetxController{

  //Variables
  final email = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //EMail amd Password Signin
  Future<void> emailandPasswordSignIn() async {
    try {
      //Strat Loading
      TFullScreenLoader.openLoadingDialog('Logging you in');

      //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }
    
    

    //Form validation
    if (!loginFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    //Save data if remeber me is selected
    if(rememberMe.value) {
      localStorage.write('REMEBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }

    // Login user using Email & Password
    final userCredential = await AutenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

    //Remove Loader
    TFullScreenLoader.stopLoading();

    //Redirect
    AutenticationRepository.instance.screenRedirect();

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}