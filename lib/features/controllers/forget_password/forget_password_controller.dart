
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/features/controllers/signup/signup_controller.dart';
import 'package:learn_ecommerce/features/screens/password/reset_password.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';


class FPasswordController extends GetxController{
  static FPasswordController get instance => Get.find();
  //Variables
  final email = TextEditingController();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  //EMail amd Password Signin
  Future<void> forgetPasswordSignIn() async {
    try {
      //Strat Loading
      TFullScreenLoader.openLoadingDialog('Processing your request....', TImages.docerAnimation);

      //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }

    //Form validation
    if (!passwordFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    //Send Enail to reset Password
    await AutenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

    //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success sceen
      TLoaders.successSnabar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      //Rdirecct
      Get.to(() => ResetPassword(email: email.text.trim()));

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing your request....', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {TFullScreenLoader.stopLoading(); return;}


      //Send Enail to reset Password
      await AutenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success screen
      TLoaders.successSnabar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

    }
    catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

    }
  }

}
