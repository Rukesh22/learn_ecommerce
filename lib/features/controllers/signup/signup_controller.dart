import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/data/models/user_models.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/data/repositories/user_repository.dart';
import 'package:learn_ecommerce/features/screens/signup/verify_email.dart';
import 'package:learn_ecommerce/utils/constants/colors.dart';
import 'package:learn_ecommerce/utils/constants/sizes.dart';
import 'package:learn_ecommerce/utils/helpers/helper_functions.dart';
import 'package:learn_ecommerce/utils/helpers/network_manager.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';
import 'package:lottie/lottie.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //Variables
  final hidePassword = true.obs;
  final privacypolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //Signup
  void signup() async {
    try {

      TFullScreenLoader.openLoadingDialog('We are');


    //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }
    
    

    //Form validation
    if (!signupFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }
       

    //Privacy Policy Check
    if(!privacypolicy.value) {
      TLoaders.warningSnackBar(title: 'Accept Privacy Policy',
      message: 'In order to create account, you must have to read and accept the privacy policy & Terms of use');
      return;
    }

    //register user in the firebase autentication & save user data in the firebase
    final userCredential = await AutenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

    //save authenticated user daat in the firebase firestore
    final newUser = UserModel(id: userCredential.user!.uid,
    username: username.text.trim(),
    firstName: firstName.text.trim(),
    lastName: lastName.text.trim(),
    email: email.text.trim(),
    phoneNumber: phoneNumber.text.trim(),
    profilePicture: '',
    );

    final userRepository = Get.put(UserRepository());
    userRepository.saveUserRecord(newUser);

    TFullScreenLoader.stopLoading();

    //Show Success Message
    TLoaders.successSnabar(title: 'Congragulations', message: 'Your account has been created! Verify your email to continue.');




    //Move to verify email screen
    Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {

      TFullScreenLoader.stopLoading();
       //some generic error to the user
    TLoaders.errorSnackBar(title:'on snap',message:e.toString());

    }
  }
}

class TFullScreenLoader {

  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          
        )
        )
        );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
  super.key,
  required this.text,
  required this.animation,
  this.showAction=false,
  this.actionText,
  this.onActionPressed,
  });

  final String text;
  final String  animation;
  final bool showAction;
  final String? actionText;

  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), //0
        const SizedBox(height: TSizes.defaultSpace),
        Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ), // Text
          const SizedBox(height: TSizes.defaultSpace),
          showAction
          ? SizedBox(
            width: 250,
            child: OutlinedButton(
            onPressed: onActionPressed,
            style: OutlinedButton.styleFrom(backgroundColor:TColors.dark),
            child:Text(actionText!,
      style:Theme.of(context).textTheme.bodyMedium!.apply(color:TColors.light)
      ),//tcxt
    ),//outlinedButton
  )//sizedBox

  :const SizedBox(),
      ],
      ),
    );
  }
}